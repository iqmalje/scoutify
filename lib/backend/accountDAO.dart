import 'dart:io';

import 'package:scoutify/model/account.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/model/scoutinfo.dart';
import 'package:scoutify/model/version.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountDAO {
  var supabase = Supabase.instance.client;

  Future<Account> selectAccountFromIC(String ICno, String orderID) async {
    var data;

    try {
      var dataRAW = await supabase.functions
          .invoke("activate-account", body: {'icNo': ICno, 'orderID': orderID});
      // most fucked up line of code here
      data = dataRAW.data;
    } catch (e) {
      throw Exception('Error occurs');
    }

    // parse into acc
    Account account = Account();

    try {
      account.accountid = data['accountid'];
      account.icNo = data['ic_no'];
      account.email = data['email'];
      account.fullname = data['fullname'];
      account.activated = data['activated'];
      account.phoneNo = data['phone_no'];
    } catch (e) {
      throw Exception('Please enter the correct MyKad No and Order ID');
    }

    print(account.activated);
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
    try {
      AuthResponse auth = await supabase.auth
          .signInWithPassword(password: password, email: email);
      //on sign in, just set the var to false

      print(auth.user!.role);

      // set instance account
      await setInstanceAccount(auth: auth);
    } catch (e) {
      if (e.toString().contains('login credentials')) {
        throw "Invalid login credentials";
        //throw Exception("Invalid login credentials");
      }

      rethrow;
    }

    return true;
  }

  // fill in CurrentAccount
  Future<void> setInstanceAccount({AuthResponse? auth}) async {
    var data = await supabase
        .from('accounts')
        .select('*')
        .eq('accountid',
            auth == null ? supabase.auth.currentUser!.id : auth.user!.id)
        .single();
    print('KAT SINI DAPAT DO WEHH');
    var scoutdata = await supabase
        .from('scouts')
        .select('*')
        .eq('accountid',
            auth == null ? supabase.auth.currentUser!.id : auth.user!.id)
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

    ca.role =
        auth == null ? supabase.auth.currentUser!.role! : auth.user!.role!;
    ca.isAdminToggled = false;

    ca.scoutInfo = scoutInfoModel;
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

    await sendInboxIfUpdated();
    return profileurl + "?v=${DateTime.now().microsecondsSinceEpoch}";
  }

  Future<void> updateDisplayName(String displayName) async {
    String userid = supabase.auth.currentUser!.id;

    await supabase
        .from('scouts')
        .update({'card_name': displayName}).eq('accountid', userid);

    // check update

    await sendInboxIfUpdated();
  }

  Future<void> updateNoTauliah(String notauliah) async {
    String userid = supabase.auth.currentUser!.id;

    try {
      await supabase
          .from('scouts')
          .update({'no_tauliah': notauliah}).eq('accountid', userid);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUnitNumber(String unit) async {
    String userid = supabase.auth.currentUser!.id;

    try {
      await supabase
          .from('scouts')
          .update({'unit': unit}).eq('accountid', userid);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> verifyPasswordOTP(String email, String OTP) async {
    try {
      var data = await supabase.auth
          .verifyOTP(email: email, token: OTP, type: OtpType.recovery);

      if (data.session != null) {
        await supabase
            .from("accounts")
            .update({'activated': true}).eq('accountid', data.user?.id);
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

  // get the latest version of the mobile app and determine if important update
  Future<bool> isNewerUpdate(int currVersion) async {
    var data = Version.parse(await supabase
        .from('VERSION')
        .select('*')
        .order('created_at', ascending: false)
        .limit(1)
        .single());

    if (data.version > currVersion && data.isImportant) {
      // require force update
      return true;
    }
    return false;
  }

  Future<void> updateAccountInfo(Account account) async {
    //update at db
    await supabase.from('accounts').update({
      'fullname': account.fullname,
    }).eq('accountid', account.accountid);

    ScoutInfoModel sim = account.scoutInfo;
    await supabase.from('scouts').update({
      'no_tauliah': sim.noTauliah,
      'unit': sim.unit,
      'daerah': sim.daerah,
      'crew_no': sim.crewNo,
      'school_code': sim.schoolCode,
      'manikayu': sim.manikayu,
      'negara': sim.negara,
      'jantina': sim.jantina,
      'kaum': sim.kaum,
      'agama': sim.agama,
      'school_name': sim.schoolName
    }).eq('accountid', account.accountid);
    // update current account
    CurrentAccount.getInstance().updateAccount(account);
    print('dah update');
  }

  Future<void> sendInboxIfUpdated() async {
    CurrentAccount ca = CurrentAccount.getInstance();

    if (ca.imageURL != null && ca.scoutInfo?.cardName != null) {
      //send inbox
      await supabase.from('inboxes').insert({
        'title': 'Your Johor Scout Digital ID Profile is Complete',
        'imageURL':
            'https://zgzfjrhzwclqyxmbinpi.supabase.co/storage/v1/object/public/inbox/updated_scout/congrats.png',
        'description':
            'You\'ve done it! 🎉 Your Johor Scout Digital ID\'s Profile is now complete! Ready to share your pride as a Johor Scout with friends and loved ones? Go ahead, spread the word, and let everyone know you\'re part of the amazing Johor Scout family! 🌟',
        'target_id': ca.accountid,
        'type': 'announce'
      });
    }
  }

  Future<void> deleteAcc() async {
    await supabase.functions.invoke('delete-account',
        body: {'accountID': CurrentAccount.getInstance().accountid});

    await supabase.auth.signOut();
  }
}
