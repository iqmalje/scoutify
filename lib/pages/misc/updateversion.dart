import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';

class UpdateVersion extends StatelessWidget {
  const UpdateVersion({super.key});

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
                    'New Update!',
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
                    'Scoutify has released a new update. Please update your Scoutify app to the latest version.',
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
                    child: Image.asset("assets/images/update_version.png"),
                  ),
                  SizedBox(height: 120),
                  ScoutifyComponents().outlinedButton(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      text: "Update",
                      onTap: () => _proceedButton(context),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      )),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _proceedButton(BuildContext context) {
    //TODO: function goes here kemal :D
  }
}
