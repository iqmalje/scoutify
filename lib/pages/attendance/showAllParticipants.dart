import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/attendanceDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class showAllParticipants extends StatefulWidget {
  final Activity activity;
  final DateTime timePicked;
  const showAllParticipants(
      {super.key, required this.activity, required this.timePicked});

  @override
  State<showAllParticipants> createState() =>
      _showAllParticipantsState(activity, timePicked);
}

class _showAllParticipantsState extends State<showAllParticipants> {
  Activity activity;
  DateTime timePicked;
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
  _showAllParticipantsState(this.activity, this.timePicked);
  bool isDoneLoading = false;
  int totalAttendees = 0;
  List<dynamic> searchFilter = [];
  List<dynamic> totalAttendeesList = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    AttendanceDAO().getAllAttendees(activity.activityid, timePicked).then(
        (value) => WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                isLoaded = true;
                totalAttendeesList = value;
                searchFilter = totalAttendeesList;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        child: Scaffold(
          appBar: ScoutifyComponents().appBarWithBackButton('Attendances', context),
          body: Center(
              child: Column(
            children: [
              const SizedBox(height: 35),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  // Adjust the multiplier (0.1 in this case) based on your percentage preference
                  child: const Text(
                    'Activity Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: .3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.85,
                    minHeight: 120),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        activity.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                            DateFormat('dd MMMM yyyy').format(timePicked),
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
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.85,
                height: 44,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Total Number of Participants',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          const Spacer(), // Add this to push the next text to the right
                          Builder(builder: (context) {
                            if (!isLoaded) {
                              return const SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ));
                            }
                            return Text(
                              totalAttendeesList.length.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 23),
              const Text(
                'List of participants',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: .3,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: 35,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFAFAFA),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchFilter = totalAttendeesList.where((element) {
                        return element['fullname']
                            .toString()
                            .toLowerCase()
                            .contains(value);
                      }).toList();
        
                      print("JUMPA ${searchFilter.length}");
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
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
              const SizedBox(height: 13),
              Expanded(
                child: Builder(builder: (context) {
                  if (!isLoaded) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
        
                  return Builder(builder: (context) {
                    if (totalAttendeesList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Text('No attendees yet'),
                      );
                    }
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchFilter.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildParticipant(
                              context, searchFilter.elementAt(index));
                        },
                      ),
                    );
                  });
                }),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget buildParticipant(BuildContext context, dynamic item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
          width: MediaQuery.sizeOf(context).width * 0.85,
          height: 60,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 237, 237, 237),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              //container for profile pic
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(item['image_url']),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item['fullname'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(item['pos'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}