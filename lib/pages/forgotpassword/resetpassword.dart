// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';

class ResetPasswordPage extends StatefulWidget {
  String email;
  
  ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState(email);
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String email;
  bool isShown = false, isConfirmShown = false;
  TextEditingController password = TextEditingController(),
      confirmpassword = TextEditingController();
  _ResetPasswordPageState(this.email);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF2C225B), Color(0xFF2E3B78)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.1),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Please enter your new password! ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextField(
                        controller: password,
                        obscureText: !isShown,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShown = !isShown;
                                  });
                                },
                                icon: !isShown
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(Icons.visibility_off),
                              ),
                            ),
                          ),
                          hintText: 'Password',
                          filled: true, // Fill the background with color

                          fillColor:
                              Colors.white, // Set the background color to white
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextField(
                        controller: confirmpassword,
                        onChanged: (value) {
                          setState(() {});
                        },
                        obscureText: !isConfirmShown,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Confirm Password',
                          filled: true, // Fill the background with color
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isConfirmShown = !isConfirmShown;
                                  });
                                },
                                icon: !isConfirmShown
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(Icons.visibility_off),
                              ),
                            ),
                          ),
                          fillColor:
                              Colors.white, // Set the background color to white
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Builder(builder: (context) {
                        if (password.text != confirmpassword.text) {
                          return const Center(
                            child: Text(
                              'Your password did not match!',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 112, 101),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      splashColor: const Color.fromARGB(255, 123, 90, 255),
                      onTap: () async {
                        if (password.text != confirmpassword.text) {
                          return;
                        }

                        try {
                          await AccountDAO()
                              .updatePassword(email, password.text);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/signin', (_) => false);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                          return;
                        }
                      },
                      child: Ink(
                        width: MediaQuery.sizeOf(context).width * 0.8,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
