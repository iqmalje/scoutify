import 'package:escout/pages/activity/activitypage copy.dart';
import 'package:escout/pages/feed/listPage.dart';
import 'package:escout/pages/homepage/facilitypage.dart';
import 'package:escout/pages/homepage/profilepage.dart';
import 'package:escout/pages/misc/chatAIpage.dart';
import 'package:flutter/material.dart';

//This tempage is responsible for hosting multiple pages that user can click through using the navbar
class TempPage extends StatefulWidget {
  const TempPage({super.key});

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  int index = 0; //chosen page

  final List<Widget> _pages = [
    const listPage(),
    const ActivityPage(),
    const FacilityPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: CircleAvatar(
            backgroundColor: const Color(0xFF2E3B78),
            radius: 20,
            child: IconButton(
              icon: const Icon(Icons.chat),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChatAIPage()));
              },
              color: Colors.white,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Color(0x28000000),
            blurRadius: 16,
            offset: Offset(0, -3),
            spreadRadius: 0,
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Column(
                          children: [
                            Icon(
                              Icons.home,
                              size: 25,
                              color: index == 0
                                  ? const Color(0xFF2E3B78)
                                  : const Color(0xFFD9D9D9),
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                fontSize: 13,
                                color: index == 0
                                    ? const Color(0xFF2E3B78)
                                    : const Color(0xFFD9D9D9),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        setState(() {
                          index = 1;
                        });
                      },
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Column(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 25,
                              color: index == 1
                                  ? const Color(0xFF2E3B78)
                                  : const Color(0xFFD9D9D9),
                            ),
                            Text(
                              'Activity',
                              style: TextStyle(
                                fontSize: 13,
                                color: index == 1
                                    ? const Color(0xFF2E3B78)
                                    : const Color(0xFFD9D9D9),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          index = 2;
                        });
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Column(
                          children: [
                            Icon(
                              Icons.apartment,
                              size: 25,
                              color: index == 2
                                  ? const Color(0xFF2E3B78)
                                  : const Color(0xFFD9D9D9),
                            ),
                            Text(
                              'Facility',
                              style: TextStyle(
                                fontSize: 13,
                                color: index == 2
                                    ? const Color(0xFF2E3B78)
                                    : const Color(0xFFD9D9D9),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          index = 3;
                        });
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Column(
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 25,
                              color: index == 3
                                  ? const Color(0xFF2E3B78)
                                  : const Color(0xFFD9D9D9),
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 13,
                                color: index == 3
                                    ? const Color(0xFF2E3B78)
                                    : const Color(0xFFD9D9D9),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
