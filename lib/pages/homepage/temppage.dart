import 'package:scoutify/pages/activity/activitypage copy.dart';
import 'package:scoutify/pages/feed/listPage.dart';
import 'package:scoutify/pages/homepage/facilitypage.dart';
import 'package:scoutify/pages/homepage/profilepage.dart';
import 'package:scoutify/pages/inbox/inboxPage.dart';
import 'package:scoutify/pages/misc/chatAIpage.dart';
import 'package:flutter/material.dart';

//This tempage is responsible for hosting multiple pages that user can click through using the navbar
class TempPage extends StatefulWidget {
  const TempPage({super.key});

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  int index = 0; //chosen page

  final pageController = PageController();

  final List<Widget> _pages = [
    const listPage(),
    const ActivityPage(),
    //const FacilityPage(),
    const InboxMainPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        controller: pageController,
        children: _pages,
      ),
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
                        _changePage(0);
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
                        _changePage(1);
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
                        _changePage(2);
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Column(
                          children: [
                            Icon(
                              Icons.inbox,
                              size: 25,
                              color: index == 2
                                  ? const Color(0xFF2E3B78)
                                  : const Color(0xFFD9D9D9),
                            ),
                            Text(
                              'Inbox',
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
              //Comment out facilities, if needed for later
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Material(
              //       child: InkWell(
              //         onTap: () {
              //           _changePage(2);
              //         },
              //         borderRadius: BorderRadius.circular(100),
              //         child: SizedBox(
              //           width: 50,
              //           height: 50,
              //           child: Column(
              //             children: [
              //               Icon(
              //                 Icons.apartment,
              //                 size: 25,
              //                 color: index == 2
              //                     ? const Color(0xFF2E3B78)
              //                     : const Color(0xFFD9D9D9),
              //               ),
              //               Text(
              //                 'Facility',
              //                 style: TextStyle(
              //                   fontSize: 13,
              //                   color: index == 2
              //                       ? const Color(0xFF2E3B78)
              //                       : const Color(0xFFD9D9D9),
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    child: InkWell(
                      onTap: () {
                        _changePage(3);
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

  void _changePage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOutCirc);
  }
}
