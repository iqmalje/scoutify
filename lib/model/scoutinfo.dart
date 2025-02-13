class ScoutInfoModel {
  late String noAhli, position, unit, jantina, kaum, agama;

  String? noTauliah,
      daerah,
      negara,
      cardID,
      cardName,
      schoolCode,
      schoolName,
      crewNo,
      manikayu;

  ScoutInfoModel() {
    _init();
  }

  ScoutInfoModel.parse(Map<String, dynamic> items) {
    // ensuring null data safely storedw
    _init();
    noAhli = items['no_ahli'];
    position = items['position'];
    unit = items['unit'];
    crewNo = items['crew_no'];
    jantina = items['jantina'];
    kaum = items['kaum'];
    agama = items['agama'];

    noTauliah = items['no_tauliah'];
    daerah = items['daerah'];
    negara = items['negara'];
    cardID = items['card_id'];
    cardName = items['card_name'];
    schoolCode = items['school_code'];
    schoolName = items['school_name'];
    manikayu = items['manikayu'];
  }

  void _init() {
    noAhli = 'None';
    position = 'None';
    unit = 'None';
    crewNo = 'None';
    jantina = 'None';
    kaum = 'None';
    agama = 'None';
  }
}
