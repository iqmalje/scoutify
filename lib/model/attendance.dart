class Attendance {
  late String attendanceID, activityid, accountid;
  late DateTime timeAttended, dateAttended;

  Attendance.parse(Map<String, dynamic> items) {
    attendanceID = items['attendanceid'];
    activityid = items['activityid'];
    accountid = items['accountid'];
    dateAttended = items['date_attended'];
    timeAttended = items['time_attended'];
  }
}
