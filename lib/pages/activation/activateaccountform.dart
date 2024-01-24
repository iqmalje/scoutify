import 'package:escout/components/components.dart';
import 'package:flutter/material.dart';

class ActivateAccountForm extends StatefulWidget {
  const ActivateAccountForm({super.key});

  @override
  State<ActivateAccountForm> createState() => _ActivateAccountFormState();
}

class _ActivateAccountFormState extends State<ActivateAccountForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: _appBar(context),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  buildText('MyKad No.'),
                  const SizedBox(
                    height: 10,
                  ),
                  ScoutifyComponents().buildTextBox(
                      controller: TextEditingController(text: '123456-78-9012'),
                      hint: '',
                      prefixIcon: Icon(Icons.person_outline),
                      border: Border.all(color: Colors.black),
                      readOnly: true),
                  const SizedBox(
                    height: 20,
                  ),
                  buildText('Name'),
                  const SizedBox(
                    height: 10,
                  ),
                  ScoutifyComponents().buildTextBox(
                      controller:
                          TextEditingController(text: 'BARDIENNNNNNNNNN'),
                      hint: '',
                      prefixIcon: Icon(Icons.person_outline),
                      border: Border.all(color: Colors.black),
                      readOnly: true),
                  const SizedBox(
                    height: 20,
                  ),
                  buildText('Phone Number'),
                  const SizedBox(
                    height: 10,
                  ),
                  ScoutifyComponents().buildTextBox(
                      controller: TextEditingController(),
                      hint: 'Phone number',
                      prefixIcon: Icon(Icons.phone),
                      border: Border.all(color: Colors.black),
                      readOnly: false),
                  const SizedBox(
                    height: 20,
                  ),
                  buildText('Email'),
                  const SizedBox(
                    height: 10,
                  ),
                  ScoutifyComponents().buildTextBox(
                      controller: TextEditingController(),
                      hint: 'Email',
                      prefixIcon: Icon(Icons.person_outline),
                      border: Border.all(color: Colors.black),
                      readOnly: false),
                  const SizedBox(
                    height: 20,
                  ),
                  buildText('Confirm email'),
                  const SizedBox(
                    height: 10,
                  ),
                  ScoutifyComponents().buildTextBox(
                      controller: TextEditingController(),
                      hint: 'Confirm email',
                      prefixIcon: Icon(Icons.person_outline),
                      border: Border.all(color: Colors.black),
                      readOnly: false),
                  const SizedBox(
                    height: 40,
                  ),
                  ScoutifyComponents().filledButton(
                    height: 55,
                    width: MediaQuery.sizeOf(context).width,
                    text: 'CONFIRM',
                    onTap: () {},
                    color: Color(0xFF2E3B78),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text buildText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        height: 0,
      ),
    );
  }

  PreferredSize _appBar(context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 90,
        decoration: const BoxDecoration(color: Color(0xFF2E3B78)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 30,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(),
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),
            const SizedBox(
              width: 30,
            ),
            const Text(
              'Create Activity',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
