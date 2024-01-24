// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'dart:async';

import 'package:escout/backend/backend.dart';
import 'package:escout/pages/forgotpassword/resetpassword.dart';
import 'package:flutter/material.dart';

class VerifyResetPassword extends StatefulWidget {
  String email;
  VerifyResetPassword({super.key, required this.email});

  @override
  State<VerifyResetPassword> createState() => _VerifyResetPasswordState(email);
}

class _VerifyResetPasswordState extends State<VerifyResetPassword> {
  _VerifyResetPasswordState(this.email);

  String email;

  Timer? _timer;

  List<TextEditingController> OTP =
      List.generate(6, (index) => TextEditingController());

  int _start = 330;
  @override
  void initState() {
    SupabaseB().sendPasswordOTP(email);
    //initiate timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        _timer!.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
        backgroundColor: const Color(0xFF3B3F65),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.1),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Ink(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white),
                          child: Image.asset('assets/images/lock_icon.png'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Verify Reset Password Token',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        const Text(
                          'An 6-digit code has been sent to',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Text(
                          email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              6,
                              (index) => Container(
                                    width: 43,
                                    height: 60,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x143D6886),
                                          blurRadius: 2,
                                          offset: Offset(0, 3),
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: Color(0x193D6886),
                                          blurRadius: 9,
                                          offset: Offset(0, 6),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: TextField(
                                        controller: OTP[index],
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          if (value.length == 1) {
                                            node.nextFocus();
                                          }
                                        },
                                        textInputAction: TextInputAction.next,
                                        maxLength: 1,
                                        style: const TextStyle(fontSize: 25),
                                        decoration: const InputDecoration(
                                            counterText: "",
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              'The OTP will be expired in ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Text(
                              formattedTime(timeInSecond: _start),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
                          const Text(
                            'Didn’t receive the code? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await SupabaseB().sendPasswordOTP(email);

                              //reset timer
                              if (_timer!.isActive) _timer!.cancel();

                              _start = 330;
                              _timer = Timer.periodic(
                                  const Duration(seconds: 1), (timer) {
                                if (_start == 0) {
                                  _timer!.cancel();
                                } else {
                                  setState(() {
                                    _start--;
                                  });
                                }
                              });
                            },
                            child: const Text(
                              'Resend',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                height: 0,
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      splashColor: const Color.fromARGB(255, 123, 90, 255),
                      onTap: () async {
                        String OTPcollected = "";

                        for (var element in OTP) {
                          if (element.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Fill in all OTP code')));
                            continue;
                          }
                          OTPcollected += element.text;
                        }



                        try {
                          await SupabaseB()
                              .verifyPasswordOTP(email, OTPcollected);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ResetPasswordPage(email: email)));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));

                          return;
                        }
                      },
                      child: Ink(
                        width: 300,
                        height: 50,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 3, color: Color(0xFFFFC600)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Center(
                            child: Text(
                          'CONFIRM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  String formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
