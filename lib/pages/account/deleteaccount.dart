import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/pages/account/scoutid.dart';
import 'package:scoutify/pages/signin/signinpage.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  late TextEditingController _icController = TextEditingController(text: '');

  late TextEditingController _nameController = TextEditingController(text: '');

  late TextEditingController _approvalCodeController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          ScoutifyComponents().appBarWithBackButton('Delete Account', context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'To initiate the deletion of your account, kindly complete the requested information below.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'IC Number',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                buildInputBox(
                  'IC Number',
                  _icController,
                  Icon(
                    Icons.person_outline,
                    color: Color.fromARGB(255, 59, 63, 101),
                  ),
                  formatter: [
                    MaskTextInputFormatter(
                        mask: '######-##-####',
                        filter: {'#': RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    UpperCaseTextFilter()
                  ],
                ),
                Text(
                  'Full Name as IC',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                buildInputBox(
                  'Full Name as IC',
                  _nameController,
                  Icon(
                    Icons.person_outline,
                    color: Color.fromARGB(255, 59, 63, 101),
                  ),
                  formatter: [UpperCaseTextFilter()],
                ),
                Row(
                  children: [
                    Text(
                      'Approval Code',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: GestureDetector(
                        child: Icon(
                          Icons.info,
                          color: Colors.red,
                          size: 15,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Information"),
                                content: Text(
                                    "Scout members are required to contact the administrator via email or phone to obtain the approval code for deleting their account.",
                                    style: TextStyle(fontFamily: "Poppins")),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Close",
                                        style:
                                            TextStyle(fontFamily: "Poppins")),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
                buildInputBox(
                  'Approval Code',
                  _approvalCodeController,
                  Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 59, 63, 101),
                  ),
                  formatter: [UpperCaseTextFilter()],
                ),
                SizedBox(height: 30),
                ScoutifyComponents().outlinedNormalButton(
                  context,
                  'Delete Account',
                  onTap: () async {
                    await AccountDAO().deleteAcc();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignInPage()), (route) => false)
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildInputBox(
      String title, TextEditingController controller, Icon icon,
      {List<TextInputFormatter>? formatter, String? hintText}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 20),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          shadows: [
            BoxShadow(
              color: const Color(0x3F000000),
              blurRadius: 2,
              offset: const Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 5),
          child: TextFormField(
            controller: controller,
            inputFormatters: formatter,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
            maxLines: 1,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: icon,
              contentPadding: const EdgeInsets.only(top: 1, left: 10),
              labelStyle: const TextStyle(
                color: const Color.fromARGB(255, 183, 183, 183),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              labelText: title,
            ),
          ),
        ),
      ),
    );
  }
}
