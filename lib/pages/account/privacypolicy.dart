import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});
  @override
  Widget build(BuildContext context) {
    const TextStyle boldText = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      height: 0,
    );
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

    int ageLimit = 13;
    return Scaffold(
        appBar: ScoutifyComponents()
            .appBarWithBackButton("Privacy Policy", context),
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
                      child: Text("Privacy Policy",
                          textAlign: TextAlign.left, style: boldText),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 12.0),
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: 'This Privacy Policy describes how',
                              style: lightText),
                          TextSpan(
                              text: ' Scoutify Resources (JR0159891-T) ',
                              style: mediumText),
                          TextSpan(
                              text:
                                  '("we", "us", or "our") collects, uses, and shares information when you use our mobile application, Scoutify.',
                              style: lightText)
                        ]))),
                    buildText('1. Information We Collect', TextType.numbered),
                    buildText(
                        'Personal Information: We may collect personal information such as your name, email address, and phone number when you create an account or contact us for support.',
                        TextType.bulletIndented),
                    buildText(
                        'Usage Data: We automatically collect information about how you interact with Scoutify, including your device type, operating system, IP address, and browsing activity.',
                        TextType.bulletIndented),
                    buildText(
                        'Location Information: With your consent, we may collect your precise or approximate location data to provide location-based services within Scoutify.',
                        TextType.bulletIndented),
                    buildText('2. How We Use Information', TextType.numbered),
                    buildText(
                        'We use the information we collect to operate, maintain, and improve Scoutify, as well as to communicate with you and provide customer support.',
                        TextType.bulletIndented),
                    buildText(
                        'We may use your information to personalize your experience within Scoutify, such as displaying relevant content or recommendations.',
                        TextType.bulletIndented),
                    buildText(
                        'We may use aggregated or anonymized data for analytical purposes to understand user demographics, usage patterns, and trends.',
                        TextType.bulletIndented),
                    buildText('3. Information Sharing', TextType.numbered),
                    buildText(
                        'We do not sell, trade, or rent your personal information to third parties for their marketing purposes.',
                        TextType.bulletIndented),
                    buildText(
                        'We may share your information with third-party service providers who assist us in operating Scoutify, conducting our business, or providing services to you.',
                        TextType.bulletIndented),
                    buildText(
                        'We may disclose your information in response to legal requests or to comply with applicable laws, regulations, or legal processes.',
                        TextType.bulletIndented),
                    buildText('4. Data Security', TextType.numbered),
                    buildText(
                        'We implement reasonable security measures to protect your information from unauthorized access, alteration, disclosure, or destruction.',
                        TextType.bulletIndented),
                    buildText(
                        'Despite our efforts, no method of transmission over the internet or electronic storage is completely secure. Therefore, we cannot guarantee absolute security of your information.',
                        TextType.bulletIndented),
                    buildText('5. Children\'s Privacy', TextType.numbered),
                    buildText(
                        'Scoutify is not intended for use by children under the age of $ageLimit. We do not knowingly collect personal information from children under this age. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us so that we can delete the information.',
                        TextType.bulletIndented),
                    buildText(
                        '6. Changes to This Privacy Policy', TextType.numbered),
                    buildText(
                        'We reserve the right to update or modify this Privacy Policy at any time. We will notify you of any changes by posting the revised Privacy Policy within Scoutify. Your continued use of Scoutify after the effective date of the revised Privacy Policy constitutes acceptance of the updated terms.',
                        TextType.bulletIndented),
                    buildText('7. Contact Us', TextType.numbered),
                    buildText(
                        'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at scoutify.my@gmail.com.',
                        TextType.bulletIndented),
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 16.0, left: 10.0, right: 12.0),
                      child: Text(
                        "By using Scoutify, you consent to the collection, use, and sharing of your information as described in this Privacy Policy.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          height: 0,
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

  Widget buildText(String text, TextType type) {
    switch (type) {
      case TextType.numbered:
        return Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 20.0, right: 12.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        );
      case TextType.bulletIndented:
        return Padding(
          padding: const EdgeInsets.only(left: 30, right: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '•  ',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
              Expanded(
                child: Text(
                  '$text',
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}

enum TextType {
  numbered,
  bulletIndented,
}
