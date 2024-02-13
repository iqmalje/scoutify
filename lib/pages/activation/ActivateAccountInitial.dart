import 'package:scoutify/components/components.dart';
import 'package:scoutify/pages/activation/activateaccountform.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ActivateAccountInitial extends StatefulWidget {
  const ActivateAccountInitial({super.key});

  @override
  State<ActivateAccountInitial> createState() => _ActivateAccountInitialState();
}

class _ActivateAccountInitialState extends State<ActivateAccountInitial> {
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
                  'Activate Account',
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
                  'Please enter your identification ID',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'MyKad No.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ScoutifyComponents().buildTextBox(
                    controller: TextEditingController(),
                    formatters: [
                      MaskTextInputFormatter(
                          mask: '######-##-####',
                          filter: {'#': RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy)
                    ],
                    hint: 'Identification ID',
                    readOnly: false,
                    prefixIcon: const Icon(Icons.person_outline)),
                const SizedBox(
                  height: 40,
                ),
                ScoutifyComponents().outlinedButton(
                    height: 60,
                    width: MediaQuery.sizeOf(context).width,
                    text: 'CONFIRM',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ActivateAccountForm()));
                    },
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
