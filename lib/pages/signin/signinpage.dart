import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/pages/activation/ActivateAccountInitial.dart';
import 'package:scoutify/pages/activation/activateaccount.dart';
import 'package:scoutify/pages/forgotpassword/forgotpasswordpage.dart';
import 'package:scoutify/pages/homepage/temppage.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController(),
      password = TextEditingController();
  bool isShown = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.08,
            ),
            SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.22,
                child: Image.asset(
                  alignment: Alignment.center,
                  'assets/images/Scoutify_FULL_MAIN.png',
                  width: 400,
                  height: 400,
                )),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.7,

              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF2E3B78), Color(0xFF2C225B)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
              ),
              //The space of the widget for the left edge in the container
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.1,
                  right: MediaQuery.sizeOf(context).width * 0.1),
              // All widget Column
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Welcome and log in column
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          'Welcome to Scoutify',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 65,
                          child: TextField(
                            controller: email,
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              hintText: 'Email',
                              filled: true, // Fill the background with color

                              fillColor: Colors
                                  .white, // Set the background color to white
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 65,
                          child: TextField(
                            controller: password,
                            obscureText: !isShown,
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () => setState(() {
                                  isShown = !isShown;
                                }),
                                child: Builder(builder: (context) {
                                  if (isShown) {
                                    return const Icon(Icons.visibility_off);
                                  } else {
                                    return const Icon(Icons.remove_red_eye);
                                  }
                                }),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              hintText: 'Password',
                              filled: true, // Fill the background with color
                              fillColor: Colors
                                  .white, // Set the background color to white
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage()),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFFFFC600),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFFFFC600),
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        splashColor: const Color.fromARGB(255, 123, 90, 255),
                        onTap: () async {
                          if (email.text.isEmpty || password.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Please fill in all fields!')));
                            return;
                          }
                          try {
                            await AccountDAO()
                                .signIn(email.text, password.text);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>  TempPage()),
                                (route) => false);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                          // //replace
                          //                       Navigator.push(
                          //                         context,
                          //                         MaterialPageRoute(
                          //                             builder: (context) => const TempPage()),
                          //                       );
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
                            'Sign In',
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
                    const SizedBox(
                      height: 18,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ActivateAccountInitial()),
                          );
                        },
                        child: const Text(
                          'Activate your account',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFFFFFFF),
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Powered By",
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 12),
                          ),
                          Image.asset("assets/images/Larabit_Logo_WHITE.png",
                              height: 60)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
