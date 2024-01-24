import 'package:auto_size_text/auto_size_text.dart';
import 'package:escout/backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceInformation extends StatefulWidget {
  final dynamic attendeeItem;
  const AttendanceInformation({super.key, required this.attendeeItem});

  @override
  State<AttendanceInformation> createState() =>
      _AttendanceInformationState(attendeeItem);
}

class _AttendanceInformationState extends State<AttendanceInformation> {
  final dynamic attendeeItem;
  _AttendanceInformationState(this.attendeeItem);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  _appBar(context),
                  const SizedBox(
                    height: 18,
                  ),
                  FutureBuilder(
                      future: SupabaseB()
                          .getScoutDetails(attendeeItem['accountid']),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Stack(
                          children: [
                            Image.asset('assets/images/card_profile.png'),
                            Positioned.fill(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 29,
                                  ),
                                  Image.asset(
                                      'assets/images/icon_pengakap.png'),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                    'PERSEKUTUAN PENGAKAP MALAYSIA NEGERI JOHOR',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    'Scout Association of Malaysia Johor State',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  Container(
                                    width: 140,
                                    height: 140,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data['image_url'])),
                                      color: Colors.white,
                                      shape: const OvalBorder(
                                        side: BorderSide(
                                            width: 4, color: Color(0xFF00579E)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: SizedBox(
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: AutoSizeText(
                                              attendeeItem['fullname'],
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      child: AutoSizeText(
                                        snapshot.data['position'],
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 34.0, top: 10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 76,
                                              height: 18,
                                              child: Text(
                                                'NO AHLI',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 76,
                                              height: 18,
                                              child: Text(
                                                ': ${snapshot.data['no_ahli']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 76,
                                              height: 18,
                                              child: Text(
                                                'NO TAULIAH',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 76,
                                              height: 18,
                                              child: Text(
                                                ': ${snapshot.data['no_tauliah']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 76,
                                              height: 18,
                                              child: Text(
                                                'UNIT',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ': ${snapshot.data['unit']}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 76,
                                              height: 18,
                                              child: Text(
                                                'DAERAH',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ': ${snapshot.data['daerah']}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    width: 190,
                                    height: 30,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'TAULIAH PENGAKAP JOHOR',
                                        style: TextStyle(
                                          color: Color(0xFF3B3F65),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 530,
                            ),
                          ],
                        );
                      }),
                  const Text(
                    'Attendance Record',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: SupabaseB()
                          .getAttendance(this.attendeeItem['activityid']),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return successfulAttended(snapshot.data!);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget successfulAttended(List<dynamic> attendance) {
    List<DateTime> timeAttended = [];
    for (var thing in attendance) {
      timeAttended.add(
          DateTime.parse(thing['time_attended']).add(const Duration(hours: 8)));
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Scout successfully attended this event. ',
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
                      maxWidth: MediaQuery.sizeOf(context).width * 0.85,
                      maxHeight: 180),
                  child: ListView(
                    padding: EdgeInsets.zero,
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
  }
}

Widget _appBar(context) {
  return Container(
    width: MediaQuery.sizeOf(context).width,
    height: 90,
    decoration: const BoxDecoration(color: Color(0xFF2E3B78)),
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
          'Person Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            //fontFamily: 'Poppins',
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
