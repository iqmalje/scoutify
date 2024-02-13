import 'package:scoutify/components/components.dart';
import 'package:flutter/material.dart';

class SetPasswordActivation extends StatefulWidget {
  const SetPasswordActivation({super.key});

  @override
  State<SetPasswordActivation> createState() => _SetPasswordActivationState();
}

class _SetPasswordActivationState extends State<SetPasswordActivation> {
  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF2C225B), Color(0xFF2E3B78), Color(0xFF2E3B78)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //back button
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_new),
                    color: const Color(0xFF3B3F65),
                  ),
                ),

                // title

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Set Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Please enter your password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),
                ScoutifyComponents().buildPasswordTextBox(
                  controller: password,
                  isHidden: isHiddenPassword,
                  onChanged: (text) {
                    setState(() {});
                  },
                  onPressedIcon: () {
                    setState(() {
                      isHiddenPassword = !isHiddenPassword;
                    });
                  },
                  hint: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                ScoutifyComponents().buildPasswordTextBox(
                  controller: confirmPassword,
                  hint: 'Confirm password',
                  isHidden: isHiddenConfirmPassword,
                  onChanged: (text) {
                    setState(() {});
                  },
                  onPressedIcon: () {
                    setState(() {
                      isHiddenConfirmPassword = !isHiddenConfirmPassword;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Builder(builder: (context) {
                  if (confirmPassword.text != password.text) {
                    return const Text(
                      'Password did not match with confirm password!',
                      style: TextStyle(
                          color: Color.fromARGB(255, 249, 109, 99),
                          fontFamily: 'Poppins',
                          fontSize: 13),
                    );
                  } else {
                    return Container();
                  }
                }),
                const SizedBox(
                  height: 30,
                ),
                ScoutifyComponents().outlinedButton(
                    height: 55,
                    width: MediaQuery.sizeOf(context).width,
                    text: 'CONFIRM',
                    onTap: () {},
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
