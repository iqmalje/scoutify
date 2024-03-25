import 'dart:io';

import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/account.dart';
import 'package:scoutify/model/chat.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/pages/account/profileguideline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ScoutIDPage extends StatefulWidget {
  const ScoutIDPage({super.key});

  @override
  State<ScoutIDPage> createState() => _ScoutIDPageState();
}

class _ScoutIDPageState extends State<ScoutIDPage> {
  @override
  Widget build(BuildContext context) {
    Account account = CurrentAccount.getInstance().getAccount();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: ScoutifyComponents()
            .appBarWithBackButton('Manage Account', context),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05),
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'JOHOR SCOUT DIGITAL ID',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900,
                      height: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //image avatar
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 90,
                        backgroundColor: const Color(0xFF00579E),
                        child: CircleAvatar(
                          radius: 85,
                          backgroundImage: NetworkImage("${account.imageURL}"),
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () async {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProfilePictureGuideline(
                                            account: account,
                                          )))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Click on the profile picture to update',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilePictureGuideline(
                                    account: account,
                                  )));
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.red,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Guideline upload profile picture',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ScoutifyComponents().buildInputBoxWithEditButton(
                      'Name Display',
                      TextEditingController(
                          text: account.scoutInfo.cardName ??= '-'),
                      context, onTap: () async {
                    // display popup
                    String? displayName = await showDisplayNameDialog(context);
                    if (displayName == null || displayName.isEmpty) return;
                    await AccountDAO().updateDisplayName(displayName);
                    setState(() {
                      CurrentAccount.getInstance().scoutInfo!.cardName =
                          displayName;
                    });
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  ScoutifyComponents().buildInputBox('Position',
                      TextEditingController(text: account.scoutInfo.position)),
                  const SizedBox(
                    height: 15,
                  ),
                  ScoutifyComponents().buildInputBox('Scout ID',
                      TextEditingController(text: account.scoutInfo.noAhli)),
                  const SizedBox(
                    height: 15,
                  ),
                  ScoutifyComponents().buildInputBox('Credentials Number',
                      TextEditingController(text: account.scoutInfo.noTauliah)),
                  const SizedBox(
                    height: 15,
                  ),
                  ScoutifyComponents().buildInputBox('Unit Number',
                      TextEditingController(text: account.scoutInfo.unit)),
                  const SizedBox(
                    height: 15,
                  ),
                  ScoutifyComponents().buildInputBox('District',
                      TextEditingController(text: account.scoutInfo.daerah)),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> showDisplayNameDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          int wordCount = 0;
          TextEditingController displayName = TextEditingController();
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name Display',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'The display name on the card must be less than 15 characters',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: const Color(0xFF9397A0), width: 1)),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                wordCount = value.length;
                              });
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                              UpperCaseTextFilter()
                            ],
                            controller: displayName,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Name Display',
                                suffix: Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text('${wordCount}/15'),
                                ),
                                prefixIcon: const Icon(Icons.person_outline)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ScoutifyComponents().filledButton(
                            height: 50,
                            width: MediaQuery.sizeOf(context).width,
                            text: 'CONFIRM',
                            onTap: () {
                              Navigator.of(context).pop(displayName.text);
                            },
                            color: const Color(0xFF302E84),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          );
        });
  }
}

class UpperCaseTextFilter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
