import 'package:escout/backend/backend.dart';
import 'package:escout/model/facility.dart';
import 'package:escout/pages/facility/addFacility.dart';
import 'package:escout/pages/facility/detailsFacilityAdmin.dart';
import 'package:escout/pages/facility/detailsFacilityScout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FacilityPage extends StatefulWidget {
  const FacilityPage({super.key});

  @override
  State<FacilityPage> createState() => _FacilityPageState();
}

class _FacilityPageState extends State<FacilityPage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    int selectedMonth = selectedDate.month;
    int selectedYear = selectedDate.year;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Month and Year'),
          contentPadding: const EdgeInsets.all(16.0), // Adjust padding for size
          content: Column(
            mainAxisSize: MainAxisSize.min, // Adjust size to content
            children: [
              Row(
                children: [
                  const Text('Month:'),
                  const SizedBox(width: 8),
                  DropdownButton<int>(
                    value: selectedMonth,
                    items: List.generate(12, (index) => index + 1).map(
                      (int month) {
                        return DropdownMenuItem<int>(
                          value: month,
                          child: Text(month.toString()),
                        );
                      },
                    ).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        selectedMonth = value!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Year:'),
                  const SizedBox(width: 8),
                  DropdownButton<int>(
                    value: selectedYear,
                    items: List.generate(100, (index) => 2022 + index)
                        .map((int year) {
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        selectedYear = value!;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedDate = DateTime(selectedYear, selectedMonth, 1);
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  List<String> images = [
    "assets/images/image3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
          bottom: false,
          child: Scaffold(
            floatingActionButton: !SupabaseB.isAdminToggled
                ? Container()
                : CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF2E3B78),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => addFacilityPage()));
                        setState(() {});
                      },
                    ),
                  ),
            body: SingleChildScrollView(
              child: Column(
                //blue bow column
                children: [
                  Container(
                    //blue box container
                    width: MediaQuery.sizeOf(context).width,
                    height: 90,
                    decoration: const BoxDecoration(color: Color(0xFF2E3B78)),
                    child: const Center(
                      child: Text(
                        'Facility',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height - 210,
                    child: FutureBuilder<List<Facility>>(
                        future: SupabaseB().getFacilities(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return Padding(
                            //padding for the edge of column below the blue box
                            padding:
                                const EdgeInsets.symmetric(horizontal: 36.0),
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return buildFacility(
                                    snapshot.data!.elementAt(index));
                              },
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildFacility(Facility item) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (SupabaseB.isAdminToggled) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return detailsFacilityAdmin(
                      facilityItem: item,
                    );
                  },
                ));
                setState(() {});
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return detailsFacilityScout(
                      facilityItem: item,
                    );
                  },
                ));
                setState(() {});
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: 58,
                  minWidth: MediaQuery.sizeOf(context).width * 0.8),
              child: Ink(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item.imageURL),
                                  /* const AssetImage("assets/images/myImage.jpg"), */ fit:
                                      BoxFit.cover)),
                        ),
                      ),
                      Text(
                        // item['name'],
                        item.name,
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
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: const Color(0xFF3B3F65),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'PPM Negeri Johor',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          const Spacer(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
