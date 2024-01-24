// ignore_for_file: non_constant_identifier_names

class Activity {
  late String activityid,
      name,
      category,
      imageurl,
      location,
      created_by,
      status;

  String? description;
  late DateTime created_at, startdate, enddate;
  DateTime? registrationenddate;
  double? fee;
  List<DateTime> dateInvolved = [];

  Activity(Map<String, dynamic> item) {
    activityid = item['activityid'];
    name = item['name'];
    category = item['category'];
    imageurl = item['imageurl'];
    location = item['location'];
    created_by = item['created_by'];
    description = item['description'];
    status = item['status'];
    fee = double.tryParse(item['fee'].toString());

    created_at =
        DateTime.parse(item['created_at']).add(const Duration(hours: 8));
    startdate = DateTime.parse(item['startdate']);
    enddate = DateTime.parse(item['enddate']);
    registrationenddate = item['registrationenddate'] == null
        ? null
        : DateTime.tryParse(item['registrationenddate']);

    //fill list with involved dates
    int diff = enddate.difference(startdate).inDays;
    var tempdate = startdate;
    for (var i = 0; i <= diff; i++) {
      tempdate = startdate.add(Duration(days: i));
      dateInvolved.add(tempdate);
    }
  }
}
