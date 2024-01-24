// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:escout/backend/backend.dart';
import 'package:escout/model/facility.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addFacilityPage extends StatefulWidget {
  bool isEditMode;
  Facility? facilityItem;
  addFacilityPage({super.key, this.isEditMode = false, this.facilityItem});

  @override
  State<addFacilityPage> createState() =>
      _addFacilityPageState(isEditMode, facilityItem);
}

class _addFacilityPageState extends State<addFacilityPage> {
  bool isEditMode = false;
  Facility? facilityItem;
  _addFacilityPageState(this.isEditMode, this.facilityItem);

  late TextEditingController name = TextEditingController(),
      address1 = TextEditingController(),
      address2 = TextEditingController(),
      city = TextEditingController(),
      state = TextEditingController(),
      pic = TextEditingController(),
      postcode = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (facilityItem != null) {
      name = TextEditingController(
          text: facilityItem != null ? facilityItem!.name : '');
      address1 = TextEditingController(
          text: facilityItem != null ? facilityItem!.address1 : '');
      address2 = TextEditingController(
          text: facilityItem != null ? facilityItem!.address2 : '');
      city = TextEditingController(
          text: facilityItem != null ? facilityItem!.city : '');
      state = TextEditingController(
          text: facilityItem != null ? facilityItem!.state : '');
      pic = TextEditingController(
          text: facilityItem != null ? facilityItem!.pic : '');
      postcode = TextEditingController(
          text: facilityItem != null ? facilityItem!.postcode.toString() : '');
    }
  }

  XFile? imagePicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(children: <Widget>[
              _appBar(context),
              uploadImage(),
              facilityDetails(
                name: name,
                address1: address1,
                address2: address2,
                city: city,
                postcode: postcode,
                state: state,
                pic: pic,
              ),
              //create button
              cButton(),
            ]),
          ),
        )),
      ),
    );
  }

  Widget cButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ElevatedButton(
              onPressed: () async {
                if (isEditMode) {
                  await SupabaseB().updateFacility(
                      facilityItem!.facilityID,
                      {
                        'name': name.text,
                        'address1': address1.text,
                        'address2': address2.text,
                        'city': city.text,
                        'postcode': postcode.text,
                        'state': state.text,
                        'pic': pic.text
                      },
                      newImage:
                          imagePicked == null ? null : File(imagePicked!.path));
                } else {
                  await SupabaseB().createFacility({
                    'name': name.text,
                    'address1': address1.text,
                    'address2': address2.text,
                    'city': city.text,
                    'postcode': postcode.text,
                    'state': state.text,
                    'pic': pic.text,
                    'image': File(imagePicked!.path)
                  });
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF2E3B78),
                elevation: 0,
                fixedSize: const Size(300, 50),
              ),
              child: Text(isEditMode ? 'CONFIRM' : 'CREATE',
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: .3,
                      color: Colors.white)),
            ),
          )),
    );
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
          Text(
            isEditMode ? 'Edit Facility' : 'Add Facility',
            style: const TextStyle(
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

  Widget uploadImage() {
    print(imagePicked == null);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(237, 237, 237, 100),
        child: Builder(builder: (context) {
          if (imagePicked == null) {
            if (isEditMode) {
              return GestureDetector(
                onTap: () async {
                  XFile? imagepicked = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (imagepicked != null) {
                    setState(() {
                      imagePicked = imagepicked;
                    });
                  }
                },
                child: Image.network(facilityItem!.imageURL),
              );
            }
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      XFile? imagepicked = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (imagepicked != null) {
                        setState(() {
                          imagePicked = imagepicked;
                        });
                      }
                    },
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
                ]);
          } else {
            return GestureDetector(
                onTap: () async {
                  XFile? imagepicked = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (imagepicked != null) {
                    setState(() {
                      imagePicked = imagepicked;
                    });
                  }
                },
                child: Image.file(File(imagePicked!.path)));
          }
        }),
      ),
    );
  }
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

class uploadProgramImage extends StatefulWidget {
  XFile imagePicked;
  uploadProgramImage({super.key, required this.imagePicked});

  @override
  State<uploadProgramImage> createState() =>
      _uploadProgramImageState(imagePicked);
}

class _uploadProgramImageState extends State<uploadProgramImage> {
  XFile imagePicked;

  _uploadProgramImageState(this.imagePicked);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(237, 237, 237, 100),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  XFile? imagepicked = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (imagepicked != null) imagePicked = imagepicked;
                },
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
      ),
    );
  }
}

Widget textField(Map textItems) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, left: 25, right: 25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textItems['label'],
          maxLines: 2,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: .3,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 360,
          child: TextField(
            controller: textItems['controller'],
            onChanged: textItems['onChange'],
            minLines: 1,
            maxLines: 5,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: textItems['hintText'],
              hintStyle: const TextStyle(
                  fontSize: 14.0, color: Color.fromRGBO(147, 151, 160, 100)),
              contentPadding: const EdgeInsets.only(left: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: BorderSide.none),
              fillColor: const Color.fromRGBO(237, 237, 237, 100),
              filled: true,
            ),
          ),
        ),
      ],
    ),
  );
}

class facilityDetails extends StatefulWidget {
  TextEditingController name, address1, address2, city, state, pic;
  TextEditingController postcode;

  facilityDetails({
    super.key,
    required this.name,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.state,
    required this.pic,
  });

  @override
  State<facilityDetails> createState() => _facilityDetailsState(
      name, address1, address2, city, postcode, state, pic);
}

class _facilityDetailsState extends State<facilityDetails> {
  TextEditingController name, address1, address2, city, state, pic;
  TextEditingController postcode;

  _facilityDetailsState(
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.state,
    this.pic,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //image upload

        //facility details
        //facility name
        textField({
          'controller': name,
          'onChange': (String val) {},
          'label': 'Facility Name',
          'hintText': 'Facility name',
        }),
        //facility address
        textField({
          'controller': address1,
          'onChange': (String val) {},
          'label': 'Facility Address Line 1',
          'hintText': 'Facility address line 1',
        }),
        //facility address
        textField({
          'controller': address2,
          'onChange': (String val) {},
          'label': 'Facility Address Line 2',
          'hintText': 'Facility address line 2',
        }),
        //facility address
        textField({
          'controller': city,
          'onChange': (String val) {},
          'label': 'City',
          'hintText': 'City',
        }),
        //facility address
        textField({
          'controller': postcode,
          'onChange': (String val) {},
          'label': 'Postcode',
          'hintText': 'Postcode',
        }),
        //facility address
        textField({
          'controller': state,
          'onChange': (String val) {},
          'label': 'State',
          'hintText': 'State',
        }),
        //pic of facility
        textField({
          'controller': pic,
          'onChange': (String val) {},
          'label': 'PIC of Facility',
          'hintText': 'Phone number (name)',
        }),
      ],
    );
  }
}
