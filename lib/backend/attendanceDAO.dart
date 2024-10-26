import 'package:scoutify/model/attendance.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceDAO {
  var supabase = Supabase.instance.client;

  Future<List<Attendance>> getAttendance(String activityid,
      {String? id}) async {
    var data = await supabase.from('attendances').select('*').match({
      'activityid': activityid,
      'accountid': id ?? supabase.auth.currentUser!.id
    });
    List<Attendance> attendances = [];
    for (var attendance in data) {
      attendances.add(Attendance.parse(attendance));
    }

    return attendances;
  }

  Future<void> addAttendanceByScoutID(String activityid, String scoutID) async {
    try {
      await supabase.rpc('add_attendance_scout_id',
          params: {'aid': activityid, 'sid': scoutID});
    } catch (e) {
      print(e);
    }
  }

  Future<void> addAttendance(String activityid, String cardid) async {
    //get accountid from cardid

    try {
      if (cardid[0] == 'J' || cardid[0] == 'K' || cardid[0] == 'F') {
        await addAttendanceByScoutID(activityid, cardid);
        return;
      } else {
        print('tak dapat detect, mesti card id = $cardid');
        await supabase.rpc('add_attendance_card_id',
            params: {'aid': activityid, 'cid': cardid});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> getAllAttendees(
      String activityid, DateTime timeAttend) async {
    List<dynamic> item = [];
    print(
        "aid = $activityid, time_attend = ${'${timeAttend.year}-${timeAttend.month.toString().padLeft(2, '0')}-${timeAttend.day.toString().padLeft(2, '0')}%'}");
    item = await supabase.rpc('get_all_attendances', params: {
      'aid': activityid,
      'time_attend':
          '${timeAttend.year}-${timeAttend.month.toString().padLeft(2, '0')}-${timeAttend.day.toString().padLeft(2, '0')}%'
    });
    print("dah");
    return item;
  }
}
