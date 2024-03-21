import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';

class attendancePage extends StatefulWidget {
  const attendancePage({super.key});

  @override
  State<attendancePage> createState() => _attendancePageState();
}

class _attendancePageState extends State<attendancePage> {
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: ScoutifyComponents().appBarWithBackButton('Attendances', context),
        body: Container(
      width: _mediaQuery.size.width,
      height: _mediaQuery.size.height,
      color: const Color.fromRGBO(237, 237, 237, 100),
      child: Column(children: <Widget>[
        _instruction(),
      ]),
    ));
  }
}

Widget _instruction() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      const Text(
        'Please tap your Scout ID here to\nrecord your attendace',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: .3,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 25),
      Image.asset('assets/images/scanCardAttendance.png'),
      const SizedBox(height: 10),
      const Text(
        'Or',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          letterSpacing: .3,
        ),
      ),
      const SizedBox(height: 30),
      addParticpantButton(buttonText: "Add participant manually")
    ],
  );
}

class addParticpantButton extends StatefulWidget {
  final String buttonText;

  addParticpantButton({required this.buttonText});

  @override
  _addParticpantButtonState createState() => _addParticpantButtonState();
}

class _addParticpantButtonState extends State<addParticpantButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(widget.buttonText,
          style: const TextStyle(
            fontSize: 14,
            letterSpacing: .3,
          )),
      style: ElevatedButton.styleFrom(
        primary: const Color.fromRGBO(44, 34, 91, 100),
        elevation: 0,
        fixedSize: const Size(330, 40),
      ),
    );
  }
}
