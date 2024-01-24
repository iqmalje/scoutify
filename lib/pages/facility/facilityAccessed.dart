import 'package:escout/backend/backend.dart';
import 'package:escout/model/facility.dart';
import 'package:escout/pages/facility/allFacilityAccess.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class facilityAccessed extends StatefulWidget {
  final Facility facilityItem;
  final DateTime timePicked;
  const facilityAccessed(
      {super.key, required this.facilityItem, required this.timePicked});

  @override
  State<facilityAccessed> createState() =>
      _facilityAccessedState(facilityItem, timePicked);
}

class _facilityAccessedState extends State<facilityAccessed> {
  Facility facilityItem;
  DateTime timePicked;
  _facilityAccessedState(this.facilityItem, this.timePicked);

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      color: Color(0xFF2E3B78),
      child: SafeArea(
        child: Scaffold(
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _appBar(context),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Facility',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 13),
            facilityInfo(),
            const SizedBox(height: 20),
            _accessedDate(),
            const SizedBox(height: 20),

            //Total of facility’s accessed
            FutureBuilder(
                future: SupabaseB()
                    .getTotalAccess(facilityItem.facilityID, timePicked),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return accessedInfo({
                    'info': 'Total of facility’s accessed',
                    'accessedCount': snapshot.data.toString()
                  });
                }),
            const SizedBox(height: 15),

            //Number of people accessed
            FutureBuilder(
                future: SupabaseB()
                    .getNumberAccess(facilityItem.facilityID, timePicked),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return accessedInfo({
                    'info': 'Number of people accessed',
                    'accessedCount': snapshot.data.toString()
                  });
                }),
            const SizedBox(
              height: 10,
            ),
            showAllButton(),
          ]),
        ),
      ),
    );
  }

  facilityInfo() => Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.9),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 10, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //facility name
                      Text(
                        facilityItem.name,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 13),

                      //facility address
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.navigation_rounded,
                            color: Color(0xFF2C225B),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              '${facilityItem.address1}, ${facilityItem.address2}, ${facilityItem.postcode} ${facilityItem.city}, ${facilityItem.state}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .3,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 7),

                      //facility phone
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Color(0xFF2C225B),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            facilityItem.pic,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: .3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),

                      //facility admin
                      const Row(
                        children: [
                          Icon(
                            Icons.account_circle_rounded,
                            color: Color(0xFF2C225B),
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'PPM NEGERI OR',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: .3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                    ]),
              ),
            ),
          );
        },
      );

  Widget _accessedDate() {
    return Padding(
      padding: const EdgeInsets.only(left: 45, right: 25),
      child: Row(
        children: [
          Text(
            'Date: ${DateFormat('dd MMMM yyyy (EEEE)').format(timePicked)}',
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'),
          )
        ],
      ),
    );
  }

  Widget accessedInfo(Map infoText) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Container(
        height: 43,
        width: 370,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 40, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                infoText['info'],
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .3,
                    fontFamily: 'Poppins'),
              ),
              Text(
                infoText['accessedCount'],
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showAllButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            elevation: 0,
            fixedSize: const Size(300, 45),
            side: const BorderSide(
              width: 2,
              color: Color(0xFF2C225B),
              style: BorderStyle.solid,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AllFacilityAccess(
                      facilityItem: facilityItem,
                      timePicked: timePicked,
                    )));
          },
          child: const Text(
            'Show all the people accessed',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Color(0xFF2C225B),
              fontFamily: 'Poppins',
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

Widget _appBar(context) {
  return Container(
    width: MediaQuery.sizeOf(context).width,
    height: 90,
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
          'Facility Accessed',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            //fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ],
    ),
  );
}

Widget _backButton(context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 25),
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 25,
          color: const Color.fromRGBO(59, 63, 101, 100),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    ),
  );
}
