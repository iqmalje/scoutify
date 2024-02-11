import 'package:escout/components/components.dart';
import 'package:escout/model/account.dart';
import 'package:flutter/material.dart';

class ScoutInfo extends StatefulWidget {
  final Account account;
  const ScoutInfo({super.key, required this.account});

  @override
  State<ScoutInfo> createState() => _ScoutInfoState(account);
}

class _ScoutInfoState extends State<ScoutInfo> {
  final Account account;
  _ScoutInfoState(this.account);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScoutifyComponents().normalAppBar('Manage Account', context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05),
        child: SingleChildScrollView(
          child: Column(
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
              buildInputBox('Identification ID',
                  TextEditingController(text: 'nanti letak')),
              const SizedBox(
                height: 15,
              ),
              buildInputBox(
                  'Full Name', TextEditingController(text: account.fullname)),
              const SizedBox(
                height: 15,
              ),
              buildInputBox(
                  'Position', TextEditingController(text: account.position)),
              const SizedBox(
                height: 15,
              ),
              buildInputBox(
                  'Scout ID', TextEditingController(text: account.no_ahli)),
              const SizedBox(
                height: 15,
              ),
              buildInputBox('Credentials Number',
                  TextEditingController(text: account.no_tauliah)),
              const SizedBox(
                height: 15,
              ),
              buildInputBox(
                  'Unit Number', TextEditingController(text: account.unit)),
              const SizedBox(
                height: 15,
              ),
              buildInputBox('Team Number / Crew',
                  TextEditingController(text: 'takde data yg ni')),
              const SizedBox(
                height: 15,
              ),
              buildInputBox('School Code / Crew',
                  TextEditingController(text: 'takde data yg ni')),
              const SizedBox(
                height: 15,
              ),
              buildInputBox('School Name / Crew Name',
                  TextEditingController(text: 'takde data')),
              const SizedBox(
                height: 15,
              ),
              buildInputBox(
                  'District', TextEditingController(text: account.daerah)),
              const SizedBox(
                height: 15,
              ),
              buildInputBox('State', TextEditingController(text: 'Johor')),
              const SizedBox(
                height: 15,
              ),
              ScoutifyComponents().filledNormalButton(
                context,
                'Change Email',
                onTap: () {},
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildInputBox(String title, TextEditingController controller) {
    return Container(
      height: 50,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: TextField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          maxLines: 1,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 1, left: 10),
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 183, 183, 183),
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
}
