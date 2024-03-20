import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoutify/model/account.dart';

class ScoutifyComponents {
  Widget filledNormalButton(
    BuildContext context,
    String text, {
    Function()? onTap,
    double? width,
  }) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          width: width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFF3B4367)),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget outlinedButton(
      {required double height,
      required double width,
      required String text,
      required Function() onTap,
      TextStyle? style}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFFFC600),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            text,
            style: style,
          )),
        ),
      ),
    );
  }

  Widget filledButton(
      {required double height,
      required double width,
      required String text,
      required Function() onTap,
      required Color color,
      TextStyle? style}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFFFC600),
                width: 3,
              ),
              color: color,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            text,
            style: style,
          )),
        ),
      ),
    );
  }

  Widget buildTextBox(
      {required TextEditingController controller,
      required String hint,
      Icon? prefixIcon,
      Icon? suffixIcon,
      Function()? onPressedIcon,
      Function(String text)? onChanged,
      bool readOnly = false,
      Border? border,
      List<TextInputFormatter>? formatters}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: border,
          color: !readOnly
              ? Colors.white
              : const Color.fromARGB(255, 233, 233, 233),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          readOnly: readOnly,
          inputFormatters: formatters,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: suffixIcon,
                    onPressed: onPressedIcon,
                  )
                : null,
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 200, 200, 200),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
    );
  }

  Widget buildPasswordTextBox({
    required TextEditingController controller,
    required String hint,
    required bool isHidden,
    Function()? onPressedIcon,
    Function(String text)? onChanged,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller,
          obscureText: isHidden,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: isHidden
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              onPressed: onPressedIcon,
            ),
            hintText: hint,
          ),
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
    );
  }

  PreferredSize normalAppBar(String title, BuildContext context) {
    return PreferredSize(
      preferredSize: MediaQuery.sizeOf(context),
      child: Container(
        color: const Color(0xFF2E3B78),
        child: SafeArea(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 75,
            decoration: const BoxDecoration(color: Color(0xFF2E3B78)),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize appBarWithBackButton(String title, BuildContext context) {
    return PreferredSize(
      preferredSize: MediaQuery.sizeOf(context),
      child: Container(
        color: const Color(0xFF2E3B78),
        child: SafeArea(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 75,
            decoration: const BoxDecoration(color: Color(0xFF2E3B78)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: IconButton(
                          disabledColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF3B3F65),
                          )),
                    ),
                    const Spacer(),
                    Transform.translate(
                      offset: const Offset(-25, 0),
                      child: Text(
                        title,
                        textScaler: TextScaler.noScaling,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildInputBoxWithEditButton(
      String title, TextEditingController controller, BuildContext context,
      {Function()? onTap}) {
    return Container(
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
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                controller: controller,
                readOnly: true,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                maxLines: 1,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 1, left: 10),
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 183, 183, 183),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                    border: InputBorder.none,
                    labelText: title),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Material(
                    child: InkWell(
                      onTap: onTap,
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF008CFF),
                            fontFamily: 'Poppins',
                            color: Color(0xFF008CFF)),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildInputBox(String title, TextEditingController controller) {
    return Container(
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
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: TextField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          maxLines: 1,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 1, left: 10),
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 183, 183, 183),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
              border: InputBorder.none,
              labelText: title),
        ),
      ),
    );
  }

  Stack buildCard(Account account) {
    double size = 20;

    double width = 76;
    if (account.scoutInfo.unit == 'None') {
      size = 23;
      width = 100;
    }
    return Stack(
      children: [
        Image.asset(
          'assets/images/card_profile_NEW.png',
          width: 328,
        ),
        Positioned.fill(
          child: Column(
            children: [
              const SizedBox(
                height: 29,
              ),
              Image.asset('assets/images/icon_pengakap.png'),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'PERSEKUTUAN PENGAKAP MALAYSIA NEGERI JOHOR',
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                'Scout Association of Malaysia Johor State',
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 9,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                'Diperbadankan dibawah Akta Parlimen No.784 Tahun 1968 (Semakan 2016), Enacted under Parliament Act No.784 (Revised 2016)',
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 3,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Container(
                width: 140,
                height: 140,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(
                    side: BorderSide(width: 4, color: Color(0xFF00579E)),
                  ),
                ),
                child: Builder(builder: (context) {
                  if (account.imageURL == null) {
                    return const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profileDefault.png'));
                  }
                  return CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${account.imageURL}?v=${DateTime.now().millisecondsSinceEpoch}'));
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 10),
                child: SizedBox(
                  height: 43,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          account.scoutInfo.cardName ??= '-',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          textScaleFactor: 1.0,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'Hafontia',
                            fontWeight: FontWeight.w700,
                            height: 0,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Builder(builder: (context) {
                          if (account.isMember) {
                            return const Icon(
                              Icons.verified,
                              size: 18,
                              color: Colors.white,
                            );
                          } else {
                            return Container();
                          }
                        }),
                      )
                    ],
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 44,
                  maxHeight: 57,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    account.scoutInfo.position,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    textScaleFactor: 1.0,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Hafontia',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 34.0, top: 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width,
                          child: Text(
                            'NO AHLI',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 2.5,
                          child: Text(
                            textScaleFactor: 1.0,
                            ': ${account.scoutInfo.noAhli}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width,
                          child: Text(
                            account.scoutInfo.noTauliah != null
                                ? 'NO TAULIAH'
                                : 'MANIKAYU',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 2.5,
                          child: Text(
                            ': ${account.scoutInfo.noTauliah ?? account.scoutInfo.manikayu}',
                            overflow: TextOverflow.ellipsis,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        )
                      ],
                    ),
                    Builder(builder: (context) {
                      if (account.scoutInfo.unit != null) {
                        return Row(
                          children: [
                            SizedBox(
                              width: width,
                              child: Text(
                                'UNIT',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size,
                                  fontFamily: 'Hafontia',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 2.5,
                              child: Text(
                                ': ${account.scoutInfo.unit}',
                                textScaleFactor: 1.0,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size,
                                  fontFamily: 'Hafontia',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                    Row(
                      children: [
                        SizedBox(
                          width: width,
                          child: Text(
                            account.scoutInfo.negara == null
                                ? 'DAERAH'
                                : 'NEGARA',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 2.5,
                          child: Text(
                            ': ${account.scoutInfo.negara ?? account.scoutInfo.daerah}',
                            overflow: TextOverflow.ellipsis,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 30,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/icons/Scoutify_logo.png'),
                      const Text(
                        ' JOHOR SCOUT DIGITAL ID',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Color(0xFF3B3F65),
                          fontSize: 12,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSpecialCard(Account account) {
    double size = 27;
    double width = 120;
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xFFF7CF42), width: 5),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: Color(0xFFF7CF42),
                      spreadRadius: 2,
                      blurRadius: 20),
                ]),
            child: Image.asset(
              'assets/images/card_profile_NEW.png',
              width: 328,
            )),
        Positioned.fill(
          child: Column(
            children: [
              const SizedBox(
                height: 29,
              ),
              Image.asset('assets/images/icon_pengakap.png'),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'PERSEKUTUAN PENGAKAP MALAYSIA NEGERI JOHOR',
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                'Scout Association of Malaysia Johor State',
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 9,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                'Diperbadankan dibawah Akta Parlimen No.784 Tahun 1968 (Semakan 2016), Enacted under Parliament Act No.784 (Revised 2016)',
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 3,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Container(
                width: 140,
                height: 140,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(
                    side: BorderSide(width: 4, color: Color(0xFF00579E)),
                  ),
                ),
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        '${account.imageURL}?v=${DateTime.now().millisecondsSinceEpoch}')),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 10),
                child: SizedBox(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          account.scoutInfo.cardName ??= '-',
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.0,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'Hafontia',
                            fontWeight: FontWeight.w700,
                            height: 0,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Builder(builder: (context) {
                          if (account.isMember) {
                            return const Icon(
                              Icons.verified,
                              size: 18,
                              color: Colors.white,
                            );
                          } else {
                            return Container();
                          }
                        }),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: AutoSizeText(
                    account.scoutInfo.position,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size,
                      fontFamily: 'Hafontia',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 34.0, top: 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width,
                          child: Text(
                            'NO AHLI',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 2.5,
                          child: Text(
                            ': ${account.scoutInfo.noAhli}',overflow: TextOverflow.ellipsis,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width,
                          child: Text(
                            account.scoutInfo.noTauliah != null
                                ? 'NO TAULIAH'
                                : 'MANIKAYU',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 2.5,
                          child: Text(
                            ': ${account.scoutInfo.noTauliah ?? account.scoutInfo.manikayu}',
                            overflow: TextOverflow.ellipsis,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        )
                      ],
                    ),
                    Builder(builder: (context) {
                      if (account.scoutInfo.unit != null) {
                        return Row(
                          children: [
                            SizedBox(
                              width: width,
                              child: Text(
                                'UNIT',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size,
                                  fontFamily: 'Hafontia',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(width: width * 2.5,
                              child: Text(
                                ': ${account.scoutInfo.unit}',
                                textScaleFactor: 1.0,overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size,
                                  fontFamily: 'Hafontia',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                    Row(
                      children: [
                        SizedBox(
                          width: width,
                          child: Text(
                            account.scoutInfo.negara == null
                                ? 'DAERAH'
                                : 'NEGARA',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 2.5,
                          child: Text(
                            ': ${account.scoutInfo.negara ?? account.scoutInfo.daerah}',
                            textScaleFactor: 1.0,overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size,
                              fontFamily: 'Hafontia',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 30,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/icons/Scoutify_logo.png'),
                      const Text(
                        ' JOHOR SCOUT DIGITAL ID',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Color(0xFF3B3F65),
                          fontSize: 12,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}
