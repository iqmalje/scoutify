// this page is abandoned as new project did not require this page



// import 'package:scoutify/model/facility.dart';
// import 'package:scoutify/pages/facility/FacilityAccessedInformation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../backend/backend.dart';

// class AllFacilityAccess extends StatefulWidget {
//   final Facility facilityItem;
//   final DateTime timePicked;
//   const AllFacilityAccess(
//       {super.key, required this.facilityItem, required this.timePicked});

//   @override
//   State<AllFacilityAccess> createState() =>
//       _AllFacilityAccessState(facilityItem, timePicked);
// }

// class _AllFacilityAccessState extends State<AllFacilityAccess> {
//   Facility facilityItem;
//   DateTime timePicked;
//   String searchFilter = '';
//   bool isLoaded = true;
//   List<dynamic> peopleAccessedList = [];
//   List<dynamic> searchFiltered = [];
//   _AllFacilityAccessState(this.facilityItem, this.timePicked);

//   @override
//   void initState() {
//     super.initState();

//     // SupabaseB().getAllAccess(facilityItem.facilityID, timePicked).then(
//     //     (value) => WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     //           setState(() {
//     //             isLoaded = true;

//     //             peopleAccessedList = value;
//     //             searchFiltered = peopleAccessedList;
//     //           });
//     //         }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF2E3B78),
//       child: SafeArea(
//         bottom: false,
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(100),
//             child: Container(
//               width: MediaQuery.sizeOf(context).width,
//               height: 120,
//               decoration: const BoxDecoration(color: Color(0xFF2E3B78)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     width: 30,
//                   ),
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: const ShapeDecoration(
//                       color: Colors.white,
//                       shape: OvalBorder(),
//                     ),
//                     child: IconButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         icon: const Icon(Icons.arrow_back_ios_new)),
//                   ),
//                   const SizedBox(
//                     width: 30,
//                   ),
//                   const Text(
//                     'People Accessed',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 25,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w600,
//                       height: 0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           body: SingleChildScrollView(
//             child: Center(
//               child: Builder(builder: (context) {
//                 if (!isLoaded) {
//                   return const CircularProgressIndicator();
//                 }
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       width: MediaQuery.sizeOf(context).width * 0.8,
//                       height: 35,
//                       decoration: ShapeDecoration(
//                         color: const Color.fromARGB(255, 228, 228, 228),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5)),
//                       ),
//                       child: TextField(
//                         onChanged: (value) {
//                           setState(() {
//                             searchFilter = value;
//                             searchFiltered = peopleAccessedList
//                                 .where((element) => element['fullname']
//                                     .toString()
//                                     .toLowerCase()
//                                     .contains(searchFilter))
//                                 .toList();
//                           });
//                         },
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(bottom: 10),
//                             prefixIcon: Icon(Icons.search),
//                             border:
//                                 OutlineInputBorder(borderSide: BorderSide.none),
//                             hintStyle: TextStyle(
//                               color: Color(0xFF9397A0),
//                               fontSize: 13,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400,
//                               height: 0,
//                             ),
//                             hintText: "Search participant's name"),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 25,
//                     ),
//                     const Text(
//                       'List of people accessed',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w600,
//                         height: 0,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Container(
//                       width: MediaQuery.sizeOf(context).width * 0.8,
//                       height: 500,
//                       decoration: ShapeDecoration(
//                         color: const Color(0xFFF8F8F8),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                       child: SizedBox(
//                         width: MediaQuery.sizeOf(context).width * 0.8,
//                         height: 500,
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 SizedBox(
//                                   width: MediaQuery.sizeOf(context).width *
//                                       0.8 *
//                                       0.1,
//                                   child: const Text(
//                                     'No',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: MediaQuery.sizeOf(context).width *
//                                       0.8 *
//                                       0.65,
//                                   child: const Text(
//                                     'Name',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: MediaQuery.sizeOf(context).width *
//                                       0.8 *
//                                       0.25,
//                                   child: const Text(
//                                     'Time',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               height: 1,
//                               width:
//                                   MediaQuery.sizeOf(context).width * 0.8 - 10,
//                               color: Colors.black,
//                             ),
//                             Expanded(
//                               child: StreamBuilder<List<dynamic>>(
//                                   stream: SupabaseB()
//                                       .supabase
//                                       .from('facilityaccess')
//                                       .stream(primaryKey: ['accessid'])
//                                       .eq('facilityid', facilityItem.facilityID)
//                                       .order('starttime', ascending: true),
//                                   builder: (context, snapshot) {
//                                     if (!snapshot.hasData) {
//                                       return const Center(
//                                         child: CircularProgressIndicator(),
//                                       );
//                                     }
//                                     peopleAccessedList = snapshot.data!;
//                                     peopleAccessedList.removeWhere((element) =>
//                                         !element['starttime']
//                                             .toString()
//                                             .contains(DateFormat('yyyy-MM-dd')
//                                                 .format(timePicked)));

//                                     return ListView.builder(
//                                         itemCount: peopleAccessedList.length,
//                                         shrinkWrap: true,
//                                         itemBuilder: (context, index) {
//                                           return buildAttendees(context, index,
//                                               peopleAccessedList[index]);
//                                         });
//                                   }),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     /*InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => attendancePage2(
//                                     activity: this.activity,
//                                     attendancekey: this.secondkey,
//                                   )));
//                         },
//                         child: Ink(
//                           width: MediaQuery.sizeOf(context).width * 0.8,
//                           height: 40,
//                           decoration: ShapeDecoration(
//                             color: Color(0xFF3B3F65),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5)),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               'Add participant manually',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w600,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ) */
//                   ],
//                 );
//               }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildAttendees(BuildContext context, int index, dynamic item) {
//     DateTime time = DateTime.parse(item['starttime']).add(Duration(hours: 8));

//     return FutureBuilder(
//         future: getFullname(item['accessed_by']),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Text('');
//           }

//           item['fullname'] = snapshot.data!;
//           return Material(
//             child: InkWell(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => FacilityAccessedInformation(
//                           attendeeItem: item,
//                           facilityID: facilityItem.facilityID,
//                           timePicked: timePicked,
//                         )));
//               },
//               child: Ink(
//                 child: SizedBox(
//                   height: 30,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.sizeOf(context).width * 0.8 * 0.1,
//                         child: Text(
//                           (index + 1).toString(),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.sizeOf(context).width * 0.8 * 0.65,
//                         child: Text(
//                           snapshot.data!,
//                           textAlign: TextAlign.start,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.sizeOf(context).width * 0.8 * 0.25,
//                         child: Text(
//                           time.hour > 12
//                               ? '${time.hour - 12}:${time.minute.toString().padLeft(2, '0')} PM'
//                               : '${time.hour}:${time.minute.toString().padLeft(2, '0')} AM',
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   Future<String> getFullname(String uuid) async {
//     var data = await SupabaseB()
//         .supabase
//         .from('accounts')
//         .select('fullname')
//         .eq('accountid', uuid)
//         .single();

//     return data['fullname'];
//   }
// }
