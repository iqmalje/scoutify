import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/backend/activityDAO.dart';
import 'package:scoutify/backend/backend.dart';
import 'package:scoutify/controller/networkcontroller.dart';
import 'package:scoutify/model/activity.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/pages/feed/createFeedPage.dart';
import 'package:scoutify/pages/feed/detailsProgram.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoutify/pages/misc/lostconnection.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  List<Activity> feeds = [];
  final NetworkController networkController = Get.put(NetworkController());
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          floatingActionButton: Builder(builder: (context) {
            if (CurrentAccount.getInstance().isAdminToggled) {
              return CircleAvatar(
                maxRadius: 30,
                backgroundColor: const Color(0xFF2E3B78),
                child: IconButton(
                  color: Colors.white,
                  icon: const Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateFeedPage()));
                  },
                ),
              );
            } else {
              return Container();
            }
          }),
          body: Container(
              width: _mediaQuery.size.width,
              height: _mediaQuery.size.height,
              color: const Color.fromRGBO(237, 237, 237, 100),
              child: Column(
                children: <Widget>[
                  //appbar
                  _appBar(context),

                  //page subtitle
                  Container(
                    height: 60,
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text('Latest Update',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700)),
                    ),
                  ),

                  //feed

                  Expanded(
                      child: FutureBuilder<List<Activity>>(
                          future: ActivityDAO().getFeed(),
                          builder: (context, snapshot) {

                            if (!networkController.checkInternetConnectivity()) {
                              return LostConnection(onRefresh: () {
                                setState(() {});
                              });
                            }
                              
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            //parse data
                            feeds = snapshot.data!;

                            return ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: feeds.length,
                                itemBuilder: (context, index) {
                                  return buildAPost(context, feeds[index]);
                                });
                          })),
                ],
              )),
        ),
      ),
    );
  }
}

Widget _appBar(context) {
  return Container(
      height: 75,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xFF2E3B78),
      child: Padding(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        child: Image.asset(
          'assets/images/Scoutify_LOGO_NEW.png',
        ),
      ));
}

Widget buildAPost(BuildContext context, Activity item) {
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

  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        print('Hello World');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Detailsprogram(
                  activity: item,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Ink(
          child: Column(
            children: <Widget>[
              //feed header
              Ink(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 5, bottom: 5),
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
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '${item.created_at.day} ${monthName[item.created_at.month - 1]} ${item.created_at.year}, ${DateFormat('hh:mm a').format(item.created_at)}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),

              //feed image
              ConstrainedBox(
                constraints:
                    BoxConstraints(minWidth: MediaQuery.sizeOf(context).width),
                child: Stack(children: <Widget>[
                  //event image
                  Center(child: Image.network(item.imageurl)),

                  //event type details
                  Positioned(
                    top: 8,
                    right: 9,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Image.asset(
                        item.category == 'CAMPING'
                            ? 'assets/icons/camping_icon.png'
                            : 'assets/icons/meeting_icon.png',
                        width: 35,
                        height: 35,
                      ),
                    ),
                  ),
                ]),
              ),

              //feed caption
              ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.sizeOf(context).width, minHeight: 50),
                child: Ink(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //caption title
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                letterSpacing: .3,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Text(
                              item.description ??= 'No description available.',
                              textAlign: TextAlign.start,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            )
                            //caption subtitle
                          ]),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
