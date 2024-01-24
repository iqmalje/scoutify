import 'package:escout/backend/backend.dart';
import 'package:escout/model/facility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class facilityAccessScout extends StatefulWidget {
  final DateTime timePicked;
  final Facility facilityItem;
  const facilityAccessScout(
      {super.key, required this.timePicked, required this.facilityItem});

  @override
  State<facilityAccessScout> createState() =>
      _facilityAccessScoutState(facilityItem, timePicked);
}

class _facilityAccessScoutState extends State<facilityAccessScout> {
  final Facility facilityItem;
  final DateTime timePicked;

  _facilityAccessScoutState(this.facilityItem, this.timePicked);
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);

    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        child: Scaffold(
            body: FutureBuilder(
                future: SupabaseB()
                    .getAttendedDates(facilityItem.facilityID, timePicked),
                builder: (context, snapshot) {
                  print(snapshot.hasData);
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container(
                      width: _mediaQuery.size.width,
                      height: _mediaQuery.size.height,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                          _appBar(context),
                          facilityImage(facilityItem.imageURL),
                          const SizedBox(height: 20),
                          facilityInfo(facilityItem),
                          const SizedBox(height: 15),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Date: ${DateFormat('dd MMMM yyyy (EEEE)').format(timePicked)}',
                            textAlign: TextAlign.center,
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          enterExit(snapshot.data),
                        ]),
                      ),
                    );
                  }
                })),
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

facilityImage(String url) => Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(237, 237, 237, 100),
            child: Image.network(url),
          ),
        );
      },
    );

facilityInfo(Facility facilityItem) => Builder(
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
              minHeight: 100, maxWidth: MediaQuery.sizeOf(context).width * 0.9),
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
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //facility name
              Text(
                facilityItem.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 13),

              //facility address
              Row(
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
              const Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: const Color(0xFF2C225B),
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '0123456789',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      letterSpacing: .3,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '(En. Alif)',
                    style: TextStyle(
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
                    'PPM NEGERI JOHOR',
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
        );
      },
    );

Widget facilityAccessed(List<dynamic> attendances) => Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          constraints: const BoxConstraints(minHeight: 100),
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
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
            child: SizedBox(
              height: 100,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Facility Accessed',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: .3,
                          fontSize: 15),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10),
                        itemBuilder: (context, index) {
                          DateTime starttime = DateTime.parse(attendances[index]
                                      ['starttime']
                                  .toString()
                                  .replaceFirst('T', ' '))
                              .add(const Duration(hours: 8));
                          return Text(
                              '${index + 1}.   ${DateFormat('dd-MM-yyyy hh:mm a').format(starttime)}');
                        },
                        itemCount: attendances.length,
                      ),
                    )
                  ]),
            ),
          ),
        );
      },
    );

enterExit(dynamic data) => Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
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
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //enter exit header
                  const Padding(
                    padding: EdgeInsets.only(left: 100, right: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Exit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //divider
                  const Divider(
                    height: 25,
                    color: Colors.black,
                    thickness: 1.5,
                    indent: 60,
                    endIndent: 60,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime starttime =
                            DateTime.parse(data[index]['starttime'])
                                .add(const Duration(hours: 8));

                        DateTime? endtime = DateTime.tryParse(
                            data[index]['endtime'].toString());

                        print('endtime = $endtime');
                        if (endtime != null) {
                          endtime = endtime.add(const Duration(hours: 8));
                        }

                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 90, right: 90, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('hh:mm a').format(starttime),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              Builder(builder: (context) {
                                if (data[index]['endtime'] == null) {
                                  return const Text(
                                    'None',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    DateFormat('hh:mm a').format(endtime!),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  );
                                }
                              }),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  //time
                ]),
          ),
        );
      },
    );
