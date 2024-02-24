// ignore_for_file: non_constant_identifier_names

class Account {
  //class for account

  late String? phoneno,
      email,
      display_name,
      no_tauliah,
      daerah,
      manikayu,
      unit,
      negara,
      crew_no,
      school_code,
      school_name;

  late String accountid,
      fullname,
      IC_no,
      no_ahli,
      roles,
      image_url,
      position,
      cardid;
  late bool is_member, is_activated;
  late DateTime created_at;

  //build constructor that accepts map
  Account(Map<String, dynamic> item) {
    accountid = item['accountid'];
    fullname = item['fullname'];
    email = item['email'];
    phoneno = item['phoneno'];
    no_ahli = item['no_ahli'];
    IC_no = item['ic_no'] ??= 'takde lagi';
    no_tauliah =
        item['no_tauliah'].toString().isNotEmpty ? item['no_tauliah'] : null;
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
    print(item['negara']);
    negara = item['negara'];
    manikayu = item['manikayu'];

    crew_no = item['crew_no'];
    school_code = item['school_code'];
    school_name = item['school_name'];
  }
}
