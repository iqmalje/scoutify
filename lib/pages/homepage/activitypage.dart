import 'package:get/get.dart';
import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/activityDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/controller/networkcontroller.dart';
import 'package:scoutify/model/activity.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/pages/activity/createactivitypage.dart';
import 'package:scoutify/pages/activity/detailsactivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:intl/intl.dart';
import 'package:scoutify/pages/misc/lostconnection.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final NetworkController networkController = Get.put(NetworkController());
  DateTime selectedDate = DateTime.now();
  List<Activity> activities = [];

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

  List<String> images = [
    "assets/images/myImage.jpg",
    "assets/images/myimage2.jpg",
    // "assets/images/image4.png"
  ];

  List<String> titles = [
    "Johor Rovers Vigil 2023 & Serving For The Future",
    "WORLD JOTA JOTI 2023 STESEN 9M4CPJ Kelolaan JOSRAC",
    // "WORLD JOTA JOTI 2023 STESEN 9M4CPJ Kelolaan JOSRAC",
  ];

  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  Future<void> _selectDate(BuildContext context) async {
    selectedMonth = selectedDate.month;
    selectedYear = selectedDate.year;

    DateTime? dateselected = await showMonthPicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (dateselected != null) {
      setState(() {
        selectedDate = dateselected;
        this.selectedMonth = selectedDate.month;
        this.selectedYear = selectedDate.year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: ScoutifyComponents().normalAppBar('Activity', context),
          floatingActionButton: Builder(builder: (context) {
            if (CurrentAccount.getInstance().isAdminToggled) {
              // Assuming CurrentAccount.getInstance().isAdminToggled is defined in your backend logic
              return CircleAvatar(
                maxRadius: 30,
                backgroundColor: const Color(0xFF2E3B78),
                child: IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateActivityPage()));
                    setState(() {});
                  },
                ),
              );
            } else {
              return Container();
            }
          }),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: double.infinity),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          width: 140,
                          height: 30,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF2E3B78),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${monthName[selectedDate.month - 1]} ${selectedDate.year.toString().substring(2)}",
                                textScaleFactor: 1.0,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder<List<Activity>>(
                      future: CurrentAccount.getInstance().isAdminToggled
                          ? ActivityDAO().getActivities(filters: {
                              'year': selectedYear,
                              'month': selectedMonth
                            })
                          : ActivityDAO().getAttendedActivities(
                              '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-%'),
                      builder: (context, snapshot) {
                        if (!networkController.checkInternetConnectivity()) {
                          return Expanded(
                            child: LostConnection(onRefresh: () {
                              setState(() {});
                            }),
                          );
                        }

                        if (!snapshot.hasData) {
                          return const Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        activities = snapshot.data!;

                        activities.sort((a, b) {
                          final now = DateTime.now();
                          final diffA = (a.startdate.difference(now)).abs();
                          final diffB = (b.startdate.difference(now)).abs();

                          if (diffA.compareTo(diffB) == 0) {
                            // If both are the same distance from now, prioritize the next one
                            return a.startdate.compareTo(b.startdate);
                          } else {
                            // Otherwise, sort based on the closest to now
                            return diffA.compareTo(diffB);
                          }
                        });

                        return Expanded(
                          // child: Column(
                          //   children: [
                          //     buildActivity(activities.elementAt(0),
                          //         const AssetImage("assets/images/myImage.jpg")),
                          //     buildActivity(activities.elementAt(1),
                          //         const AssetImage("assets/images/myimage2.jpg")),

                          //   ],
                          // ),
                          child: Builder(builder: (context) {
                            if (activities.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/images/activity_empty_new.png",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Seeking new adventures this month!',
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 48),
                                  ],
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: activities.length,
                              itemBuilder: (context, index) {
                                return buildActivity(
                                    activities.elementAt(index));
                              },
                            );
                          }),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildActivity(Activity item) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsActivity(activity: item)));
          setState(() {});
        },
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.9,
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
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 10,
                    left: MediaQuery.of(context).size.width * 0.58,
                    right: 10),
                child: Row(
                  children: [
                    Text(
                      item.category,
                      textScaleFactor: 1.0,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        height: 15,
                        child: item.category == "MEETING"
                            ? Image.asset("assets/icons/meeting_icon.png")
                            : Image.asset("assets/icons/camping_icon.png")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: item.imageurl != null
                          ? NetworkImage(item.imageurl)
                          : AssetImage("assets/images/Scoutify_Logo_NEW.png")
                              as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        item.name,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.55),
                child: Text(
                  DateFormat('dd/MM/yyyy').format(item.startdate),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 136, 136, 136),
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date, List<String> format) {
    return DateFormat(format.join(' ')).format(date);
  }
}
