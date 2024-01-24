
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCTest extends StatefulWidget {
  const NFCTest({super.key});

  @override
  State<NFCTest> createState() => _NFCTestState();
}

class _NFCTestState extends State<NFCTest> {
  bool isAvailable = false;
  @override
  void initState() {
// Start Session
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        // Do something with an NfcTag instance.
        // print(tag.data);
        var payload =
            tag.data["ndef"]["cachedMessage"]["records"][0]["payload"];
        print(payload);
        var stringPayload = String.fromCharCodes(payload);
        print(stringPayload);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('hey')]),
      ),
    );
  }
}
