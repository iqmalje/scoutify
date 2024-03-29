// ignore_for_file: must_be_immutable

import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/activityDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/pages/feed/createFeedPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/activity.dart';

class Detailsprogram extends StatefulWidget {
  Activity activity;
  Detailsprogram({super.key, required this.activity});

  @override
  State<Detailsprogram> createState() => _DetailsprogramState(activity);
}

class _DetailsprogramState extends State<Detailsprogram> {
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

  _DetailsprogramState(this.activity);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScoutifyComponents()
          .appBarWithBackButton('Details Activity', context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 4),
              Container(
                height: 50,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Row(children: <Widget>[
                    Image.asset(
                      'assets/images/pengakap.png',
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'PPM NEGERI JOHOR',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '${activity.created_at.day} ${monthName[activity.created_at.month - 1]} ${activity.created_at.year}, ${DateFormat('hh:mm a').format(activity.created_at)} ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                color: Colors.transparent,
                child: Stack(children: <Widget>[
                  //event image
                  Container(
                      height:
                          MediaQuery.sizeOf(context).width * 2 / 3, //2:3 aspect
                      child: Center(
                          child: Image.network(
                        activity.imageurl,
                        fit: BoxFit.contain,
                      ))),

                  //event type details
                  Positioned(
                    top: 8,
                    right: 9,

                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Image.asset(
                        activity.category == 'CAMPING'
                            ? 'assets/icons/camping_icon.png'
                            : 'assets/icons/meeting_icon.png',
                        width: 35,
                        height: 35,
                      ),
                    ),
                    // child: Container(
                    //   width: 90,
                    //   height: 23,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(6),
                    //   ),
                    //   child: Row(children: <Widget>[
                    //     const SizedBox(width: 7),

                    //     //event type: colored-circle label
                    //     Container(
                    //       width: 10,
                    //       height: 10,
                    //       decoration: BoxDecoration(
                    //         color: const Color.fromRGBO(48, 46, 132, 100),
                    //         borderRadius: BorderRadius.circular(100),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 7),

                    //     //event type: name
                    //     Text(
                    //       activity.category,
                    //       style: const TextStyle(
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black,
                    //         letterSpacing: .3,
                    //       ),
                    //     )
                    //   ]),
                    // ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                      width: MediaQuery.sizeOf(context).width,
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
                            horizontal: 15.0, vertical: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              activity.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
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
                                  //'30 Oct - 2 Nov 2023',
                                  // if same day, just display a single date, how?

                                  // '${activity.startdate.day} ${monthAbbreviations[activity.startdate.month - 1]} - ${activity.enddate.day} ${monthAbbreviations[activity.enddate.month - 1]} ${activity.enddate.year}',
                                  dateFormatter(
                                      activity.startdate, activity.enddate),
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
                            // Row(
                            //   children: [
                            //     const Icon(Icons.paid_rounded),
                            //     const SizedBox(
                            //       width: 10,
                            //     ),
                            //     Text(
                            //       activity.fee == null
                            //           ? 'Free'
                            //           : activity.fee! != 0
                            //               ? 'RM ${(activity.fee!).toStringAsFixed(2)}'
                            //               : 'Free',
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
                            // Row(
                            //   children: [
                            //     const Icon(Icons.calendar_today_rounded),
                            //     const SizedBox(
                            //       width: 10,
                            //     ),
                            //     Builder(builder: (context) {
                            //       if (activity.registrationenddate == null) {
                            //         return const Text(
                            //           'Open',
                            //           style: TextStyle(
                            //             color: Colors.black,
                            //             fontSize: 12,
                            //             fontFamily: 'Poppins',
                            //             fontWeight: FontWeight.w400,
                            //             height: 0,
                            //           ),
                            //         );
                            //       } else if (DateTime.now()
                            //               .millisecondsSinceEpoch >
                            //           activity.registrationenddate!
                            //               .millisecondsSinceEpoch) {
                            //         return const Text(
                            //           'Closed',
                            //           style: TextStyle(
                            //             color: Colors.black,
                            //             fontSize: 12,
                            //             fontFamily: 'Poppins',
                            //             fontWeight: FontWeight.w400,
                            //             height: 0,
                            //           ),
                            //         );
                            //       } else {
                            //         return Text(
                            //           'Open until ${activity.registrationenddate!.day} ${monthName[activity.registrationenddate!.month - 1]} ${activity.registrationenddate!.year}',
                            //           style: const TextStyle(
                            //             color: Colors.black,
                            //             fontSize: 12,
                            //             fontFamily: 'Poppins',
                            //             fontWeight: FontWeight.w400,
                            //             height: 0,
                            //           ),
                            //         );
                            //       }
                            //     })
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      width: MediaQuery.sizeOf(context).width,
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFAFAFA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 2,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: activity.description ??
                                  'No description available.',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Builder(builder: (context) {
                      if (CurrentAccount.getInstance().isAdminToggled) {
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Material(
                                  child: InkWell(
                                    onTap: () async {
                                      await updateActivity();
                                    },
                                    child: Ink(
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        // ignore: prefer_const_constructors
                                        color: Color(0xFF2E3B78),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Update Activity',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Material(
                                  child: InkWell(
                                    onTap: () async {
                                      await deleteActivity();
                                    },
                                    child: Ink(
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        // ignore: prefer_const_constructors
                                        color: Color.fromARGB(255, 201, 54, 54),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Delete Activity',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteActivity() async {
    var confirmDelete = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Are you sure to delete this activity?',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
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

    if (confirmDelete == null || confirmDelete == false) return;

    await ActivityDAO().deleteActivity(activity);

    Navigator.of(context).pop();
  }

  Future<void> updateActivity() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CreateFeedPage(
              activity: activity,
            )));
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
