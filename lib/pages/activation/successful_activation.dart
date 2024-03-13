import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';

class ActivationSuccessful extends StatelessWidget {
  const ActivationSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Congrats!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'You have successfully created an account with Scoutify. Please click \'Proceed\' to sign in to your account.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Image.asset(
                        "assets/images/account_creation_successful.png"),
                  ),
                  SizedBox(height: 120),
                  ScoutifyComponents().outlinedButton(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      text: "Proceed",
                      onTap: () => _proceedButton(context),
                      style: TextStyle(color: Colors.white)),SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _proceedButton(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/signin', (_) => false);
  }
}
