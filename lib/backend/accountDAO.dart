import 'dart:io';

import 'package:scoutify/model/account.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/model/scoutinfo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountDAO {
  var supabase = Supabase.instance.client;

  Future<Account> selectAccountFromIC(String ICno) async {
    var data = await supabase
        .from('accounts')
        .select('ic_no, email, fullname, accountid, activated')
        .eq('ic_no', ICno)
        .single();

    // parse into acc
    Account account = Account();
    account.accountid = data['accountid'];
    account.icNo = data['ic_no'];
    account.email = data['email'];
    account.fullname = data['fullname'];
    account.activated = data['activated'];
    if (account.activated) throw Exception('Account is already activated!');
    return account;
  }

  // no longer in use since usage of Singleton
  // Future<Account> getProfileInfo() async {
  //   // return current user profile
  //   var userid = supabase.auth.currentUser!.id;
  //   var data =
  //       await supabase.from('accounts').select('*').eq('accountid', userid);

  //   Account account = Account.parse(data[0]);

  //   // fetch scout info

  //   var scoutInfo = await supabase
  //       .from('scouts')
  //       .select('*')
  //       .eq('accountid', account.accountid)
  //       .single();

  //   account.scoutInfo = ScoutInfoModel.parse(scoutInfo);

  //   return account;
  // }

  Future<Account> getOtherProfile(String accountid) async {
    var data =
        await supabase.from('accounts').select('*').eq('accountid', accountid);

    Account account = Account.parse(data[0]);

    // fetch scout info

    var scoutdata = await supabase
        .from('scouts')
        .select('*')
        .eq('accountid', accountid)
        .single();

    account.scoutInfo = ScoutInfoModel.parse(scoutdata);

    return account;
  }

  /// Sign in the user to the application, will auto login
  /// So the user wont have to login everytime.
  Future<bool> signIn(String email, String password) async {
    AuthResponse auth = await supabase.auth
        .signInWithPassword(password: password, email: email);
    //on sign in, just set the var to false

    print(auth.user!.role);

    // fill in CurrentAccount
    var data = await supabase
        .from('accounts')
        .select('*')
        .eq('accountid', auth.user!.id)
        .single();
    print('KAT SINI DAPAT DO WEHH');
    var scoutdata = await supabase
        .from('scouts')
        .select('*')
        .eq('accountid', auth.user!.id)
        .single();

    print('KAT SCOUT DAPAT DO WEHH');

    ScoutInfoModel scoutInfoModel = ScoutInfoModel.parse(scoutdata);

    CurrentAccount ca = CurrentAccount.getInstance();

    ca.accountid = data['accountid'];
    ca.fullname = data['fullname'];
    ca.email = data['email'];
    ca.phoneNo = data['phone_no'];
    ca.imageURL = data['image_url'];
    ca.activated = data['activated'];
    ca.isMember = data['is_member'];
    ca.icNo = data['ic_no'];

    ca.role = auth.user!.role!;
    ca.isAdminToggled = false;

    ca.scoutInfo = scoutInfoModel;

    return true;
    try {} catch (e) {
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
      'phoneno': account.phoneNo,
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
        .from('scouts')
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
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> getScoutDetails(String scoutid) async {
    var data = await supabase
        .from('scouts')
        .select(
            'no_ahli, no_tauliah, unit, daerah, accounts ( is_member ), position, accounts ( image_url)')
        .eq('accountid', scoutid)
        .single();

    return data;
  }
}
