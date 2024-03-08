// ignore_for_file: use_build_context_synchronously

import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/account.dart';
import 'package:scoutify/pages/activation/activateaccountform.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActivateAccountInitial extends StatefulWidget {
  const ActivateAccountInitial({super.key});

  @override
  State<ActivateAccountInitial> createState() => _ActivateAccountInitialState();
}

class _ActivateAccountInitialState extends State<ActivateAccountInitial> {
  TextEditingController ic = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C225B), Color(0xFF2E3B78)],
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
                    controller: ic,
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
                    onTap: () async {
                      // check db for existing IC
                      try {
                        Account account =
                            await AccountDAO().selectAccountFromIC(ic.text);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ActivateAccountForm(
                                  account: account,
                                )));
                      } on PostgrestException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Please ensure your order is completed and enter the correct IC number. If issues persist, kindly reach out to our support team.")),
                        );
                        print("PostgrestException: ${e.message}");
                      } on Exception catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                        print(e.toString());
                      }
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
