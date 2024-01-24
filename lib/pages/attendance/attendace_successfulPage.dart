import 'package:flutter/material.dart';

class attendace_successfulPage extends StatefulWidget {
  const attendace_successfulPage({super.key});

  @override
  State<attendace_successfulPage> createState() =>
      _attendace_successfulPageState();
}

class _attendace_successfulPageState extends State<attendace_successfulPage> {
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);

    return Scaffold(
          body: Container(
        width: _mediaQuery.size.width,
        height: _mediaQuery.size.height,
        //color: Color.fromRGBO(237, 237, 237, 100),
        color: Colors.amber,
        child: succesfulPopUp(),
      ));
  }
}

Widget succesfulPopUp() {
  return Column(
    children: <Widget>[
      Container(
        width: 300,
        height: 465,
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
              'Attendance successful',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: .3,
              ),
            ),
            SizedBox(height: 10),
            Container(
                height: 190,
                child: Image.asset('assets/images/attendance_successful.png')),
            SizedBox(height: 9),
            Text(
              'Scout Information',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: .3,
              ),
              textAlign: TextAlign.center,
            ),
            scoutDetails(
              scoutName: 'Fikri Akaml', 
              scoutID: '12345', 
              scoutDistrict: 'Batu Pahat'
            ),
            SizedBox(height: 25),
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


class scoutDetails extends StatelessWidget {
  final String scoutID;
  final String scoutName;
  final String scoutDistrict;

  scoutDetails({
    required this.scoutID,
    required this.scoutName,
    required this.scoutDistrict,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 15,),
        Text(
          'Scout ID: ' + scoutID,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            letterSpacing: .3,
          ),
        ),
        SizedBox(height: 7,),
        Text(
          'Scout Name: ' + scoutName,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            letterSpacing: .3,
          ),
        ),
        SizedBox(height: 7,),
        Text(
          'District: ' + scoutDistrict,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            letterSpacing: .3,
          ),
        ),
        SizedBox(height: 7,),
      ],
    );
  }
}