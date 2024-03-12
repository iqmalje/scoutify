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
                        text: AccountDAO().supabase.auth.currentUser!.id)),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox('Full Name',
                    TextEditingController(text: account.fullname ??= 'None')),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Position',
                    TextEditingController(
                        text: account.scoutInfo.position ??= 'None')),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Scout ID',
                    TextEditingController(
                        text: account.scoutInfo.noAhli ??= 'None')),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Credentials Number',
                    TextEditingController(
                        text: account.scoutInfo.noTauliah ??= 'None')),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Unit Number',
                    TextEditingController(
                        text: account.scoutInfo.unit ??= 'None')),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'Team Number / Crew',
                    TextEditingController(
                        text: account.scoutInfo.crewNo ??= 'None')),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'School Code / Crew',
                    TextEditingController(
                        text: account.scoutInfo.schoolCode ??= 'None')),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'School Name / Crew Name',
                    TextEditingController(
                        // todo implement school name
                        text: account.scoutInfo.schoolCode ??= 'None')),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox(
                    'District',
                    TextEditingController(
                        text: account.scoutInfo.daerah ??= 'None')),
                const SizedBox(
                  height: 15,
                ),
                buildInputBox('State', TextEditingController(text: 'Johor')),
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

  Container buildInputBox(String title, TextEditingController controller) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
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
}
