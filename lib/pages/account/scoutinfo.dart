import 'package:flutter/services.dart';
import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/account.dart';
import 'package:flutter/material.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/pages/account/scoutid.dart';

class ScoutInfo extends StatefulWidget {
  const ScoutInfo({
    super.key,
  });

  @override
  State<ScoutInfo> createState() => _ScoutInfoState();
}

class _ScoutInfoState extends State<ScoutInfo> {
  Account account = CurrentAccount.getInstance().getAccount();
  bool isEdit = false;

  late TextEditingController _genderController =
      TextEditingController(text: '');
  late TextEditingController _raceController = TextEditingController(text: '');
  late TextEditingController _religionController =
      TextEditingController(text: '');
  late TextEditingController _districtController =
      TextEditingController(text: '');
  late TextEditingController _unitNumberController =
      TextEditingController(text: '');
  late TextEditingController _teamCrewNumberController =
      TextEditingController(text: '');
  late TextEditingController _schoolCrewCodeController =
      TextEditingController(text: '');
  late TextEditingController _schoolCrewNameController =
      TextEditingController(text: '');
  late TextEditingController _credentialNumberController =
      TextEditingController(text: '');
  late TextEditingController _fullnameController =
      TextEditingController(text: '');

  late String originalGender;
  late String originalRace;
  late String originalReligion;
  late String originalDistrict;
  late String originalUnitNumber;
  late String originalTeamCrewNumber;
  late String originalSchoolCrewCode;
  late String originalSchoolCrewName;
  late String originalCredentialNumber;

  @override
  void initState() {
    super.initState();
    _genderController =
        TextEditingController(text: account.scoutInfo.jantina ?? '');
    _raceController = TextEditingController(
        text: account.scoutInfo.kaum ?? ''); //TODO: update controller here
    //TextEditingController(text: account.fullname ?? '')
    _religionController =
        TextEditingController(text: account.scoutInfo.agama ?? '');
    _districtController =
        TextEditingController(text: account.scoutInfo.daerah ?? '');
    _unitNumberController =
        TextEditingController(text: account.scoutInfo.unit ?? '');
    _teamCrewNumberController =
        TextEditingController(text: account.scoutInfo.crewNo ?? '');
    _schoolCrewCodeController =
        TextEditingController(text: account.scoutInfo.schoolCode ?? '');
    _schoolCrewNameController =
        TextEditingController(text: account.scoutInfo.schoolName ?? '');
    _credentialNumberController =
        TextEditingController(text: account.scoutInfo.noTauliah ?? '');
    _fullnameController = TextEditingController(text: account.fullname);
    originalGender = _genderController.text;
    originalRace = _raceController.text;
    originalReligion = _religionController.text;
    originalDistrict = _districtController.text;
    originalUnitNumber = _unitNumberController.text;
    originalTeamCrewNumber = _teamCrewNumberController.text;
    originalSchoolCrewCode = _schoolCrewCodeController.text;
    originalSchoolCrewName = _schoolCrewNameController.text;
    originalCredentialNumber = _credentialNumberController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          ScoutifyComponents().appBarWithBackButton('Manage Account', context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Builder(builder: (context) {
                  // TODO: fix this shit
                  if (ifNull()) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (isEdit == false) {
                              ScoutifyComponents().customDialog(
                                  context,
                                  'Update Scout Information',
                                  'There is some scout information that you are restricted from editing. Are you sure you want to proceed and edit your scout information?',
                                  () {
                                setState(() {
                                  isEdit = true;
                                });
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.7,
                            constraints: const BoxConstraints(minHeight: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFF5F5F5),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 2),
                                      blurRadius: 2,
                                      color: Colors.black.withOpacity(0.25))
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.privacy_tip,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: RichText(
                                      text: const TextSpan(
                                          text:
                                              'You have not updated your Scout Information. Please update your information below. ',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 9,
                                              color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text: 'Click here',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 10,
                                                  color: Color(0xFF0066FF),
                                                  decoration:
                                                      TextDecoration.underline,
                                                ))
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
                const Text(
                  'SCOUT INFORMATION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildInputBox(
                    'ID / Passport No.',
                    TextEditingController(
                        text: CurrentAccount.getInstance()
                            .icNo
                            .replaceRange(10, 14, '****')),
                    false),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox('Full Name', _fullnameController, true,
                    formatter: [UpperCaseTextFilter()]),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Scout Rank',
                    TextEditingController(text: account.scoutInfo.position),
                    false),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Johor Scout ID',
                    TextEditingController(
                        text: account.scoutInfo.noAhli ??= 'None'),
                    false),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox('Credentials Number (Nombor Tauliah)',
                    _credentialNumberController, true,
                    hintText: 'Eg: PN-252, PIPN-252, TIADA'),
                const SizedBox(
                  height: 15,
                ),
                buildDropDown(
                    'Sex', ['LELAKI', 'PEREMPUAN'], _genderController),
                const SizedBox(
                  height: 15,
                ),
                buildDropDown('Race', ['MELAYU', 'CINA', 'INDIA', 'LAIN-LAIN'],
                    _raceController),
                const SizedBox(
                  height: 15,
                ),
                buildDropDown(
                    'Religion',
                    ['ISLAM', 'KRISTIAN', 'HINDU', 'BUDDHA', 'LAIN-LAIN'],
                    _religionController),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox('Unit Number', _unitNumberController, true,
                    hintText: 'Eg: 1983 ( PM / PR ), 2018 ( PKK / PM / PK )'),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Troop / Team Number', _teamCrewNumberController, true,
                    hintText: 'Eg: A, 01, KELANA A, TERBUKA'),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Troop / School Code', _schoolCrewCodeController, true,
                    hintText: 'Eg: JEA0001, KELANA A, TERBUKA'),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Troop / School Name', _schoolCrewNameController, true,
                    hintText:
                        'Eg: SK, SJK (C), SMK, SMKA, SM, KELANA A, TERBUKA'),
                const SizedBox(
                  height: 15,
                ),
                buildDropDown(
                  'District',
                  [
                    'BATU PAHAT',
                    "JOHOR BAHRU",
                    "KLUANG",
                    "KOTA TINGGI",
                    "KULAI",
                    "MERSING",
                    "MUAR",
                    "PASIR GUDANG",
                    "PONTIAN",
                    "SEGAMAT",
                    'TANGKAK'
                  ],
                  _districtController,
                ),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'State', TextEditingController(text: 'JOHOR'), false),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Country', TextEditingController(text: 'MALAYSIA'), false),
                const SizedBox(
                  height: 15,
                ),
                isEdit == true
                    ? Container(
                        child: Row(
                          children: [
                            ScoutifyComponents().cancelNormalButton(
                                context, "CANCEL",
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                onTap: () {
                              ScoutifyComponents().customDialog(
                                  context,
                                  'Discard Scout Information',
                                  'You are planning to cancel the update of your scout information. If you have provided updated scout information, it will not be saved. Are you sure you want to cancel updating your scout information?',
                                  () async {
                                setState(
                                  () {
                                    isEdit = false;
                                    resetControllers();
                                  },
                                );
                              });
                            }),
                            const Spacer(),
                            GestureDetector(
                                child: ScoutifyComponents().filledNormalButton(
                                    context, "CONFIRM",
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4),
                                onTap: () async {
                                  ScoutifyComponents().customDialog(
                                      context,
                                      'Update Scout Information',
                                      'All scout information that has been provided is true, and I am aware of the potential consequences from PPMNJ if I incorrectly state any information. Are you sure you want to save your scout information?',
                                      () async {
                                    Account tempAccount =
                                        CurrentAccount.getInstance()
                                            .getAccount();

                                    tempAccount.fullname =
                                        _fullnameController.text;

                                    tempAccount.scoutInfo.noTauliah =
                                        _credentialNumberController.text;
                                    tempAccount.scoutInfo.jantina =
                                        _genderController.text;
                                    tempAccount.scoutInfo.kaum =
                                        _raceController.text;
                                    tempAccount.scoutInfo.agama =
                                        _religionController.text;
                                    tempAccount.scoutInfo.unit =
                                        _unitNumberController.text;
                                    tempAccount.scoutInfo.crewNo =
                                        _teamCrewNumberController.text;
                                    tempAccount.scoutInfo.schoolCode =
                                        _schoolCrewCodeController.text;
                                    tempAccount.scoutInfo.schoolName =
                                        _schoolCrewNameController.text;
                                    tempAccount.scoutInfo.daerah =
                                        _districtController.text;
                                    await AccountDAO()
                                        .updateAccountInfo(tempAccount);

                                    setState(() {
                                      isEdit = false;
                                      resetOldControllers();
                                    });
                                  });
                                }),
                          ],
                        ),
                      )
                    : GestureDetector(
                        child: ScoutifyComponents().filledNormalButton(
                          context,
                          "UPDATE",
                        ),
                        onTap: () {
                          ScoutifyComponents().customDialog(
                              context,
                              'Update Scout Information',
                              'There is some scout information that you are restricted from editing. Are you sure you want to proceed and edit your scout information?',
                              () {
                            setState(() {
                              isEdit = true;
                            });
                          });
                        }),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildInputBox(
      String title, TextEditingController controller, bool isEditable,
      {List<TextInputFormatter>? formatter, String? hintText}) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: [
          BoxShadow(
            color: (() {
              if (isEditable &&
                  (controller.text == '' || controller.text == 'TIADA')) {
                return Colors.red;
              } else if (isEdit && isEditable) {
                return Colors.blue;
              } else {
                return const Color(0x3F000000);
              }
            })(),
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: TextFormField(
          controller: controller,
          inputFormatters: [UpperCaseTextFilter()],
          readOnly: !isEdit, // Make it editable only when isEdit is true
          style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400),
          maxLines: 1,
          onChanged: (newValue) {
            setState(() {
              controller.text = newValue;
            });
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(top: 1, left: 10),
            labelStyle: const TextStyle(
              color: const Color.fromARGB(255, 183, 183, 183),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
            border: InputBorder.none,
            labelText: title,
          ),
        ),
      ),
    );
  }

  Container buildDropDown(
      String title, List<String?> options, TextEditingController controller) {
    String? initialOption = options.firstWhere(
        (option) => option?.toLowerCase() == controller.text.toLowerCase(),
        orElse: () => null);

    return isEdit
        ? Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              shadows: [
                BoxShadow(
                  color: (() {
                    if (isEdit && initialOption == null) {
                      return Colors.red;
                    } else if (isEdit) {
                      return Colors.blue;
                    } else {
                      return const Color(0x3F000000);
                    }
                  })(),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: DropdownButtonFormField<String?>(
                value: initialOption,
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('SELECT',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            fontFamily: "Poppins")),
                  ),
                  ...options.map((String? value) {
                    return DropdownMenuItem<String?>(
                      value: value,
                      child: Text(value ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              fontFamily: "Poppins")),
                    );
                  }),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    controller.text = newValue ?? '';
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 1, left: 10),
                  labelStyle: const TextStyle(
                    color: const Color.fromARGB(255, 183, 183, 183),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  border: InputBorder.none,
                  labelText: title,
                ),
              ),
            ),
          )
        : buildInputBox(title, controller, false);
  }

  void resetControllers() {
    _genderController.text = originalGender;
    _raceController.text = originalRace;
    _religionController.text = originalReligion;
    _districtController.text = originalDistrict;
    _unitNumberController.text = originalUnitNumber;
    _teamCrewNumberController.text = originalTeamCrewNumber;
    _schoolCrewCodeController.text = originalSchoolCrewCode;
    _schoolCrewNameController.text = originalSchoolCrewName;
    _credentialNumberController.text = originalCredentialNumber;
  }

  void resetOldControllers() {
    originalGender = _genderController.text;
    originalRace = _raceController.text;
    originalReligion = _religionController.text;
    originalDistrict = _districtController.text;
    originalUnitNumber = _unitNumberController.text;
    originalTeamCrewNumber = _teamCrewNumberController.text;
    originalSchoolCrewCode = _schoolCrewCodeController.text;
    originalSchoolCrewName = _schoolCrewNameController.text;
    originalCredentialNumber = _credentialNumberController.text;
  }

  //bro hahaha apa sia cara aku check ni hahahah
  bool ifNull() {
    return account.scoutInfo.position == null ||
        account.scoutInfo.unit == null ||
        account.scoutInfo.jantina == null ||
        account.scoutInfo.kaum == null ||
        account.scoutInfo.agama == null ||
        account.scoutInfo.noTauliah == null ||
        account.scoutInfo.daerah == null ||
        account.scoutInfo.negara == null ||
        account.scoutInfo.schoolCode == null ||
        account.scoutInfo.schoolName == null ||
        account.scoutInfo.crewNo == null ||
        account.scoutInfo.position == 'TIADA' ||
        account.scoutInfo.unit == 'TIADA' ||
        account.scoutInfo.jantina == 'TIADA' ||
        account.scoutInfo.kaum == 'TIADA' ||
        account.scoutInfo.agama == 'TIADA' ||
        account.scoutInfo.noTauliah == 'TIADA' ||
        account.scoutInfo.daerah == 'TIADA' ||
        account.scoutInfo.negara == 'TIADA' ||
        account.scoutInfo.schoolCode == 'TIADA' ||
        account.scoutInfo.schoolName == 'TIADA' ||
        account.scoutInfo.crewNo == 'TIADA';
  }
}
