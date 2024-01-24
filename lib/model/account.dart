// ignore_for_file: non_constant_identifier_names

class Account {
  //class for account

  late String accountid,
      fullname,
      email,
      phoneno,
      no_ahli,
      no_tauliah,
      unit,
      daerah,
      roles,
      image_url,
      position,
      cardid,
      display_name;
  late bool is_member;
  late DateTime created_at;

  //build constructor that accepts map
  Account(Map<String, dynamic> item) {
    accountid = item['accountid'];
    fullname = item['fullname'];
    email = item['email'];
    phoneno = item['phoneno'];
    no_ahli = item['no_ahli'];
    no_tauliah = item['no_tauliah'];
    unit = item['unit'];
    daerah = item['daerah'];
    roles = item['roles'];
    image_url = item['image_url'];
    position = item['position'];
    cardid = item['cardid'] ??= 'None';
    is_member = item['is_member'];
    created_at =
        DateTime.parse(item['created_at']).add(const Duration(hours: 8));
    display_name = item['card_name'];
  }
}
