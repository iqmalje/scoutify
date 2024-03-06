// current logged in account

import 'package:scoutify/model/account.dart';

class CurrentAccount {
  late String accountid, fullname, email, phoneNo, activated, isMember, icNo;

  late String? imageURL;

  static CurrentAccount? _instance;

  // private constructor
  CurrentAccount._();

  CurrentAccount getInstance() {
    if (_instance == null) {
      _instance = CurrentAccount._();

      return _instance!;
    } else {
      return _instance!;
    }
  }
}
