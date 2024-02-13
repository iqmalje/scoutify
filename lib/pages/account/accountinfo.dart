import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/account.dart';
import 'package:flutter/material.dart';

class AccountInfoPage extends StatefulWidget {
  final Account account;
  const AccountInfoPage({super.key, required this.account});

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState(account);
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  final Account account;
  _AccountInfoPageState(this.account);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          ScoutifyComponents().appBarWithBackButton('Account Info', context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
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
              height: 30,
            ),
            Container(
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
                  controller: TextEditingController(text: account.fullname),
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
                      contentPadding: EdgeInsets.only(top: 1, left: 10),
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
                  controller: TextEditingController(text: account.phoneno),
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
                      contentPadding: EdgeInsets.only(top: 1, left: 10),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 183, 183, 183),
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
                  controller: TextEditingController(text: account.email),
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
                      contentPadding: EdgeInsets.only(top: 1, left: 10),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 183, 183, 183),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      border: InputBorder.none,
                      labelText: 'Email'),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ScoutifyComponents().filledNormalButton(
              context,
              'Delete Account',
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
