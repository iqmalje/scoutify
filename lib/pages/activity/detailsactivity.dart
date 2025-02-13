// ignore_for_file: must_be_immutable

import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/activityDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/activity.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/pages/activity/createactivitypage.dart';
import 'package:scoutify/pages/attendance/attendancePage3.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsActivity extends StatefulWidget {
  Activity activity;
  DetailsActivity({super.key, required this.activity});

  @override
  State<DetailsActivity> createState() => _DetailsActivityState(activity);
}

class _DetailsActivityState extends State<DetailsActivity> {
  _DetailsActivityState(this.activity);

  Activity activity;

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

  List<String> monthAbbreviations = [];

  @override
  void initState() {
    monthAbbreviations =
        monthName.map((month) => month.substring(0, 3)).toList();
    super.initState();
  }

  List<DateTime> daysInvolved = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScoutifyComponents()
          .appBarWithBackButton('Details Activity', context),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).width * 2 / 3,
                    child: Center(
                      child: Image.network(
                        activity.imageurl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 90,
                        height: 20,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                activity.category,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                  height: 15,
                                  child: activity.category == "MEETING"
                                      ? Image.asset(
                                          "assets/icons/meeting_icon.png")
                                      : Image.asset(
                                          "assets/icons/camping_icon.png")),
                            ],
                          ),
                        ),
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       width: 10,
                        //       height: 10,
                        //       decoration: const ShapeDecoration(
                        //         color: Colors.black,
                        //         shape: OvalBorder(),
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 5,
                        //     ),
                        //     Text(
                        //       activity.category,
                        //       style: const TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 12,
                        //         fontFamily: 'Poppins',
                        //         fontWeight: FontWeight.w400,
                        //         height: 0,
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.85,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFAFAFA),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        activity.name,
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
                              activity.location,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
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
                            dateFormatter(activity.startdate, activity.enddate),
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
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Builder(builder: (context) {
                      if (CurrentAccount.getInstance().isAdminToggled) {
                        return EditButton();
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Builder(builder: (context) {
                if (CurrentAccount.getInstance().isAdminToggled) {
                  return buildDateSelector(context);
                } else {
                  return buildAttendedList(context, activity.activityid);
                }
              }),
              const SizedBox(
                height: 10,
              ),
              Builder(builder: (context) {
                if (CurrentAccount.getInstance().isAdminToggled) {
                  return InkWell(
                    onTap: () async {
                      //warning
                      bool? isDelete = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Are you sure to delete this activity?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Yes')),
                              ],
                            );
                          });

                      if (isDelete != null && isDelete) {
                        await ActivityDAO().deleteActivity(activity);
                        Navigator.of(context).pop();
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Ink(
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2E3B78),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Delete activity',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAttendedList(BuildContext context, String activityid) {
    List<dynamic> attendance = [];
    List<DateTime> timeAttended = [];
    return FutureBuilder(
        future: ActivityDAO().getAttendance(activityid),
        builder: (context, snapshot) {
          if (!CurrentAccount.getInstance().isAdminToggled) return Container();

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          attendance = snapshot.data!;
          for (var thing in attendance) {
            timeAttended.add(DateTime.parse(thing['time_attended'])
                .add(const Duration(hours: 8)));
          }
          return Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: 70,
                  minWidth: MediaQuery.sizeOf(context).width * 0.85,
                ),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
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
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'You successfully attended this event. ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: 0,
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.85,
                                maxHeight: 180),
                            child: ListView(
                              shrinkWrap: true,
                              children: List.generate(
                                  attendance.length,
                                  (index) => Center(
                                          child: Text(
                                        'Attendance Record: ${DateFormat('dd/MM/yyyy; hh:mm a').format(timeAttended[index])}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ))),
                            ))
                      ]),
                ),
              ),
            ],
          );
        });
  }

  Widget buildDateSelector(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Select the date of activity',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.2,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: activity.dateInvolved.length,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.15 / 2),
              itemBuilder: (context, index) {
                return buildDate(context, index);
              }),
        ),
      ],
    );
  }

  Widget buildDate(BuildContext context, int index) {
    List<String> monthAbbreviations =
        monthName.map((month) => month.substring(0, 3)).toList();

    DateTime date = activity.dateInvolved.elementAt(index);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => attendancePage3(
                    activity: activity,
                    timePicked: date,
                    attendancekey: '${date.day}${date.month}${date.year}')));
          },
          borderRadius: BorderRadius.circular(5),
          child: Ink(
            width: MediaQuery.sizeOf(context).width * 0.85,
            height: 40,
            decoration: ShapeDecoration(
              color: const Color(0xFF2E3B78),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            child: Center(
              child: Text(
                '${date.day} ${monthAbbreviations[date.month - 1]} ${date.year}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget EditButton() {
    return SizedBox(
      width: 90.0,
      height: 30.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateActivityPage(
                    activity: activity,
                  )));
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFF2E3B78),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.edit,
              size: 12.0,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              'Edit',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String dateFormatter(DateTime startdate, DateTime enddate) {
    if (startdate.day == enddate.day &&
        startdate.month == enddate.month &&
        startdate.year == enddate.year) {
      return '${startdate.day} ${monthAbbreviations[startdate.month - 1]} ${startdate.year}';
    } else {
      return '${activity.startdate.day} ${monthAbbreviations[activity.startdate.month - 1]} - ${activity.enddate.day} ${monthAbbreviations[activity.enddate.month - 1]} ${activity.enddate.year}';
    }
  }
}


/// RESTORED 