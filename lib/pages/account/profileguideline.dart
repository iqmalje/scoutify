import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/account.dart';
import 'package:scoutify/pages/account/scoutid.dart';
import 'package:flutter/material.dart';

class ProfilePictureGuideline extends StatefulWidget {
  final Account account;
  ProfilePictureGuideline({super.key, required this.account});

  @override
  State<ProfilePictureGuideline> createState() =>
      _ProfilePictureGuidelineState(account);
}

class _ProfilePictureGuidelineState extends State<ProfilePictureGuideline> {
  Account account;

  _ProfilePictureGuidelineState(this.account);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          ScoutifyComponents().appBarWithBackButton('Manage Account', context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Upload Profile Picture',
                style: styleReturner(FontStyleText.header),
              ),
              Text(
                'Here are the guideline for uploading profile picture.',
                style: styleReturner(FontStyleText.paragraph),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'File Type & Size',
                style: styleReturner(FontStyleText.header2),
              ),
              const SizedBox(
                height: 5,
              ),
              Bullet(
                'File Format: PNG, JPEG, JPG',
                style: styleReturner(FontStyleText.paragraph),
              ),
              Bullet(
                'Max File Size: 5MB',
                style: styleReturner(FontStyleText.paragraph),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Resolution & Dimensions',
                style: styleReturner(FontStyleText.header2),
              ),
              Bullet('Recommended Resolution: 1080 x 1080 pixels',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              Bullet('Minimum Resolution: 300 x 300 pixels',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Aspect Ratio',
                style: styleReturner(FontStyleText.header2),
              ),
              Bullet('Maintain a square aspect ratio (1:1) for uniform display',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Content Guidelines',
                style: styleReturner(FontStyleText.header2),
              ),
              Bullet('No nudity, violence, or inappropriate content.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              Bullet(
                  'Profile pictures should represent the user or personal branding.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Copyright & Ownership',
                style: styleReturner(FontStyleText.header2),
              ),
              Bullet('Only upload pictures you own or have right to use.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              Bullet(
                  'Violating copyright or intellectual property rights may result in consequences.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Image Cropping & Editing',
                style: styleReturner(FontStyleText.header2),
              ),
              Bullet(
                  'Be aware of automatic cropping or resizing during upload.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              Bullet(
                  'Edit or adjust your picture before uploading to ensure the best display.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Moderation & Enforcement',
                style: styleReturner(FontStyleText.header2),
              ),
              Bullet('Profile pictures are subject to moderation.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              Bullet(
                  'Inappropriate pictures may lead to account suspension or removal.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Example Profile Picture',
                  style: styleReturner(FontStyleText.header, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/example_profile.png')),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Noted that:',
                style: styleReturner(FontStyleText.header2),
              ),
              Bullet('Set your profile picture background to white.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              Bullet(
                  'Crop your profile picture exactly as shown in the provided example.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              Bullet(
                  'Leave some extra space above your head for a better appearance.',
                  style: styleReturner(
                    FontStyleText.paragraph,
                  )),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Result Profile Picture',
                  style: styleReturner(FontStyleText.header, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/example_card.png')),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Click here to watch a tutorial video on\nuploading your profile picture.',
                  textAlign: TextAlign.center,
                  style: styleReturner(FontStyleText.url),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ScoutifyComponents().filledButton(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width,
                  text: 'UPLOAD PROFILE',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScoutIDPage(account: account)));
                  },
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                  color: const Color(0xFF302E84)),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Bullet extends Text {
  const Bullet(
    String data, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
  }) : super(
          ' • $data',
          key: key,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
}

// text styles
enum FontStyleText { header, header2, paragraph, url }

TextStyle styleReturner(FontStyleText type, {double? fontSize}) {
  switch (type) {
    case FontStyleText.header:
      return TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: fontSize ??= 18);

    case FontStyleText.header2:
      return const TextStyle(
          fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 13);

    case FontStyleText.paragraph:
      return const TextStyle(
          fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 13);
    case FontStyleText.url:
      return const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          fontSize: 13,
          fontStyle: FontStyle.italic,
          color: Color(0xFF002B7F),
          decoration: TextDecoration.underline,
          decorationColor: Color(0xFF002B7F));
    default:
      return const TextStyle();
  }
}
