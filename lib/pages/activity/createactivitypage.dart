import 'dart:io';

import 'package:escout/backend/backend.dart';
import 'package:escout/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateActivityPage extends StatefulWidget {
  final Activity? activity;
  const CreateActivityPage({super.key, this.activity});

  @override
  State<CreateActivityPage> createState() => _CreateActivityPage(activity);
}

class _CreateActivityPage extends State<CreateActivityPage> {
  Activity? activity;
  bool isEditMode = false;
  _CreateActivityPage(this.activity) {
    if (activity != null) isEditMode = true;
  }

  late TextEditingController name, category, location;
  DateTime? startdate, enddate;
  @override
  void initState() {
    super.initState();

    name =
        TextEditingController(text: activity == null ? null : activity!.name);
    category = TextEditingController(
        text: activity == null
            ? null
            : toBeginningOfSentenceCase(activity!.category));
    location = TextEditingController(
        text: activity == null ? null : activity!.location);

    startdate = activity == null ? null : activity!.startdate;
    enddate = activity == null ? null : activity!.enddate;
  }

  String dropdownValue = 'Camping';
  List<String> list = <String>['Meeting', 'Camping'];

  final ImagePicker picker = ImagePicker();
  XFile? imagePicked;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
              child: SingleChildScrollView(
                child: Column(
                  //blue bow column
                  children: [
                    _appBar(context),
                    Builder(builder: (context) {
                      if (isEditMode) {
                        return GestureDetector(onTap: () async {
                          XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (image == null) return;
                          setState(() {
                            imagePicked = image;
                          });
                        }, child: Builder(builder: (context) {
                          if (imagePicked == null) {
                            return Image.network(activity!.imageurl);
                          } else {
                            return FittedBox(
                                fit: BoxFit.fill,
                                child: Image.file(File(imagePicked!.path)));
                          }
                        }));
                      }
                      return InkWell(
                        onTap: () async {
                          XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (image == null) return;
                          setState(() {
                            imagePicked = image;
                          });
                        },
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minWidth: MediaQuery.sizeOf(context).width,
                              minHeight: 180),
                          child: Ink(
                            decoration:
                                const BoxDecoration(color: Color(0xFFECECEC)),
                            child: Builder(builder: (context) {
                              if (imagePicked == null) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        child: Image.asset(
                                            'assets/images/upload.png')),
                                    const Text(
                                      'Upload an image',
                                      style: TextStyle(
                                        color: Color(0xFFD9D9D9),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image.file(File(imagePicked!.path)));
                              }
                            }),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width * 0.1),
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 318,
                            child: Text(
                              'Program Name',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          // Container(
                          //   width: MediaQuery.sizeOf(context).width * 0.8,
                          //   //height: 40,
                          //   decoration: ShapeDecoration(
                          //     color: const Color(0xFFECECEC),
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(3)),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 6),
                          //     child: Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 5.0),
                          //           child: TextField(
                          //             minLines: 1,
                          //             maxLines: 5,
                          //             controller: name,
                          //             style: const TextStyle(
                          //               color: Colors.black,
                          //               fontSize: 11,
                          //               fontFamily: 'Poppins',
                          //               fontWeight: FontWeight.w400,
                          //               height: 0,
                          //             ),
                          //             decoration: const InputDecoration(
                          //               border: InputBorder.none,
                          //               hintText: 'Program Name',
                          //               hintStyle: TextStyle(
                          //                 color: Color(0xFF9397A0),
                          //                 fontSize: 11,
                          //                 fontFamily: 'Poppins',
                          //                 fontWeight: FontWeight.w400,
                          //                 height: 0,
                          //               ),
                          //             ),
                          //           ),
                          //         )),
                          //   ),
                          // ),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 40),
                            child: Container(
                              decoration: ShapeDecoration(
                                color: const Color(0xFFECECEC),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              child: TextField(
                                controller: name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  hintText: 'Program Name',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9397A0),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                minLines: 1,
                                maxLines: 5,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            width: 318,
                            child: Text(
                              'Program Category',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          Container(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: 40,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFECECEC),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      dropdownValue = value!;
                                    });
                                  },
                                  items: list.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            width: 317,
                            child: Text(
                              'Program Location',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 40),
                            child: Container(
                              decoration: ShapeDecoration(
                                color: const Color(0xFFECECEC),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              child: TextField(
                                controller: location,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  hintText: 'Program Location',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9397A0),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                minLines: 1,
                                maxLines: 5,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            width: 317,
                            child: Text(
                              'Program Date',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: startdate ??=
                                            DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 365)));

                                    if (pickedDate == null) return;

                                    //check if end date is later or equal to start date
                                    if (enddate == null) {
                                      setState(() {
                                        startdate = pickedDate;
                                      });
                                      return;
                                    }
                                    if (pickedDate.millisecondsSinceEpoch >
                                        enddate!.millisecondsSinceEpoch) {
                                    } else {
                                      setState(() {
                                        startdate = pickedDate;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFECECEC),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                    ),
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            startdate == null
                                                ? 'Start date'
                                                : DateFormat('dd/MM/yyyy')
                                                    .format(startdate!),
                                            style: TextStyle(
                                              color: startdate == null
                                                  ? const Color(0xFF9397A0)
                                                  : Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: enddate ??= DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 365)));

                                    if (pickedDate == null) return;

                                    //check if end date is less or equal to start date
                                    if (startdate == null) {
                                      setState(() {
                                        enddate = pickedDate;
                                      });

                                      return;
                                    }
                                    if (startdate!.millisecondsSinceEpoch >
                                        pickedDate.millisecondsSinceEpoch) {
                                    } else {
                                      setState(() {
                                        enddate = pickedDate;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFECECEC),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                    ),
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            enddate == null
                                                ? 'End date'
                                                : DateFormat('dd/MM/yyyy')
                                                    .format(enddate!),
                                            style: TextStyle(
                                              color: enddate == null
                                                  ? const Color(0xFF9397A0)
                                                  : Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: InkWell(
                              onTap: () async {
                                if (name.text.isEmpty ||
                                    location.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please fill in all the fields!')));
                                  return;
                                }

                                if (imagePicked == null && !isEditMode) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please pick an image first!')));
                                  return;
                                }

                                if (startdate == null || enddate == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please choose the dates!')));
                                  return;
                                }
                                if (isEditMode) {
                                  await SupabaseB().updateEvent({
                                    'name': name.text,
                                    'category': dropdownValue,
                                    'location': location.text,
                                    'startdate': DateFormat('yyyy-MM-dd')
                                        .format(startdate!),
                                    'enddate': DateFormat('yyyy-MM-dd')
                                        .format(enddate!),
                                    'file': imagePicked == null
                                        ? null
                                        : File(imagePicked!.path)
                                  }, activity!.activityid);
                                } else {
                                  await SupabaseB().addEvent({
                                    'name': name.text,
                                    'category': dropdownValue,
                                    'location': location.text,
                                    'startdate': DateFormat('yyyy-MM-dd')
                                        .format(startdate!),
                                    'enddate': DateFormat('yyyy-MM-dd')
                                        .format(enddate!),
                                    'file': File(imagePicked!.path)
                                  });
                                }

                                Navigator.of(context).pop();
                              },
                              child: Ink(
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                height: 50,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF3B4367),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Center(
                                  child: Text(
                                    isEditMode ? 'UPDATE' : 'CREATE',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar(context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Container(
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
              'Create Activity',
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
      ),
    );
  }
}

/// RESTORED 