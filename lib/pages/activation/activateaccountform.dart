import 'package:flutter/gestures.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:flutter/material.dart';
import 'package:scoutify/model/account.dart';
import 'package:scoutify/pages/activation/confirmemail.dart';
import 'package:scoutify/pages/homepage/termcondition.dart';

class ActivateAccountForm extends StatefulWidget {
  Account account;
  ActivateAccountForm({super.key, required this.account});

  @override
  State<ActivateAccountForm> createState() =>
      _ActivateAccountFormState(account);
}

class _ActivateAccountFormState extends State<ActivateAccountForm> {
  Account account;
  bool agreed = false;
  _ActivateAccountFormState(this.account);

  TextEditingController phone = TextEditingController(),
      email = TextEditingController(),
      confirmEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScoutifyComponents().appBarWithBackButton('Activate Account', context),
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
                  controller: TextEditingController(text: account.icNo),
                  hint: '',
                  prefixIcon: const Icon(Icons.person_outline),
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
                  controller: TextEditingController(text: account.fullname),
                  hint: '',
                  prefixIcon: const Icon(Icons.person_outline),
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
                  controller: TextEditingController(text: account.phoneNo),
                  hint: 'Phone number',
                  prefixIcon: const Icon(Icons.phone),
                  border: Border.all(color: Colors.black),
                  readOnly: true),
              const SizedBox(
                height: 20,
              ),
              buildText('Email'),
              const SizedBox(
                height: 10,
              ),
              ScoutifyComponents().buildTextBox(
                  controller: TextEditingController(text: account.email),
                  hint: 'Email',
                  prefixIcon: const Icon(Icons.mail),
                  border: Border.all(color: Colors.black),
                  readOnly: true),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                    value: agreed,
                    onChanged: (value) {
                      setState(() {
                        agreed = !agreed;
                      });
                    },
                    activeColor: const Color(0xFF2E3B78),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'I agree with ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                          ),
                        ),
                        TextSpan(
                          text: 'terms & conditions',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            color: Colors.black
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TermAndCondition()),
                              );
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ScoutifyComponents().filledButton(
                height: 55,
                width: MediaQuery.sizeOf(context).width,
                text: 'CONFIRM',
                onTap: () async {
                  if (!agreed) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Please agree to the terms and conditions!')));
                    return;
                  }
        
                  print(account.email);
        
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConfirmEmailActivationPage(
                          email: account.email!)));
                },
                color: const Color(0xFF2E3B78),
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
}
