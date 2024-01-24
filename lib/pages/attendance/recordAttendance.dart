import 'package:escout/pages/attendance/AttendanceInformation.dart';
import 'package:flutter/material.dart';

import '../../backend/backend.dart';

class RecordAttendance extends StatefulWidget {
  final String activityid;
  final String secondkey;
  final dynamic activity;
  const RecordAttendance(
      {super.key,
      required this.activityid,
      required this.secondkey,
      required this.activity});

  @override
  State<RecordAttendance> createState() =>
      _RecordAttendanceState(activityid, secondkey, activity);
}

class _RecordAttendanceState extends State<RecordAttendance> {
  TextEditingController search = TextEditingController(),
      attendance = TextEditingController();
  FocusNode fn = FocusNode();
  dynamic activity;

  String activityid = '', secondkey = '', searchFilter = '';

  _RecordAttendanceState(this.activityid, this.secondkey, this.activity);

  List<dynamic> attendees = [];

  @override
  void initState() {
    super.initState();
  }

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
              width: MediaQuery.sizeOf(context).width,
              height: 120,
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
                    'Participants',
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
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: 35,
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(255, 228, 228, 228),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: TextField(
                      controller: search,
                      onChanged: (value) {
                        setState(() {
                          searchFilter = value;
                        });
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10),
                          prefixIcon: Icon(Icons.search),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                            color: Color(0xFF9397A0),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                          hintText: "Search participant's name"),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'List of participants',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: 35,
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(255, 228, 228, 228),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: TextField(
                      focusNode: fn,
                      controller: attendance,
                      autofocus: true,
                      onSubmitted: (value) {
                        //do logic
                        SupabaseB().addAttendance(activityid, value);
                        attendance.clear();
                        fn.requestFocus();
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10),
                          prefixIcon: Icon(Icons.account_circle),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                            color: Color(0xFF9397A0),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                          hintText: "Click here to add participants"),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: 500,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF8F8F8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      height: 500,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width *
                                    0.8 *
                                    0.1,
                                child: const Text(
                                  'No',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width *
                                    0.8 *
                                    0.65,
                                child: const Text(
                                  'Name',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width *
                                    0.8 *
                                    0.25,
                                child: const Text(
                                  'Time',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.sizeOf(context).width * 0.8 - 10,
                            color: Colors.black,
                          ),
                          StreamBuilder(
                              stream: SupabaseB()
                                  .supabase
                                  .from('attendance')
                                  .stream(primaryKey: ['attendanceid']).eq(
                                      'activityid', activityid),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }

                                //separate based on date

                                attendees = snapshot.data!;
                                attendees = attendees
                                    .where((element) => element['fullname']
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchFilter))
                                    .toList();
                                attendees.removeWhere((element) =>
                                    !element['attendancekey']
                                        .toString()
                                        .contains(secondkey));
                                return Expanded(
                                  child: ListView.builder(
                                      itemCount: attendees.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return buildAttendees(context, index);
                                      }),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /*InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => attendancePage2(
                                activity: this.activity,
                                attendancekey: this.secondkey,
                              )));
                    },
                    child: Ink(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Color(0xFF3B3F65),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Center(
                        child: Text(
                          'Add participant manually',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ) */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAttendees(BuildContext context, int index) {
    DateTime time = DateTime.parse(attendees.elementAt(index)['time_attended'])
        .add(Duration(hours: 8));
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AttendanceInformation(
                  attendeeItem: attendees.elementAt(index))));
        },
        child: Ink(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8 * 0.1,
                  child: Text(
                    (index + 1).toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8 * 0.65,
                  child: Text(
                    attendees[index]['fullname'],
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8 * 0.25,
                  child: Text(
                    time.hour > 12
                        ? '${time.hour - 12}:${time.minute.toString().padLeft(2, '0')} PM'
                        : '${time.hour}:${time.minute.toString().padLeft(2, '0')} AM',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
