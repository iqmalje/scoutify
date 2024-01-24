// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:escout/backend/backend.dart';
import 'package:escout/model/activity.dart';
import 'package:flutter/material.dart';

class attendancePage2 extends StatefulWidget {
  Activity activity;
  String attendancekey;
  attendancePage2(
      {super.key, required this.activity, required this.attendancekey});

  @override
  State<attendancePage2> createState() =>
      _attendancePage2State(activity, attendancekey);
}

class _attendancePage2State extends State<attendancePage2> {
  TextEditingController scoutid = TextEditingController();

  Activity activity;
  String attendancekey;

  _attendancePage2State(this.activity, this.attendancekey);
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);

    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        child: Scaffold(
            body: Container(
          width: _mediaQuery.size.width,
          height: _mediaQuery.size.height,
          color: const Color.fromRGBO(237, 237, 237, 100),
          child: Column(children: <Widget>[
            _appBar(context),
            displayActivity(context, activity),
            addParticipant(scoutid),
            _addButton(scoutid, activity, context),
          ]),
        )),
      ),
    );
  }
}

Widget _appBar(context) {
  return Container(
    width: MediaQuery.sizeOf(context).width,
    height: 90,
    decoration: const BoxDecoration(color: Color(0xFF2C225B)),
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
          'Add Participant',
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
  );
}

Widget _backButton(context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 25),
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 25,
          color: const Color.fromRGBO(59, 63, 101, 100),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    ),
  );
}

Widget displayActivity(BuildContext context, Activity activity) {
  DateTime startdate = activity.startdate;
  DateTime enddate = activity.startdate;
  List<String> monthName = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 35),
      const Padding(
        padding: EdgeInsets.only(left: 5.0),
        child: Text(
          'Activity',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: .3,
          ),
        ),
      ),
      const SizedBox(height: 25),
      Container(
        width: MediaQuery.sizeOf(context).width * 0.85,
        height: 120,
        decoration: ShapeDecoration(
          color: const Color(0xFFFAFAFA),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                activity.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    activity.location,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${startdate.day} - ${enddate.day} ${monthName[enddate.month - 1]} 2023',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  )
                ],
              ),
              const Row(
                children: [
                  Icon(Icons.account_circle),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'PPM NEGERI JOHOR',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}

class theActivity extends StatefulWidget {
  final String activityName;
  final String activityID;
  final String activityLocation;
  //final DateTime activityDate;
  final String activityOrgnzr;

  theActivity(
      {required this.activityName,
      required this.activityID,
      required this.activityLocation,
      required this.activityOrgnzr});

  @override
  State<theActivity> createState() => _theActivityState();
}

class _theActivityState extends State<theActivity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 385,
      height: 173,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(251, 251, 251, 100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 18, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //acitivity name
            Text(
              widget.activityName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: .3,
              ),
            ),
            const SizedBox(height: 5),

            //acitivity ID
            Text(
              '(Event ID: ' + widget.activityID + ')',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 15),

            //acitivity location, date, organizer)
            icon_activity(
                widget.activityLocation, const Icon(Icons.location_on)),
            icon_activity("date", const Icon(Icons.calendar_today)),
            icon_activity(widget.activityOrgnzr,
                const Icon(Icons.account_circle_rounded)),
          ],
        ),
      ),
    );
  }
}

Widget icon_activity(String detail, Icon icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: <Widget>[
        Icon(
          icon.icon,
          color: const Color.fromRGBO(44, 34, 91, 100),
        ),
        const SizedBox(width: 15),
        Text(
          detail,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.normal, letterSpacing: .3),
        )
      ],
    ),
  );
}

Widget addParticipant(TextEditingController scoutid) {
  return Padding(
    padding: const EdgeInsets.only(top: 35),
    child:
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const Text(
        'Add participant Scout ID',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: .3,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 20),

      //input scout ID
      SizedBox(
        height: 55,
        width: 370,
        child: TextField(
          controller: scoutid,
          decoration: InputDecoration(
            hintText: 'Participant Scout ID',
            hintStyle: const TextStyle(
                fontSize: 14.0, color: Color.fromRGBO(147, 151, 160, 100)),
            contentPadding: const EdgeInsets.only(left: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide.none),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ),
    ]),
  );
}

Widget _addButton(TextEditingController scoutid, Activity activity, context) {
  return Expanded(
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF2C225B),
                elevation: 0,
                fixedSize: const Size(355, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                if (scoutid.text.isEmpty) return;
                await SupabaseB()
                    .addAttendanceByScoutID(activity.activityid, scoutid.text);

                Navigator.of(context).pop();
              },
              child: const Text(
                'ADD PARTICIPANT',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )));
}
