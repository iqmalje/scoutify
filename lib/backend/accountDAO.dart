import 'dart:io';

import 'package:scoutify/model/account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountDAO {
  var supabase = Supabase.instance.client;
  static bool isAdminToggled = false;

  Future<Account> selectAccountFromIC(String ICno) async {
    var data =
        await supabase.from('accounts').select('*').eq('ic_no', ICno).single();
    print(data);
    // parse into acc
    Account account = Account(data);
    if (account.is_activated) throw Exception('Account is already activated!');
    return account;
  }

  Future<Account> getProfileInfo() async {
    var userid = supabase.auth.currentUser!.id;
    var data =
        await supabase.from('accounts').select('*').eq('accountid', userid);

    return Account(data[0]);
  }

  Future<Account> getOtherProfile(String accountid) async {
    var data =
        await supabase.from('accounts').select('*').eq('accountid', accountid);

    return Account(data[0]);
  }

  /// Sign in the user to the application, will auto login
  /// So the user wont have to login everytime.
  Future<bool> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(password: password, email: email);
      //on sign in, just set the var to false
      isAdminToggled = false;
      return true;
    } catch (e) {
      if (e.toString().contains('login credentials')) {
        throw Exception("Invalid login credentials");
      }

      rethrow;
    }
  }

  /// Send an OTP to user's email for forgot password
  Future<void> sendPasswordOTP(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  /// Will sign out user, and the user will have to relogin
  /// when opening the app again later.
  Future<void> signout() async {
    await supabase.auth.signOut();
  }

  Future<void> updateAccount(Account account) async {
    await supabase.from('accounts').update({
      'email': account.email,
      'phoneno': account.phoneno,
    }).eq('accountid', account.accountid);
  }

  /// This function may accept any file, but please properly pass it through CroppedFile implementation
  /// to ensure the picture selected is perfect
  /// Returns new path of the image
  Future<String> updateDigitalPicture(File file) async {
    String userid = supabase.auth.currentUser!.id;

    try {
      await supabase.storage
          .from('profile_pic')
          .upload('$userid/profilepic.png', file);
    } catch (e) {
      // file has already existed
      await supabase.storage
          .from('profile_pic')
          .update('$userid/profilepic.png', file);
    }

    //get url
    String profileurl = supabase.storage
        .from('profile_pic')
        .getPublicUrl('$userid/profilepic.png');

    // update profile to db
    await supabase
        .from('accounts')
        .update({'image_url': profileurl}).eq('accountid', userid);

    print('UPDATED = ');
    return profileurl;
  }

  Future<void> updateDisplayName(String displayName) async {
    String userid = supabase.auth.currentUser!.id;

    await supabase
        .from('accounts')
        .update({'card_name': displayName}).eq('accountid', userid);
  }

  Future<bool> verifyPasswordOTP(String email, String OTP) async {
    try {
      var data = await supabase.auth
          .verifyOTP(email: email, token: OTP, type: OtpType.recovery);

      if (data.session != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Token has expired or is invalid");
    }
  }

  Future<void> updatePassword(String email, String password) async {
    try {
      UserResponse userResponse = await supabase.auth
          .updateUser(UserAttributes(email: email, password: password));
      await supabase
          .from('accounts')
          .update({'activated': true}).eq('accountid', userResponse.user!.id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> getScoutDetails(String scoutid) async {
    var data = await supabase
        .from('accounts')
        .select(
            'no_ahli, no_tauliah, unit, daerah,  is_member,position, image_url')
        .eq('accountid', scoutid)
        .single();

    return data;
  }

  Future<List<dynamic>> getAttendance(String activityid, {String? id}) async {
    var data = await supabase.from('attendance').select('*').match({
      'activityid': activityid,
      'accountid': id ?? supabase.auth.currentUser!.id
    });

    return data;
  }

  Future<void> addAttendanceByScoutID(String activityid, String scoutID) async {
    try {
      var accid = await supabase
          .from('accounts')
          .select('accountid, fullname')
          .eq('no_ahli', scoutID)
          .single();

      print(accid);

      await supabase.from('attendance').insert({
        'activityid': activityid,
        'accountid': accid['accountid'],
        'fullname': accid['fullname'],
        'attendancekey':
            '${accid['accountid']}.${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}.$activityid'
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addAttendance(String activityid, String cardid) async {
    //get accountid from cardid

    try {
      if (cardid[0] == 'J' || cardid[0] == 'K') {
        await addAttendanceByScoutID(activityid, cardid);
        return;
      }

      var accid = await supabase
          .from('accounts')
          .select('accountid, fullname')
          .match({'cardid': cardid}).single();
      print(accid);
      await supabase.from('attendance').insert({
        'activityid': activityid,
        'accountid': accid['accountid'],
        'fullname': accid['fullname'],
        'attendancekey':
            '${accid['accountid']}.${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}.$activityid'
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> getAllAttendees(
      String activityid, DateTime timeAttend) async {
    List<dynamic> item = [];
    print(
        "aid = $activityid, time_attend = ${'${timeAttend.year}-${timeAttend.month.toString().padLeft(2, '0')}-${timeAttend.day.toString().padLeft(2, '0')}%'}");
    item = await supabase.rpc('get_all_attendances', params: {
      'aid': activityid,
      'time_attend':
          '${timeAttend.year}-${timeAttend.month.toString().padLeft(2, '0')}-${timeAttend.day.toString().padLeft(2, '0')}%'
    });
    print("dah");
    return item;
  }
}
