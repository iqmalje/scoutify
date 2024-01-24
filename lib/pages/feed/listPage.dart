import 'package:escout/backend/backend.dart';
import 'package:escout/model/activity.dart';
import 'package:escout/pages/feed/createFeedPage.dart';
import 'package:escout/pages/homepage/DetailsProgram.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class listPage extends StatefulWidget {
  const listPage({super.key});

  @override
  State<listPage> createState() => _listPageState();
}

class _listPageState extends State<listPage> {
  List<Activity> feeds = [];

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          floatingActionButton: Builder(builder: (context) {
            if (SupabaseB.isAdminToggled) {
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
                          future: SupabaseB().getFeed(),
                          builder: (context, snapshot) {
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
      height: 90,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xFF2E3B78),
      child: Image.asset('assets/images/escout_logo_panjang.png'));
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
                height: 50,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
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
                    child: Container(
                      width: 90,
                      height: 23,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(children: <Widget>[
                        const SizedBox(width: 7),

                        //event type: name
                        Text(
                          item.category,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            letterSpacing: .3,
                          ),
                        ),

                        //event type: colored-circle label
                        // Container(
                        //   width: 10,
                        //   height: 10,
                        //   decoration: BoxDecoration(
                        //     color: const Color.fromRGBO(48, 46, 132, 100),
                        //     borderRadius: BorderRadius.circular(100),
                        //   ),
                        // ),
                        const SizedBox(width: 7),

                        // icon category
                        Container(
                            width: 15,
                            height: 15,
                            child:
                                Image.asset('assets/images/camping_icon.png')),
                      ]),
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
