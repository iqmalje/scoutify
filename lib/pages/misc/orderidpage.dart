import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderIDPage extends StatelessWidget {
  const OrderIDPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ScoutifyComponents()
            .appBarWithBackButton("Order ID", context),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              child: Ink(
                width: MediaQuery.sizeOf(context).width,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBoldText('What is Order ID?'),
                    buildText(
                        'The Order ID is a series of numbers on your receipt generated from your payment for Johor Digital ID on the Order Sini (ordersini.com) platform.'),
                    buildBoldText('How I can know my Order ID?'),
                    buildText(
                        'You can find your Order ID by checking your email. Once your payment for Johor Digital ID in Order Sini has been approved, you will receive an email confirming your purchase. The Order ID can be found in the email’s subject line. Here is an example:'),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset('assets/images/orderidexample.png'),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Center(
                        child: Text('The Order ID for the user is 1416942',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                    buildBoldText(
                        'My order has been approved, but I still can’t activate my account using the Order ID. Why?'),
                    buildText(
                        'After your purchase of Johor Digital ID has been approved, you may need to choose your Johor Scout ID first via the AppSheet link shared in the same email you received. You must fill in all the information in the AppSheet platform before your Order ID can be used to activate your account in the Scoutify app.'),
                    buildBoldText(
                        'I still have difficulties for activating my Scoutify account. '),
                    buildText(
                        'You can join the Telegram groups via the link provided below, where you can directly ask for help from us.'),
                    buildSmallBoldText('Scoutify News:'),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 8),
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            await _launchTelegramURL();
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        child: const Text('https://t.me/Scoutify',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                            )),
                      ),
                    ),
                    buildSmallBoldText('Scoutify Support:'),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 8),
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            await _launchScoutifySupportURL();
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        child: const Text('https://dgkad.my/GroupSupportScoutify',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                            )),
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 0,
          )),
    );
  }

  Widget buildBoldText(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            height: 0,
          )),
    );
  }

  Widget buildSmallBoldText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 10),
      child: Text(text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            height: 0,
          )),
    );
  }

  _launchTelegramURL() async {
    Uri _url = Uri.parse('https://t.me/Scoutify');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  _launchScoutifySupportURL() async {
    Uri _url = Uri.parse('https://dgkad.my/GroupSupportScoutify');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }
}
