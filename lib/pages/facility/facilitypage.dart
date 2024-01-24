import 'package:escout/pages/facility/addFacility.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Padding(
            //padding for the edge of column below the blue box
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      width: 110,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 174, 169, 169)),
                      child: Row(
                        children: [
                          Text(
                            "${selectedDate.month}/${selectedDate.year}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                              width:
                                  5), // Add some space between the text and the icon
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
                const SizedBox(
                  height: 18,
                ),
                Container(
                  width: 340,
                  height: 58,
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
                  child: const Column(
                    children: [
                      Text(
                        'Johor Rovers Vigil 2023 & Serving For The Future',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Camping',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '26/10/2023',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 36,
                right: 36,
                top: MediaQuery.sizeOf(context).height * 0.53),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () =>
                    // Navigate to the second page
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addFacilityPage()),
                ),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF2C225B),
                    shape: OvalBorder(),
                  ),
                  child: const SizedBox(
                    width: 15,
                    height: 27,
                    child: Center(
                      child: Text(
                        '+',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w800,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime date, List<String> format) {
  return DateFormat(format.join(' ')).format(date);
}
