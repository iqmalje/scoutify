import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/account.dart';
import 'package:flutter/material.dart';
import 'package:scoutify/model/currentaccount.dart';

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
    _genderController = TextEditingController(text: '');
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
        TextEditingController(text: account.scoutInfo.schoolCode ?? '');
    _credentialNumberController =
        TextEditingController(text: account.scoutInfo.noTauliah ?? '');
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
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
                    'Identification ID',
                    TextEditingController(
                        text: AccountDAO().supabase.auth.currentUser!.id),
                    false),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Full Name',
                    TextEditingController(text: account.fullname ??= 'None'),
                    false),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Position',
                    TextEditingController(
                        text: account.scoutInfo.position ??= 'None'),
                    false),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Scout ID',
                    TextEditingController(
                        text: account.scoutInfo.noAhli ??= 'None'),
                    false),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox('Credentials Number (Nombor Tauliah)',
                    _credentialNumberController, true),
                const SizedBox(
                  height: 15,
                ),
                buildDropDown(
                    'Gender', ['Lelaki', 'Perempuan'], _genderController),
                const SizedBox(
                  height: 15,
                ),
                buildDropDown('Race', ['Melayu', 'Cina', 'India', 'Others'],
                    _raceController),
                const SizedBox(
                  height: 15,
                ),
                buildDropDown(
                    'Religion',
                    ['Islam', 'Kristian', 'Hindu', 'Buddha', 'Others'],
                    _religionController),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox('Unit Number', _unitNumberController, true),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Team / Crew Number', _teamCrewNumberController, true),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'School / Crew Code', _schoolCrewCodeController, true),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'School / Crew Name', _schoolCrewNameController, true),
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
                    "MAUR",
                    "PONTIAN",
                    "SEGAMAT",
                    'TANGKAK'
                  ],
                  TextEditingController(
                      text: account.scoutInfo.daerah ??= 'None'),
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
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: Row(
                          children: [
                            ScoutifyComponents().filledNormalButton(
                                context, "CANCEL",
                                width: MediaQuery.sizeOf(context).width * 0.375,
                                onTap: () {
                              setState(
                                () {
                                  isEdit = false;
                                  resetControllers();
                                },
                              );
                            }),
                            const Spacer(),
                            GestureDetector(
                                child: ScoutifyComponents().filledNormalButton(
                                    context, "CONFIRM",
                                    width: MediaQuery.sizeOf(context).width *
                                        0.375),
                                onTap: () {
                                  setState(
                                    () {
                                      // TODO: Update the value in the controller when text changes.
                                      // TODO: Backend goes here kemal :)
                                      isEdit = false;
                                    },
                                  );
                                }),
                          ],
                        ),
                      )
                    : GestureDetector(
                        child: ScoutifyComponents().filledNormalButton(
                            context, "UPDATE",
                            width: MediaQuery.sizeOf(context).width * 0.8),
                        onTap: () {
                          setState(
                            () {
                              isEdit = true;
                            },
                          );
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
      String title, TextEditingController controller, bool isEditable) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: 50,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: [
          BoxShadow(
            color: (isEdit && isEditable) == true
                ? Colors.blue
                : const Color(0x3F000000),
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: TextField(
          controller: controller,
          readOnly: !isEdit, // Make it editable only when isEdit is true
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          maxLines: 1,
          onChanged: (newValue) {
            setState(() {
              controller.text = newValue;
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
              labelText: title),
        ),
      ),
    );
  }

  Container buildDropDown(
      String title, List<String?> options, TextEditingController controller) {
    return isEdit
        ? Container(
            width: MediaQuery.sizeOf(context).width * 0.8,
            height: 50,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              shadows: [
                BoxShadow(
                  color: isEdit == true ? Colors.blue : const Color(0x3F000000),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: DropdownButtonFormField<String?>(
                value: controller.text.isEmpty ? null : controller.text,
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('Select',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15)),
                  ),
                  ...options.map((String? value) {
                    return DropdownMenuItem<String?>(
                      value: value,
                      child: Text(value ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15)),
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
}
