// ignore_for_file: no_logic_in_create_state, must_be_immutable, camel_case_types

import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/activity.dart';
import 'package:scoutify/pages/attendance/new_attendance.dart';
import 'package:scoutify/pages/attendance/recordAttendance.dart';
import 'package:scoutify/pages/attendance/showAllParticipants.dart';
import 'package:flutter/material.dart';

class attendancePage3 extends StatefulWidget {
  Activity activity;
  String attendancekey;
  DateTime timePicked;
  attendancePage3(
      {super.key,
      required this.activity,
      required this.attendancekey,
      required this.timePicked});

  @override
  State<attendancePage3> createState() =>
      _attendancePage3State(activity, attendancekey, timePicked);
}

class _attendancePage3State extends State<attendancePage3> {
  Activity activity;
  String attendancekey;
  DateTime timePicked;
  _attendancePage3State(this.activity, this.attendancekey, this.timePicked);
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar:
              ScoutifyComponents().appBarWithBackButton('Attendances', context),
          body: Container(
            width: _mediaQuery.size.width,
            height: _mediaQuery.size.height,
            color: Colors.white,
            child: Column(children: <Widget>[
              displayActivity(activity, timePicked),
              const SizedBox(height: 30),
              openAttendanceButton(context, activity.activityid, attendancekey,
                  activity, timePicked),
              const SizedBox(height: 15),
              showParticipantButton(context, activity, timePicked),
            ]),
          )),
    );
  }
}

Widget displayActivity(Activity activity, DateTime timePicked) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 35),
      const Padding(
        padding: EdgeInsets.only(left: 5.0),
        child: Text(
          'Activity',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: .2,
              fontFamily: 'Poppins'),
        ),
      ),
      const SizedBox(height: 25),
      theActivity(
        activityName: activity.name,
        activityID: '011220',
        activityLocation: activity.location,
        activityOrgnzr: 'PPM NEGERI JOHOR',
        enddate: activity.enddate,
        startdate: activity.startdate,
        timePicked: timePicked,
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
  DateTime startdate, enddate, timePicked;

  theActivity(
      {required this.activityName,
      required this.activityID,
      required this.activityLocation,
      required this.activityOrgnzr,
      required this.startdate,
      required this.enddate,
      required this.timePicked});

  @override
  State<theActivity> createState() => _theActivityState(
      activityName,
      activityID,
      activityLocation,
      activityOrgnzr,
      startdate,
      enddate,
      timePicked);
}

class _theActivityState extends State<theActivity> {
  String activityName, activityID, activityLocation, activityOrgnzr;
  DateTime startdate, enddate, timePicked;
  _theActivityState(this.activityName, this.activityID, this.activityLocation,
      this.activityOrgnzr, this.startdate, this.enddate, this.timePicked);
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.85,
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
              activityName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    activityLocation,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
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
                  '${timePicked.day} ${monthName[timePicked.month - 1]} 2023',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
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
                    fontSize: 12,
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

Widget openAttendanceButton(
    context, activityid, secondkey, activity, DateTime dateSelected) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewAttendanceRecordPage(
                activityid: activityid,
                secondkey: secondkey,
                activity: activity,
                dateSelected: dateSelected,
              )));
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFF2E3B78),
      elevation: 0,
      fixedSize: const Size(355, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: const Text('Open for attendances',
        style: TextStyle(
          fontSize: 14,
          letterSpacing: .3,
          color: Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins',
        )),
  );
}

Widget showParticipantButton(
    BuildContext context, Activity activity, DateTime timePicked) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => showAllParticipants(
                activity: activity,
                timePicked: timePicked,
              )));
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.transparent,
      elevation: 0,
      fixedSize: const Size(355, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          width: 2,
          color: Color(0xFF2C225B),
          style: BorderStyle.solid,
        ),
      ),
    ),
    child: const Text('Show all participants',
        style: TextStyle(
          color: Color(0xFF2C225B),
          fontSize: 14,
          letterSpacing: .3,
          fontFamily: 'Poppins',
        )),
  );
}
