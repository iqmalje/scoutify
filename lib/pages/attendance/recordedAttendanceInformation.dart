// ignore_for_file: camel_case_types

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class recordAttendanceInformation extends StatefulWidget {
  const recordAttendanceInformation({super.key});

  @override
  State<recordAttendanceInformation> createState() =>
      _recordAttendanceInformationState();
}

class _recordAttendanceInformationState
    extends State<recordAttendanceInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _appBar(context),
            const SizedBox(
              height: 18,
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              'JOHOR SCOUT DIGITAL ID',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w900,
                height: 0,
              ),
            ),
            Stack(
              children: [
                Image.asset('assets/images/card_profile.png'),
                Positioned.fill(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 29,
                      ),
                      Image.asset('assets/images/icon_pengakap.png'),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'PERSEKUTUAN PENGAKAP MALAYSIA NEGERI JOHOR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        'Scout Association of Malaysia Johor State',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: 140,
                        height: 140,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(
                            side:
                                BorderSide(width: 4, color: Color(0xFF00579E)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                  'BARDIN BIN UTEH',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: AutoSizeText(
                            'KETUA PESURUHJAYA PENGAKAP NEGERI JOHOR',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 34.0, top: 10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 76,
                                  height: 18,
                                  child: Text(
                                    'NO AHLI',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 76,
                                  height: 18,
                                  child: Text(
                                    ': J1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 76,
                                  height: 18,
                                  child: Text(
                                    'NO TAULIAH',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 76,
                                  height: 18,
                                  child: Text(
                                    ': PN-252',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 76,
                                  height: 18,
                                  child: Text(
                                    'UNIT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Text(
                                  ': 1983 (PM, PR)',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 76,
                                  height: 18,
                                  child: Text(
                                    'DAERAH',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Text(
                                  ': SEGAMAT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 190,
                        height: 30,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'TAULIAH PENGAKAP JOHOR',
                            style: TextStyle(
                              color: Color(0xFF3B3F65),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
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
          'Person Details',
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