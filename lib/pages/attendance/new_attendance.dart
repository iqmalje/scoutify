import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/attendanceDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/account.dart';
import 'package:scoutify/model/activity.dart';

class NewAttendanceRecordPage extends StatefulWidget {
  final String activityid;
  final String secondkey;
  final Activity activity;
  final DateTime dateSelected;
  NewAttendanceRecordPage(
      {super.key,
      required this.activityid,
      required this.secondkey,
      required this.activity,
      required this.dateSelected});

  @override
  State<NewAttendanceRecordPage> createState() => _NewAttendanceRecordPageState(
      activityid, secondkey, activity, dateSelected);
}

class _NewAttendanceRecordPageState extends State<NewAttendanceRecordPage> {
  TextEditingController search = TextEditingController(),
      attendance = TextEditingController();
  FocusNode fn = FocusNode();
  Activity activity;
  DateTime dateSelected;

  String activityid = '', secondkey = '', searchFilter = '';
  List<dynamic> attendees = [];
  _NewAttendanceRecordPageState(
      this.activityid, this.secondkey, this.activity, this.dateSelected);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScoutifyComponents().appBarWithBackButton('Attendances', context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/Scoutify_LOGO_NEW.png',
                width: 300,
              ),
              const SizedBox(
                height: 30,
              ),
              buildActivityInfo(context),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: AccountDAO()
                      .supabase
                      .from('attendance')
                      .stream(primaryKey: ['attendanceid'])
                      .eq('activityid', activityid)
                      .order('time_attended', ascending: false),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    attendees = snapshot.data!;
                    attendees = attendees
                        .where((element) => element['fullname']
                            .toString()
                            .toLowerCase()
                            .contains(searchFilter))
                        .toList();

                    return Builder(builder: (context) {
                      if (MediaQuery.sizeOf(context).width < 500) {
                        // screen size small, replace with column
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width - 100,
                              decoration: getContainerDecoration(),
                              child: Column(
                                children: [
                                  Text(
                                    'PARTICIPANT\'S ID',
                                    style: getTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  FutureBuilder<Account>(
                                      future: AccountDAO().getOtherProfile(
                                          attendees.first['accountid']),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const CircularProgressIndicator();
                                        }

                                        if (attendees.first['accountid'] ==
                                            '2f8ac5d8-d306-4690-8bd0-c075806f4b3a') {
                                          return Container(
                                              width: 250,
                                              child: FittedBox(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: ScoutifyComponents()
                                                    .buildSpecialCard(
                                                        snapshot.data!),
                                              )));
                                        }
                                        return Container(
                                            width: 250,
                                            child: FittedBox(
                                                child: ScoutifyComponents()
                                                    .buildCard(
                                                        snapshot.data!)));
                                      })
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildAttendance(context, expand: true),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      } else {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildAttendance(context),
                            const SizedBox(
                              width: 40,
                            ),
                            Expanded(
                              child: Container(
                                height: 455,
                                width: 250,
                                decoration: getContainerDecoration(),
                                child: Column(
                                  children: [
                                    //sini
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'PARTICIPANT\'S ID',
                                      style: getTextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Builder(builder: (context) {
                                      if (attendees.isNotEmpty) {
                                        return FutureBuilder<Account>(
                                            future: AccountDAO()
                                                .getOtherProfile(attendees
                                                    .first['accountid']),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const CircularProgressIndicator();
                                              }
                                              if (attendees
                                                      .first['accountid'] ==
                                                  '2f8ac5d8-d306-4690-8bd0-c075806f4b3a') {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0),
                                                  child: Container(
                                                      width: 250,
                                                      child: FittedBox(
                                                          child: ScoutifyComponents()
                                                              .buildSpecialCard(
                                                                  snapshot
                                                                      .data!))),
                                                );
                                              }
                                              return Container(
                                                  width: 250,
                                                  child: FittedBox(
                                                      child:
                                                          ScoutifyComponents()
                                                              .buildCard(
                                                                  snapshot
                                                                      .data!)));
                                              return Container();
                                            });
                                      } else {
                                        return Container();
                                      }
                                    })
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }

  Container buildAttendance(BuildContext context, {bool expand = false}) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: expand
            ? MediaQuery.sizeOf(context).width - 100
            : MediaQuery.sizeOf(context).width * 0.5,
      ),
      height: 455,
      decoration: getContainerDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'LIST PARTICIPANTS ATTENDED',
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.25)),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: attendance,
                focusNode: fn,
                onSubmitted: (value) {
                  print(value);

                  if (value[0] != 'J' && value[0] != 'K') {
                    print(isDecimal(value));
                    if (isDecimal(value)) {
                      String converted = decimalToHex(int.parse(value));
                      print(converted);
                      AttendanceDAO().addAttendance(activityid, converted);
                    } else {
                      AttendanceDAO().addAttendance(activityid, value);
                    }
// convert first
                  } else {
                    AttendanceDAO().addAttendance(activityid, value);
                  }

                  attendance.clear();
                  fn.requestFocus();
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: getTextStyle(color: const Color(0xFF9397A0)),
                    hintText: 'Enter participant ID',
                    prefixIcon: const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              decoration: getContainerDecoration(borderRadius: 15),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Name',
                          style: getTextStyle(
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Spacer(),
                        Text('Time',
                            style: getTextStyle(
                                color: Colors.black.withOpacity(0.5))),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 1,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    Flexible(
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            itemCount: attendees.length,
                            itemBuilder: (context, index) {
                              String name = attendees[index]['fullname'];

                              String timeImproved = attendees[index]
                                      ['time_attended']
                                  .toString()
                                  .replaceFirst('T', ' ');
                              DateTime time = DateTime.parse(timeImproved);
                              time = time.add(const Duration(hours: 8));

                              return Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Text(DateFormat('hh:mm a').format(time))
                                  ],
                                ),
                              );
                            }))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildActivityInfo(BuildContext context) {
    List<String> months = [
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
      'December'
    ];
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: getContainerDecoration(),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.feed),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    activity.name,
                    style:
                        getTextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(Icons.schedule),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    //'17 February 2024',
                    '${dateSelected.day} ${months[dateSelected.month - 1]} ${dateSelected.year}',
                    style:
                        getTextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    //'Hotel Katerina, Batu Pahat, Johor',
                    activity.location,
                    style:
                        getTextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(Icons.account_circle),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    'PPM Negeri Johor',
                    style:
                        getTextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  TextStyle getTextStyle(
      {FontWeight? fontWeight, double? fontSize, Color? color}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color ??= Colors.black);
  }

  BoxDecoration getContainerDecoration({double? borderRadius}) {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ??= 10),
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 2))
        ]);
  }

  Widget buildCard(Account account) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Image.asset('assets/images/card_profile.png'),
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(
                  height: 29,
                ),
                Image.asset('assets/images/icon_pengakap.png'),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'PERSEKUTUAN PENGAKAP MALAYSIA NEGERI JOHOR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  'Scout Association of Malaysia Johor State',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  'Diperbadankan dibawah Akta Parlimen No.784 Tahun 1968 (Semakan 2016), Enacted under Parliament Act No.784 (Revised 2016)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 3,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Arial',
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
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(
                      side: BorderSide(width: 4, color: Color(0xFF00579E)),
                    ),
                  ),
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${account.imageURL}?v=${DateTime.now().millisecondsSinceEpoch}')),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: AutoSizeText(
                            account.scoutInfo.cardName ??= '-',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w700,
                              height: 0,
                              letterSpacing: -1.50,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Builder(builder: (context) {
                            if (account.isMember) {
                              return const Icon(
                                Icons.verified,
                                size: 18,
                                color: Colors.white,
                              );
                            } else {
                              return Container();
                            }
                          }),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: AutoSizeText(
                      account.scoutInfo.position,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0, top: 20),
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
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 76,
                            height: 18,
                            child: Text(
                              ': ${account.scoutInfo.noAhli}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Arial',
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
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 76,
                            height: 18,
                            child: Text(
                              ': ${account.scoutInfo.noTauliah}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Arial',
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
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          Text(
                            ': ${account.scoutInfo.unit}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Arial',
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
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          Text(
                            ': ${account.scoutInfo.daerah}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Arial',
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
                  height: 12,
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
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String decimalToHex(int decimal) {
    String reversedRAW = decimal.toRadixString(16).toLowerCase();
    // takes every two characters from the end and put it infront
    return convertFormat(reversedRAW);
  }

  String convertFormat(String input) {
    if (input.length % 2 != 0) {
      throw ArgumentError("Input string length must be even.");
    }

    StringBuffer output = StringBuffer();

    // Iterate over the string in reverse, taking two characters at a time
    for (int i = input.length - 2; i >= 0; i -= 2) {
      output.write(input.substring(i, i + 2));
    }

    return output.toString();
  }

  bool isDecimal(String input) {
    final regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(input);
  }
}
