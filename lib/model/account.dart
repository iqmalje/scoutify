// ignore_for_file: non_constant_identifier_names

import 'package:scoutify/model/scoutinfo.dart';

class Account {
  late String accountid, fullname, email, phoneNo, icNo;
  late bool activated, isMember;

  String? imageURL;

  late ScoutInfoModel scoutInfo;

  Account() {
    _init();
  }

  Account.parse(Map<String, dynamic> item) {
    _init();

    accountid = item['accountid'];
    fullname = item['fullname'];
    email = item['email'];
    phoneNo = item['phone_no'];
    imageURL = item['image_url'];
    activated = item['activated'];
    isMember = item['is_member'];
    icNo = item['ic_no'];
  }

  void _init() {
    accountid = 'None';
    fullname = 'None';
    email = 'None';
    phoneNo = 'None';
    activated = false;
    isMember = false;
    icNo = 'None';
    scoutInfo = ScoutInfoModel();
  }
}
