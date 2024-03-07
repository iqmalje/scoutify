// current logged in account

import 'package:scoutify/model/account.dart';
import 'package:scoutify/model/scoutinfo.dart';

class CurrentAccount {
  String accountid = '',
      fullname = '',
      email = '',
      phoneNo = '',
      icNo = '',
      role = 'authenticated';

  bool activated = false, isMember = false, isAdminToggled = false;

  String? imageURL;

  ScoutInfoModel? scoutInfo;

  static CurrentAccount? _instance;

  // private constructor
  CurrentAccount._();

  static CurrentAccount getInstance() {
    if (_instance == null) {
      _instance = CurrentAccount._();

      return _instance!;
    } else {
      return _instance!;
    }
  }

  // switch currentaccount to account
  // forced to do this shi because currentaccount CANNOT inherit account
  Account getAccount() {
    CurrentAccount ca = getInstance();

    Account ac = Account();

    ac.accountid = ca.accountid;
    ac.fullname = ca.fullname;
    ac.email = ca.email;
    ac.phoneNo = ca.phoneNo;
    ac.imageURL = ca.imageURL;
    ac.activated = ca.activated;
    ac.isMember = ca.isMember;
    ac.icNo = ca.icNo;

    ac.scoutInfo = scoutInfo!;

    return ac;
  }
}
