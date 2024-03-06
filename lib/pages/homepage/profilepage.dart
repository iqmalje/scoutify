import 'package:auto_size_text/auto_size_text.dart';
import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/account.dart';
import 'package:scoutify/pages/account/manageaccount.dart';
import 'package:scoutify/pages/account/scoutid.dart';
import 'package:scoutify/pages/forgotpassword/verifyOTP.dart';
import 'package:scoutify/pages/misc/officers.dart';
import 'package:flutter/material.dart';
import 'package:scoutify/pages/signin/signinpage.dart';

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
            body: SingleChildScrollView(
              child: Center(
                child: FutureBuilder<Account>(
                    future: AccountDAO().getProfileInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        print('loading');
                        return const CircularProgressIndicator();
                      }

                      if (AccountDAO.isAdminToggled &&
                          AccountDAO()
                                  .supabase
                                  .auth
                                  .currentUser!
                                  .role!
                                  .toLowerCase() ==
                              'admin') {
                        fullname.text = 'PPM NEGERI JOHOR';
                        mobilenumber.text = '07-111 5566';
                        email.text = 'ppmnegerijohor@gmail.com';
                      } else {
                        fullname.text = snapshot.data!.fullname;
                        email.text = snapshot.data!.email == null
                            ? 'No email yet!'
                            : snapshot.data!.email!;
                        mobilenumber.text =
                            snapshot.data!.phoneNo ??= 'No phone number yet!';
                      }

                      if (snapshot.data!.scoutInfo.position.length > 40) {
                        shorten = true;
                      } else {
                        shorten = false;
                      }
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 90,
                            decoration:
                                const BoxDecoration(color: Color(0xFF2E3B78)),
                            child: const Center(
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 24,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Builder(builder: (context) {
                            // TODO: fix this shit
                            if (snapshot.data!.imageURL!
                                    .contains('wikimedia') ||
                                (snapshot.data!.scoutInfo.cardName == null ||
                                    snapshot
                                        .data!.scoutInfo.cardName!.isEmpty)) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => ScoutIDPage(
                                                    account: snapshot.data!,
                                                  )));
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      constraints:
                                          const BoxConstraints(minHeight: 50),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFFF5F5F5),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 2),
                                                blurRadius: 2,
                                                color: Colors.black
                                                    .withOpacity(0.25))
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
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 10,
                                                            color: Color(
                                                                0xFF0066FF),
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
                            if (AccountDAO()
                                    .supabase
                                    .auth
                                    .currentUser!
                                    .role!
                                    .toLowerCase() !=
                                'admin') {
                              return Container();
                            }
                            return InkWell(
                              onTap: () async {
                                if (AccountDAO()
                                        .supabase
                                        .auth
                                        .currentUser!
                                        .role!
                                        .toLowerCase() !=
                                    'admin') return;

                                bool? isToggle = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          AccountDAO.isAdminToggled
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
                                  AccountDAO.isAdminToggled =
                                      !AccountDAO.isAdminToggled;
                                  if (!AccountDAO.isAdminToggled) {
                                    fullname.text = 'PPM NEGERI JOHOR';
                                    mobilenumber.text = '07-111 5566';
                                    email.text = 'ppmnegerijohor@gmail.com';
                                  } else {
                                    fullname.text = snapshot.data!.fullname;
                                    email.text = snapshot.data!.email ??=
                                        'No email yet!';
                                    mobilenumber.text = snapshot.data!
                                        .phoneNo ??= 'No phone number yet!';
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
                                    AccountDAO.isAdminToggled
                                        ? 'Admin View'
                                        : "Scout View",
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
                            if (AccountDAO()
                                    .supabase
                                    .auth
                                    .currentUser!
                                    .role!
                                    .toLowerCase() !=
                                'admin') {
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
                                  Builder(builder: (context) {
                                    if (snapshot.data!.accountid ==
                                        '2f8ac5d8-d306-4690-8bd0-c075806f4b3a') {
                                      return ScoutifyComponents()
                                          .buildSpecialCard(snapshot.data!);
                                    }
                                    return ScoutifyComponents()
                                        .buildCard(snapshot.data!);
                                  }),
                                ],
                              );
                            }
                            if (!AccountDAO.isAdminToggled) {
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
                                  ScoutifyComponents()
                                      .buildCard(snapshot.data!),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Image.asset(
                                      'assets/images/pengakap_logo_2.png')
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
                                height: 50,
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
                                      height: 0,
                                    ),
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 1, left: 10),
                                        labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 183, 183, 183),
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
                                height: 50,
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
                                      height: 0,
                                    ),
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 1, left: 10),
                                        labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 183, 183, 183),
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
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
                                height: 50,
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
                                      height: 0,
                                    ),
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 1, left: 10),
                                        labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 183, 183, 183),
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
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
                          const Text(
                            'PASSWORD',
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
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         VerifyResetPassword(email: email.text)));

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ManageAccountPage(
                                        account: snapshot.data!,
                                      )));
                              setState(() {});
                            },
                            child: Ink(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: 40,
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
                                  )
                                ],
                              ),
                              child: Center(
                                child: SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.8 -
                                          20,
                                  child: const Text(
                                    'Manage Account',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      VerifyResetPassword(email: email.text)));
                            },
                            child: Ink(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: 40,
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
                                  )
                                ],
                              ),
                              child: Center(
                                child: SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.8 -
                                          20,
                                  child: const Text(
                                    'Reset Password',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          InkWell(
                            onTap: () async {
                              await AccountDAO().signout();

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const SignInPage()),
                                  (route) => false);
                            },
                            child: Ink(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: 40,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF3B4367),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Log Out',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
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
