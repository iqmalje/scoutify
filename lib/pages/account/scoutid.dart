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
                      Builder(builder: (context) {
                        if (account.imageURL != null) {
                          return CircleAvatar(
                            radius: 90,
                            backgroundColor: const Color(0xFF00579E),
                            child: CircleAvatar(
                              radius: 85,
                              backgroundImage:
                                  NetworkImage("${account.imageURL}"),
                            ),
                          );
                        } else {
                          return const CircleAvatar(
                            radius: 90,
                            backgroundColor: Color(0xFF00579E),
                            child: CircleAvatar(
                                radius: 85,
                                backgroundImage: AssetImage(
                                    'assets/images/profileDefault.png')),
                          );
                        }
                      }),
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
                    String? displayName = await showEditableDialog(
                        context,
                        'Name Display',
                        'The display name on the card must be less than 15 characters',
                        [
                          LengthLimitingTextInputFormatter(15),
                          UpperCaseTextFilter()
                        ],
                        15);
                    if (displayName == null) return;
                    displayName = displayName.trim();
                    if (displayName.isEmpty) return;
                    print("lalu");
                    await AccountDAO().updateDisplayName(displayName);

                    setState(() {
                      CurrentAccount.getInstance().scoutInfo!.cardName =
                          displayName;
                    });
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  ScoutifyComponents().buildInputBox('Scout Rank',
                      TextEditingController(text: account.scoutInfo.position)),
                  const SizedBox(
                    height: 15,
                  ),
                  ScoutifyComponents().buildInputBox('Johor Scout ID',
                      TextEditingController(text: account.scoutInfo.noAhli)),
                  const SizedBox(
                    height: 15,
                  ),
                  ScoutifyComponents().buildInputBoxWithEditButton(
                      'Credentials Number',
                      TextEditingController(
                          text: account.scoutInfo.noTauliah ?? '-'),
                      context, onTap: () async {
                    // display popup
                    String? noTauliah = await showEditableDialog(
                        context,
                        'Credentials Number',
                        'The credentials number on the card must be less than 10 characters, including the “-”.  The credential number must follow the following example.\n\nExample: PN-252 ; PIPN-252 ; TIADA\n\nNote: If you don’t have a credential number yet, you must use “TIADA” as your credential number.',
                        [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        10);
                    if (noTauliah == null) return;
                    noTauliah = noTauliah.trim();
                    if (noTauliah.isEmpty) return;
                    try {
                      await AccountDAO().updateNoTauliah(noTauliah);
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      CurrentAccount.getInstance().scoutInfo!.noTauliah =
                          noTauliah;
                    });
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  ScoutifyComponents().buildInputBoxWithEditButton(
                      'Unit Number',
                      TextEditingController(
                          text: account.scoutInfo.unit ?? '-'),
                      context, onTap: () async {
                    // display popup
                    String? unit = await showEditableDialog(
                        context,
                        'Credentials Number',
                        'The unit number on the card must be less than 27 characters, including the spaces, round brackets “( )”, and commas “,”. The unit number must follow the following format: \n\nTAHUN MANIKAYU PERTAMA ( PKK , PM , PR , PK )\n\nExample: 1983 ( PKK , PM , PR , PKK ) ; 2018 ( PKK , PR ) ; TIADA\n\nNote: If you don’t have an unit number yet, you must use “TIADA” as your unit number.',
                        [
                          LengthLimitingTextInputFormatter(27),
                        ],
                        27);

                    if (unit == null) return;
                    unit = unit.trim();
                    if (unit.isEmpty) return;
                    try {
                      await AccountDAO().updateUnitNumber(unit);
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      CurrentAccount.getInstance().scoutInfo!.unit = unit!;
                    });
                  }),
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

  Future<String?> showEditableDialog(BuildContext context, String title,
      String description, List<TextInputFormatter> formatters, int limit) {
    return showDialog(
        context: context,
        builder: (context) {
          int wordCount = 0;
          TextEditingController controller = TextEditingController();
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
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
                          Text(
                            title,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            description,
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
                              inputFormatters: formatters,
                              controller: controller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: title,
                                  suffix: Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: Text('${wordCount}/$limit'),
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
                                Navigator.of(context).pop(controller.text);
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
                ),
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
