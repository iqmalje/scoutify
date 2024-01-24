import 'package:escout/backend/backend.dart';
import 'package:escout/model/facility.dart';
import 'package:escout/pages/facility/addFacility.dart';
import 'package:escout/pages/facility/facilityAccessed.dart';
import 'package:flutter/material.dart';

class detailsFacilityAdmin extends StatefulWidget {
  final Facility facilityItem;
  const detailsFacilityAdmin({super.key, required this.facilityItem});

  @override
  State<detailsFacilityAdmin> createState() =>
      _detailsFacilityAdminState(facilityItem);
}

class _detailsFacilityAdminState extends State<detailsFacilityAdmin> {
  Facility facilityItem;
  _detailsFacilityAdminState(this.facilityItem);

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);

    return Container(
      // ignore: prefer_const_constructors
      color: Color(0xFF2E3B78),
      child: SafeArea(
        child: Scaffold(
            body: Container(
          width: _mediaQuery.size.width,
          height: _mediaQuery.size.height,
          color: Colors.white,
          child: Column(children: <Widget>[
            _appBar(context),
            facilityImage(facilityItem.imageURL),
            facilityInfo(),
            selectDate(),
            const SizedBox(
              height: 50,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Material(
                child: InkWell(
                  onTap: () async {
                    var confirmDelete = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Are you sure to delete this facility?',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 18),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('No')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Yes')),
                            ],
                          );
                        });

                    if (confirmDelete == null || confirmDelete == false) return;

                    await SupabaseB().deleteFacility(facilityItem.facilityID);

                    Navigator.of(context).pop();
                  },
                  child: Ink(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 40,
                    decoration: ShapeDecoration(
                      // ignore: prefer_const_constructors
                      color: Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Delete Facility',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
        )),
      ),
    );
  }

  facilityImage(String url) => Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(237, 237, 237, 100),
              child: Image.network(
                url,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return Center(
                    child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null),
                  );
                },
              ),
            ),
          );
        },
      );

  facilityInfo() => Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, right: 25, left: 25),
            child: Container(
              constraints: BoxConstraints(minWidth: 375, maxHeight: 250),
              //decoration: BoxDecoration(color: Colors.red),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                EditButton(),
                const SizedBox(height: 10),
                Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.sizeOf(context).width * 0.8,
                  ),
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
                            maxLines: 2,
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
                                  maxLines: 5,
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
                )
              ]),
            ),
          );
        },
      );
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
              return facilityAccessed(
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

  Widget EditButton() {
    return SizedBox(
      width: 90.0,
      height: 30.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return addFacilityPage(
              isEditMode: true,
              facilityItem: facilityItem,
            );
          }));
        },
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFF2E3B78),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.edit,
              size: 12.0,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              'Edit',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                color: Colors.white,
              ),
            ),
          ],
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
          'Details Facility',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Poppins',
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
