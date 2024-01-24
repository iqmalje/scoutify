import 'dart:io';

import 'package:escout/backend/backend.dart';
import 'package:escout/model/activity.dart';
import 'package:escout/pages/homepage/temppage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateFeedPage extends StatefulWidget {
  final Activity? activity;
  const CreateFeedPage({super.key, this.activity});

  @override
  State<CreateFeedPage> createState() => _CreateFeedPageState(activity);
}

class _CreateFeedPageState extends State<CreateFeedPage> {
  Activity? activity;
  bool isEditMode = false;
  _CreateFeedPageState(this.activity) {
    if (activity != null) {
      isEditMode = true;
    }
  }
  ImagePicker imagePicker = ImagePicker();
  String dropdownValue = 'Meeting';
  List<String> list = ['Meeting', 'Camping'];
  XFile? imagePicked;
  bool isShowActivity = false;

  late TextEditingController name, category, location, fee, description;
  DateTime? startdate, enddate, registerenddate;

  @override
  void initState() {
    super.initState();

    if (activity == null) {
      name = TextEditingController();
      category = TextEditingController();
      location = TextEditingController();
      fee = TextEditingController();
      description = TextEditingController();
    } else {
      name = TextEditingController(text: activity!.name);
      category = TextEditingController(
          text: toBeginningOfSentenceCase(activity!.category));
      location = TextEditingController(text: activity!.location);
      fee = TextEditingController(
          text: activity!.fee == null ? '0' : activity!.fee!.toString());
      description = TextEditingController(text: activity!.description);
      startdate = activity!.startdate;
      enddate = activity!.enddate;
      registerenddate = activity!.registrationenddate;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);

    return Scaffold(
        body: Container(
      width: _mediaQuery.size.width,
      height: _mediaQuery.size.height,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _appBar(context),

              SizedBox(
                height: 10,
                child: Container(
                  color: const Color.fromRGBO(237, 237, 237, 100),
                ),
              ),
              postAuthor(context),
              buildUploadImage(context),

              //program name
              textField({
                'controller': name,
                'onChange': (String val) {},
                'label': 'Program Name',
                'hintText': 'Program name',
                'icon': null
              }),
              //program category
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Program Category',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: .3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 35,
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Color.fromARGB(255, 246, 246, 246),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //program location
              textField({
                'controller': location,
                'onChange': (String val) {},
                'label': 'Program Location',
                'hintText': 'Program location',
                'icon': null
              }),

              //program date
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text(
                  'Program Date',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .3,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //start date
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: startdate ??= DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)));

                        if (pickedDate == null) return;
                        if (enddate == null) {
                          setState(() {
                            startdate = pickedDate;
                          });
                          return;
                        }
                        if (pickedDate.millisecondsSinceEpoch >
                            enddate!.millisecondsSinceEpoch) {
                          return;
                        } else {
                          setState(() {
                            startdate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        width: 160,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 246, 246, 246),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                startdate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(startdate!)
                                    : 'Start date',
                                style: TextStyle(
                                  color: startdate == null
                                      ? const Color(0xFF9397A0)
                                      : Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              const Icon(Icons.calendar_today)
                            ],
                          ),
                        ),
                      ),
                    ),
                    //end date
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: enddate ??= DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)));

                        if (pickedDate == null) return;
                        if (startdate == null) {
                          setState(() {
                            enddate = pickedDate;
                          });

                          return;
                        }
                        if (startdate!.millisecondsSinceEpoch >
                            pickedDate.millisecondsSinceEpoch) {
                          return;
                        } else {
                          setState(() {
                            enddate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        width: 160,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: const Color.fromRGBO(237, 237, 237, 100),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                enddate == null
                                    ? 'End date'
                                    : DateFormat('dd/MM/yyyy').format(enddate!),
                                style: TextStyle(
                                  color: enddate == null
                                      ? Color(0xFF9397A0)
                                      : Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              const Icon(Icons.calendar_today)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //program fee
              textField({
                'controller': fee,
                'onChange': (String val) {},
                'label': 'Program Fee',
                'hintText': 'Program fee (RM)',
                'icon': null,
                'keyboardType': TextInputType.number
              }),
              //program end date registration
              const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 10),
                child: Text(
                  'Program End Date Registration',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: .3,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: registerenddate ??= DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365)));

                    if (pickedDate == null) return;
                    setState(() {
                      registerenddate = pickedDate;
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: ShapeDecoration(
                      color: const Color.fromRGBO(237, 237, 237, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            registerenddate == null
                                ? 'Registration end date'
                                : DateFormat('dd/MM/yyyy')
                                    .format(registerenddate!),
                            style: TextStyle(
                              color: registerenddate == null
                                  ? Color(0xFF9397A0)
                                  : Colors.black,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          const Icon(Icons.calendar_today)
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //program description
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text(
                  'Program Description',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: .3,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: TextField(
                  controller: description,
                  //onChanged: (){}
                  minLines: 1,
                  maxLines: 15,
                  decoration: InputDecoration(
                    hintText: 'Program description',
                    hintStyle: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(147, 151, 160, 100)),
                    contentPadding: const EdgeInsets.only(left: 10, right: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: BorderSide.none),
                    fillColor: const Color.fromRGBO(237, 237, 237, 100),
                    filled: true,
                  ),
                ),
              ),

              //toggle button
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add the program in the activity list',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    //toggle button
                    switchButton(),
                  ],
                ),
              ),

              //post button
              postButton(),
            ]),
      ),
    ));
  }

  Widget _appBar(context) {
    return Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 40, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.clear),
                color: const Color.fromRGBO(46, 48, 132, 100),
                iconSize: 25,
              ),
            ],
          ),
        ));
  }

  Widget postAuthor(context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/pengakap.png',
              width: 36,
              height: 36,
            ),
            const SizedBox(width: 12),
            const Text(
              'PPM NEGERI JOHOR',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildUploadImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () async {
          imagePicked =
              await imagePicker.pickImage(source: ImageSource.gallery);

          setState(() {});
        },
        child: Builder(builder: (context) {
          if (imagePicked == null && !isEditMode) {
            return Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(237, 237, 237, 100),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.upload_file),
                      color: const Color.fromRGBO(217, 217, 217, 100),
                      iconSize: 35,
                    ),
                    const Text(
                      'Upload an image',
                      style: TextStyle(
                          color: Color.fromRGBO(217, 217, 217, 100),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          letterSpacing: .3),
                    ),
                  ]),
            );
          } else if (imagePicked == null && isEditMode) {
            return Image.network(activity!.imageurl);
          } else {
            return Image.file(File(imagePicked!.path));
          }
        }),
      ),
    );
  }

  Widget textField(Map textItems) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textItems['label'],
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: .3,
            ),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: BoxConstraints(
                //minHeight: 20,
                ),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              //height: 45,
              decoration: ShapeDecoration(
                color: Color.fromARGB(255, 246, 246, 246),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  minLines: 1,
                  maxLines: 10,
                  controller: textItems['controller'],
                  onChanged: textItems['onChange'],
                  keyboardType: textItems['keyboardType'],
                  decoration: InputDecoration(
                    hintText: textItems['hintText'],
                    hintStyle: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(147, 151, 160, 100)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Switch switchButton() {
    return Switch(
      activeColor: const Color.fromARGB(255, 255, 255, 255),
      activeTrackColor: const Color(0xFF2E3B78),
      value: isShowActivity,
      onChanged: (newSwitch) {
        setState(() {
          isShowActivity = newSwitch;
        });
      },
    );
  }

  Widget postButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 45),
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (isEditMode) {
              await updateFeed();
            } else {
              await createFeed();
            }
          },
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF2E3B78),
            elevation: 0,
            fixedSize: Size(MediaQuery.sizeOf(context).width * 0.9, 50),
          ),
          child: Text(isEditMode ? 'UPDATE FEED' : 'POST FEED',
              style: const TextStyle(
                  fontSize: 14,
                  letterSpacing: .3,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
      ),
    );
  }

  Future<void> createFeed() async {
    if (name.text.isEmpty ||
        location.text.isEmpty ||
        description.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all the fields!')));
      return;
    }

    if (startdate == null || enddate == null || registerenddate == null) {
      return;
    }

    if (imagePicked == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please pick an image')));
    }

    await SupabaseB().createFeed({
      'name': name.text,
      'category': dropdownValue,
      'location': location.text,
      'startdate': '${startdate!.year}-${startdate!.month}-${startdate!.day}',
      'enddate': '${enddate!.year}-${enddate!.month}-${enddate!.day}',
      'is_show_activity': isShowActivity,
      'fee': fee.text.isEmpty ? '0' : fee.text,
      'registrationenddate':
          '${registerenddate!.year}-${registerenddate!.month}-${registerenddate!.day}',
      'description': description.text,
      'file': File(imagePicked!.path)
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const TempPage()),
        (route) => false);
  }

  Future<void> updateFeed() async {
    await SupabaseB().updateFeed({
      'name': name.text,
      'category': dropdownValue,
      'location': location.text,
      'startdate': '${startdate!.year}-${startdate!.month}-${startdate!.day}',
      'enddate': '${enddate!.year}-${enddate!.month}-${enddate!.day}',
      'is_show_activity': isShowActivity,
      'fee': fee.text.isEmpty ? '0' : fee.text,
      'registrationenddate':
          '${registerenddate!.year}-${registerenddate!.month}-${registerenddate!.day}',
      'description': description.text,
      'file': imagePicked == null ? null : File(imagePicked!.path)
    }, activity!.activityid);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const TempPage()),
        (route) => false);
  }
}
