// ignore_for_file: must_be_immutable

import 'package:escout/backend/backend.dart';
import 'package:escout/pages/feed/createFeedPage.dart';
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
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: const BoxDecoration(color: Color(0xFF2E3B78)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 30),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  const SizedBox(width: 30),
                  const Text(
                    'Details Activity',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 4),
                  Container(
                    height: 50,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
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
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.lightBlue,
                    child: Stack(children: <Widget>[
                      //event image
                      Image.network(activity.imageurl),

                      //event type details
                      Positioned(
                        top: 8,
                        right: 9,
                        child: Container(
                          width: 90,
                          height: 23,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(children: <Widget>[
                            const SizedBox(width: 7),

                            //event type: colored-circle label
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(48, 46, 132, 100),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            const SizedBox(width: 7),

                            //event type: name
                            Text(
                              activity.category,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: .3,
                              ),
                            )
                          ]),
                        ),
                      ),
                    ]),
                  ),
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
                              Text(
                                activity.location,
                                overflow: TextOverflow.ellipsis,
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
                          Row(
                            children: [
                              const Icon(Icons.calendar_month),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                //'30 Oct - 2 Nov 2023',

                                '${activity.startdate.day} ${monthAbbreviations[activity.startdate.month - 1]} - ${activity.enddate.day} ${monthAbbreviations[activity.enddate.month - 1]} ${activity.enddate.year}',
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
                          Row(
                            children: [
                              const Icon(Icons.paid_rounded),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                activity.fee == null
                                    ? 'Free'
                                    : activity.fee! != 0
                                        ? 'RM ${(activity.fee!).toStringAsFixed(2)}'
                                        : 'Free',
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
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_rounded),
                              const SizedBox(
                                width: 10,
                              ),
                              Builder(builder: (context) {
                                if (activity.registrationenddate == null) {
                                  return const Text(
                                    'Open',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  );
                                } else if (DateTime.now()
                                        .millisecondsSinceEpoch >
                                    activity.registrationenddate!
                                        .millisecondsSinceEpoch) {
                                  return const Text(
                                    'Closed',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    'Open until ${activity.registrationenddate!.day} ${monthName[activity.registrationenddate!.month - 1]} ${activity.registrationenddate!.year}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  );
                                }
                              })
                            ],
                          )
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
                        const Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
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
                    if (SupabaseB.isAdminToggled) {
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
              'Are you sure to delete this facility?',
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

    await SupabaseB().deleteActivity(activity);

    Navigator.of(context).pop();
  }

  Future<void> updateActivity() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CreateFeedPage(
              activity: activity,
            )));
  }
}
