import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/pages/account/privacypolicy.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ScoutifyComponents()
            .appBarWithBackButton("Terms & Conditions", context),
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
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Terms & Conditions",
                          textAlign: TextAlign.left, style: boldText),
                    ),
                    buildText('1.', 'Acceptance of Terms',
                        "By creating an account, you agree to abide by the terms and conditions outlined herein."),
                    buildText('2.', 'Account Registration',
                        'You agree to provide accurate and complete information during the registration process. You are solely responsible for maintaining the confidentiality of your account credentials and for any activities that occur under your account.'),
                    buildText('3.', 'Age Restriction',
                        'You must be at least 18 years old to use this application. By creating an account, you confirm that you meet this age requirement'),
                    buildText('4.', "User Content",
                        "Any content you upload, post, or transmit through the application is your responsibility. You retain ownership of your content, but grant the application a non-exclusive, royalty-free license to use, reproduce, modify, adapt, publish, translate, distribute, and display such content worldwide."),
                    buildText('5.', "Prohibited Activities",
                        "You agree not to engage in any activity that may interfere with the proper functioning of the application or violate any laws. This includes, but is not limited to, hacking, data scraping, spamming, or distributing malware."),
                    buildPrivacyPolicyText(context),
                    buildText('7.', "Intellectual Property Rights",
                        "All trademarks, logos, and content displayed in the application are the property of their respective owners. You may not use, reproduce, or distribute any of the content without prior written permission."),
                    buildText('8.', "Disclaimer of Warranties",
                        "The application is provided on an \"as-is\" and \"as available\" basis. We make no warranties or representations of any kind, express or implied, regarding the accuracy, reliability, or suitability of the application for any purpose."),
                    buildText('9.', "Limitation of Liability",
                        "We shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or in connection with your use of the application."),
                    buildText('10.', "Governing Law",
                        "These terms and conditions shall be governed by and construed in accordance with the laws of Malaysia, without regard to its conflict of law principles."),
                    buildText('11.', "Changes to Terms",
                        "We reserve the right to modify or update these terms and conditions at any time. Your continued use of the application after such changes constitutes acceptance of the updated terms."),
                    buildText('12.', "Termination",
                        "We reserve the right to suspend or terminate your account at any time, without prior notice or liability, for any reason whatsoever, including breach of these terms and conditions."),
                    Padding(
                      padding: const EdgeInsets.only(top : 8, left: 10.0, right: 12.0),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'By creating an account, you ',
                                style: lightText),
                            TextSpan(text: 'acknowledge', style: mediumText),
                            TextSpan(
                                text:
                                    ' that you have read, understood, and agree to be bound by these terms and conditions.',
                                style: lightText)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildText(
    String number,
    String title,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number  ',
            style: mediumText,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$title:  ',
                    style: mediumText,
                  ),
                  TextSpan(
                    text: '$text',
                    style: lightText,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPrivacyPolicyText(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '6.  ',
            style: mediumText,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Privacy Policy: ',
                    style: mediumText,
                  ),
                  const TextSpan(
                    text:
                        'By using the application, you agree to the terms of our Privacy Policy. Please review the ',
                    style: lightText,
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: lightText.copyWith(
                      decoration:
                          TextDecoration.underline, 
                      color: Colors.blue, 
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyPolicy()),
                        );
                      },
                  ),
                  const TextSpan(
                    text:
                        ' to understand how your personal information is collected, used, and shared.',
                    style: lightText,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const TextStyle lightText = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontFamily: 'Poppins',
  height: 0,
);
const TextStyle mediumText = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  height: 0,
);
const TextStyle boldText = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  height: 0,
);
