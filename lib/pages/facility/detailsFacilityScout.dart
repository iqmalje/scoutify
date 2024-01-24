//import 'package:facilitypage/facilityAccessed.dart';
import 'package:escout/backend/backend.dart';
import 'package:escout/model/facility.dart';
import 'package:escout/pages/facility/facilityAccessedScout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class detailsFacilityScout extends StatefulWidget {
  final Facility facilityItem;

  const detailsFacilityScout({super.key, required this.facilityItem});

  @override
  State<detailsFacilityScout> createState() =>
      _detailsFacilityScoutState(facilityItem);
}

class _detailsFacilityScoutState extends State<detailsFacilityScout> {
  final Facility facilityItem;
  DateTime timePicked = DateTime.now();
  _detailsFacilityScoutState(this.facilityItem);
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
                    return SingleChildScrollView(
                      child: Container(
                        width: _mediaQuery.size.width,
                        color: Colors.white,
                        child: Column(children: <Widget>[
                          _appBar(context),
                          facilityImage(SupabaseB()
                              .getFacilityImage(facilityItem.facilityID)),
                          const SizedBox(height: 20),
                          facilityInfo(facilityItem),
                          const SizedBox(height: 15),
                          selectDate(),
                          const SizedBox(
                            height: 20,
                          ),
                        ]),
                      ),
                    );
                  }
                })),
      ),
    );
  }

  Widget selectDate() {
    return Material(
      child: InkWell(
        onTap: () async {
          DateTime? datePicked = await showDatePicker(
              initialDate: DateTime.now(),
              context: context,
              firstDate: DateTime.fromMillisecondsSinceEpoch(0),
              lastDate: DateTime.now().add(const Duration(days: 365)));

          if (datePicked != null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return facilityAccessScout(
                facilityItem: facilityItem,
                timePicked: datePicked,
              );
            }));
          }
        },
        borderRadius: BorderRadius.circular(5),
        child: Ink(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: 50,
          decoration: ShapeDecoration(
            color: const Color(0xFF2E3B78),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select date of facility access',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Icon(
                Icons.calendar_month,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(25, 13, 25, 0),
    //   child: TextField(
    //     //controller:
    //     //onChanged:
    //     decoration: InputDecoration(
    //       hintText: 'Select date of facility access',
    //       hintStyle: const TextStyle(
    //           fontSize: 14.0, color: Color.fromRGBO(147, 151, 160, 100)),
    //       contentPadding: const EdgeInsets.only(left: 20),
    //       border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(9),
    //           borderSide: BorderSide.none),
    //       fillColor: const Color.fromRGBO(251, 251, 251, 100),
    //       filled: true,
    //       suffixIcon: Padding(
    //           padding: const EdgeInsets.only(right: 17),
    //           child: IconButton(
    //             icon: const Icon(
    //               Icons.calendar_today_rounded,
    //               color: Color.fromRGBO(147, 151, 160, 100),
    //               size: 19,
    //             ),
    //             onPressed: () async {
    //               DateTime? datePicked = await showDatePicker(
    //                   context: context,
    //                   firstDate: DateTime.fromMillisecondsSinceEpoch(0),
    //                   lastDate: DateTime.now().add(const Duration(days: 365)));

    //               if (datePicked != null) {
    //                 Navigator.of(context)
    //                     .push(MaterialPageRoute(builder: (context) {
    //                   return facilityAccessed(
    //                     facilityItem: facilityItem,
    //                     timePicked: datePicked,
    //                   );
    //                 }));
    //               }
    //             },
    //           )),
    //     ),
    //   ),
    // );
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
          'Details Facility',
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
