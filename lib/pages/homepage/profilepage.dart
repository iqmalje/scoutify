import 'package:auto_size_text/auto_size_text.dart';
import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/account.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/pages/account/manageaccount.dart';
import 'package:scoutify/pages/account/scoutid.dart';
import 'package:scoutify/pages/forgotpassword/verifyOTP.dart';
import 'package:scoutify/pages/misc/officers.dart';
import 'package:flutter/material.dart';
import 'package:scoutify/pages/signin/signinpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullname = TextEditingController(),
      mobilenumber = TextEditingController(),
      email = TextEditingController();
  bool shorten = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            appBar: ScoutifyComponents().normalAppBar('Profile', context),
            body: SingleChildScrollView(
              child: Center(
                child: Builder(builder: (context) {
                  CurrentAccount ca = CurrentAccount.getInstance();

                  if (CurrentAccount.getInstance().isAdminToggled &&
                      CurrentAccount.getInstance().role == 'admin') {
                    fullname.text = 'PPM NEGERI JOHOR';
                    mobilenumber.text = '07-111 5566';
                    email.text = 'ppmnegerijohor@gmail.com';
                  } else {
                    fullname.text = ca.fullname;
                    email.text = ca.email == null ? 'No email yet!' : ca.email!;
                    mobilenumber.text = ca.phoneNo ??= 'No phone number yet!';
                  }

                  if (ca.scoutInfo!.position.length > 40) {
                    shorten = true;
                  } else {
                    shorten = false;
                  }
                  return Column(
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Builder(builder: (context) {
                        // TODO: fix this shit
                        if (ca.imageURL == null ||
                            (ca.scoutInfo!.cardName == null ||
                                ca.scoutInfo!.cardName!.isEmpty)) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ScoutIDPage()));
                                  setState(() {});
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                  constraints:
                                      const BoxConstraints(minHeight: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xFFF5F5F5),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: const Offset(0, 2),
                                            blurRadius: 2,
                                            color:
                                                Colors.black.withOpacity(0.25))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                    'You have not updated your Johor Scout Digital ID. Please update your information below. ',
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
                                                        color:
                                                            Color(0xFF0066FF),
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
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
                      const SizedBox(
                        height: 18,
                      ),
                      Builder(builder: (context) {
                        if (CurrentAccount.getInstance().role != 'admin') {
                          return Container();
                        }
                        return InkWell(
                          onTap: () async {
                            if (CurrentAccount.getInstance().role != 'admin')
                              return;

                            bool? isToggle = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      CurrentAccount.getInstance()
                                              .isAdminToggled
                                          ? 'Are you sure to toggle off admin view?'
                                          : 'Are you sure to toggle on admin view?',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: const Text('Yes')),
                                    ],
                                  );
                                });

                            if (isToggle == null || !isToggle) return;
                            setState(() {
                              CurrentAccount.getInstance().isAdminToggled =
                                  !CurrentAccount.getInstance().isAdminToggled;
                              if (!CurrentAccount.getInstance()
                                  .isAdminToggled) {
                                fullname.text = 'PPM NEGERI JOHOR';
                                mobilenumber.text = '07-111 5566';
                                email.text = 'ppmnegerijohor@gmail.com';
                              } else {
                                fullname.text = ca.fullname;
                                email.text = ca.email ??= 'No email yet!';
                                mobilenumber.text =
                                    ca.phoneNo ??= 'No phone number yet!';
                              }
                            });
                          },
                          child: Ink(
                            width: 330,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2E3B78),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Center(
                              child: Text(
                                CurrentAccount.getInstance().isAdminToggled
                                    ? 'Admin View'
                                    : "Scout View",
                                textScaleFactor: 1,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w900,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 18,
                      ),
                      Builder(builder: (context) {
                        if (CurrentAccount.getInstance().role != 'admin') {
                          return Column(
                            children: [
                              const Text(
                                'JOHOR SCOUT DIGITAL ID',
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w900,
                                  height: 0,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Builder(builder: (context) {
                                if (ca.accountid ==
                                    '2f8ac5d8-d306-4690-8bd0-c075806f4b3a') {
                                  return ScoutifyComponents()
                                      .buildSpecialCard(ca.getAccount());
                                }
                                return ScoutifyComponents()
                                    .buildCard(ca.getAccount());
                              }),
                            ],
                          );
                        }
                        if (!CurrentAccount.getInstance().isAdminToggled) {
                          return Column(
                            children: [
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
                                height: 10,
                              ),
                              ScoutifyComponents().buildCard(ca.getAccount()),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Image.asset('assets/images/pengakap_logo_2.png')
                            ],
                          );
                        }
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'ACCOUNT INFORMATION',
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
                        height: 15,
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
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
                                controller: fullname,
                                readOnly: true,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 1, left: 10),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 183, 183, 183),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                    border: InputBorder.none,
                                    labelText: 'Full Name'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
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
                                controller: mobilenumber,
                                readOnly: true,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 1, left: 10),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 183, 183, 183),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                    labelText: 'Mobile Number'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
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
                                controller: email,
                                readOnly: true,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      top: 1,
                                      left: 10,
                                    ),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 183, 183, 183),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                    labelText: 'Email'),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ScoutifyComponents().outlinedNormalButton(
                        context,
                        'Manage Account',
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => ManageAccountPage(
                                        account: ca.getAccount(),
                                      )))
                              .then((value) {
                            setState(() {});
                          });
                          ;
                        },
                        width: MediaQuery.sizeOf(context).width * 0.8,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ScoutifyComponents().filledNormalButton(
                        context,
                        'Log Out',
                        onTap: () async {
                          await AccountDAO().signout();

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()),
                              (route) => false);
                        },
                        width: MediaQuery.sizeOf(context).width * 0.8,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
