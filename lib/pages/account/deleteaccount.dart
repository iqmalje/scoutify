import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/pages/account/scoutid.dart';
import 'package:scoutify/pages/signin/signinpage.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final TextEditingController _icController = TextEditingController(text: '');

  final TextEditingController _nameController = TextEditingController(text: '');

  // final TextEditingController _approvalCodeController = TextEditingController(text: '');

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
                const SizedBox(
                  height: 30,
                ),
                const Text(
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
                const SizedBox(
                  height: 30,
                ),
                const Text(
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
                  const Icon(
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
                const Text(
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
                  const Icon(
                    Icons.person_outline,
                    color: Color.fromARGB(255, 59, 63, 101),
                  ),
                  formatter: [UpperCaseTextFilter()],
                ),
                const SizedBox(height: 30),
                ScoutifyComponents().outlinedNormalButton(
                  context,
                  'Delete Account',
                  onTap: () async {
                    if (_icController.text.isEmpty ||
                        _nameController.text.isEmpty ) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill in all the details')));
                      return;
                    }
                    // show popup first then proceed
                    bool? isConfirm = await showConfirmPopup();
                    if (isConfirm == null || isConfirm == false) {
                      return;
                    }
                    // ensure all details is correct
                    if (_icController.text ==
                            CurrentAccount.getInstance().icNo &&
                        _nameController.text ==
                            CurrentAccount.getInstance().fullname) {
                      await AccountDAO().deleteAcc();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()),
                          (route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Wrong input, please try again!')));
                    }
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
            const BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 1),
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

  Future<bool?> showConfirmPopup() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Delete Account',
              style:
                  TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
            ),
            content: const Text(
              'All your scout information will be deleted, and we understand if you have concerns about this matter. Are you sure you want to proceed with deleting your account?',
              style:
                  TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              ScoutifyComponents().filledNormalButton(context, 'Cancel',
                  onTap: () {
                Navigator.of(context).pop(false);
              },
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: const Color(0xFFD9D9D9)),
              ScoutifyComponents().filledNormalButton(
                context,
                'Confirm',
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ],
          );
        });
  }
}
