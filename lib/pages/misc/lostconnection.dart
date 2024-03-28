import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';

class LostConnection extends StatelessWidget {
  final VoidCallback onRefresh;

  const LostConnection({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
    Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: const Text(
        'Please check your device connectivity, and click refresh after you connect to a network',
        textAlign: TextAlign.center,
        textScaleFactor: 1,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          height: 0,
        ),
      ),
    ),
    Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Image.asset("assets/images/no-connection.png")),
    ScoutifyComponents().outlinedButton(
      height: 50,
      width:  MediaQuery.of(context).size.width * 0.75,
      text: "Refresh",
      onTap: onRefresh,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
    ),
    SizedBox(
      height: 50,
    )
          ],
        );
  }
}
