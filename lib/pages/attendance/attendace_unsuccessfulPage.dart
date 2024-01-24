import 'package:flutter/material.dart';

class attendace_unsuccessfulPage extends StatefulWidget {
  const attendace_unsuccessfulPage({super.key});

  @override
  State<attendace_unsuccessfulPage> createState() =>
      _attendace_unsuccessfulPageState();
}

class _attendace_unsuccessfulPageState
    extends State<attendace_unsuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);

    return Scaffold(
        body: Container(
      width: _mediaQuery.size.width,
      height: _mediaQuery.size.height,
      //color: Color.fromRGBO(237, 237, 237, 100),
      color: Colors.amber,
      child: unsuccesfulPopUp(),
    ));
  }
}

Widget unsuccesfulPopUp() {
  return Column(
    children: <Widget>[
      Container(
        width: 300,
        height: 450,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Column(
          children: <Widget>[
            //cancel button
            SizedBox(
              width: 300,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 10, right: 10.0, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.clear),
                      color: Color.fromRGBO(46, 48, 132, 100),
                      iconSize: 25,
                    ),
                  ],
                ),
              ),
            ),

            //notification details
            Text(
              'Attendance unsuccessful',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: .3,
              ),
            ),
            SizedBox(height: 10),
            Container(
                height: 210,
                child:
                    Image.asset('assets/images/attendance_unsuccessful.png')),
            SizedBox(height: 15),
            Text(
              'Please try again to scan your\nScout ID.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.black,
                letterSpacing: .3,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 45),
            Text(
              'Will be closed in 5 seconds',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(102, 102, 102, 100),
                letterSpacing: .3,
              ),
            ),
          ],
        ),
      )
    ],
  );
}
