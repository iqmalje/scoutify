// ignore_for_file: non_constant_identifier_names

class Account {
  //class for account

  late String? phoneno, email;

  late String accountid,
      fullname,
      IC_no,
      no_ahli,
      no_tauliah,
      unit,
      daerah,
      roles,
      image_url,
      position,
      cardid,
      display_name;
  late bool is_member, is_activated;
  late DateTime created_at;

  //build constructor that accepts map
  Account(Map<String, dynamic> item) {
    accountid = item['accountid'];
    fullname = item['fullname'];
    email = item['email'];
    phoneno = item['phoneno'];
    no_ahli = item['no_ahli'];
    IC_no = item['ic_no'];
    no_tauliah = item['no_tauliah'];
    unit = item['unit'];
    daerah = item['daerah'];
    roles = item['roles'];
    image_url = item['image_url'];
    position = item['position'];
    cardid = item['cardid'] ??= 'None';
    is_member = item['is_member'];
    is_activated = item['activated'];
    created_at =
        DateTime.parse(item['created_at']).add(const Duration(hours: 8));
    display_name = item['card_name'];
  }
}
