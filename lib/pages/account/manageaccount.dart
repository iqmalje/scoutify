import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/account.dart';
import 'package:scoutify/pages/account/accountinfo.dart';
import 'package:scoutify/pages/account/privacypolicy.dart';
import 'package:scoutify/pages/account/scoutid.dart';
import 'package:scoutify/pages/account/scoutinfo.dart';
import 'package:flutter/material.dart';
import 'package:scoutify/pages/homepage/termcondition.dart';

class ManageAccountPage extends StatefulWidget {
  Account account;
  ManageAccountPage({super.key, required this.account});

  @override
  State<ManageAccountPage> createState() => _ManageAccountPageState(account);
}

class _ManageAccountPageState extends State<ManageAccountPage> {
  final Account account;
  _ManageAccountPageState(this.account);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          ScoutifyComponents().appBarWithBackButton('Manage Account', context),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            createButtons(
                'JOHOR SCOUT DIGITAL ID',
                () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScoutIDPage()))
                    }),
            const SizedBox(
              height: 20,
            ),
            createButtons(
                'ACCOUNT INFORMATION',
                () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AccountInfoPage(
                                account: account,
                              )))
                    }),
            const SizedBox(
              height: 20,
            ),
            createButtons(
                'SCOUT INFORMATION',
                () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScoutInfo()))
                    }),
            const SizedBox(
              height: 20,
            ),
            createButtons(
                'PRIVACY POLICY',
                () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PrivacyPolicy()))
                    }),
          ],
        ),
      ),
    );
  }

  /*

    COMPONENTS
  */

  Widget createButtons(String text, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: MediaQuery.sizeOf(context).width,
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
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                IconButton(
                    onPressed: onTap,
                    icon: const Icon(Icons.arrow_forward_ios_rounded))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
