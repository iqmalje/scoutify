import 'dart:io';

import 'package:escout/model/account.dart';
import 'package:escout/model/activity.dart';
import 'package:escout/model/facility.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseB {
  var supabase = Supabase.instance.client;

  static bool isAdminToggled = false;

  /// Returns a list of attended activities that has been attended
  /// by the user that is logged in.
  ///
  /// May return an empty list if there is no activity attended.
  Future<List<Activity>> getAttendedActivities(String filter) async {
    var data = await supabase.rpc('filter_attended_activities',
        params: {'filter': filter, 'aid': supabase.auth.currentUser!.id});

    List<Activity> activities = [];
    for (var activity in data) {
      activities.add(Activity(activity));
    }
    return activities;
  }

  Future<void> updateDisplayName(String displayName) async {
    String userid = supabase.auth.currentUser!.id;

    await supabase
        .from('accounts')
        .update({'card_name': displayName}).eq('accountid', userid);
  }

  /// This function may accept any file, but please properly pass it through CroppedFile implementation
  /// to ensure the picture selected is perfect
  /// Returns new path of the image
  Future<String> updateDigitalPicture(File file) async {
    String userid = supabase.auth.currentUser!.id;

    try {
      await supabase.storage
          .from('profile_pic')
          .upload('$userid/profilepic.png', file);
    } catch (e) {
      // file has already existed
      await supabase.storage
          .from('profile_pic')
          .update('$userid/profilepic.png', file);
    }

    //get url
    String profileurl = supabase.storage
        .from('profile_pic')
        .getPublicUrl('$userid/profilepic.png');

    // update profile to db
    await supabase
        .from('accounts')
        .update({'image_url': profileurl}).eq('accountid', userid);

    print('UPDATED = ');
    return profileurl;
  }

  Future<List<dynamic>> getChatsAdmin() async {
    // return all chat that involves current user

    List<dynamic> chats = [];

    var data = await supabase
        .rpc('get_init_chat', params: {'uid': supabase.auth.currentUser!.id});

    for (var c in data) {
      if (c['party1'] == supabase.auth.currentUser!.id) {
        // get other party's data
        chats.add((await supabase
            .from('accounts')
            .select('*')
            .match({'accountid': c['party2']}))[0]);
      } else {
        chats.add((await supabase
            .from('accounts')
            .select('*')
            .match({'accountid': c['party1']}))[0]);
      }
    }

    return chats;
  }

  Future<void> addNewChat(String party1, String party2, String content) async {
    await supabase.from('chats').insert({
      'party1': party1,
      'party2': party2,
      'content': content,
      'sent_by': supabase.auth.currentUser!.id
    });
  }

  /// Set the status of the activity to done
  Future<void> updateActivityDone(String activityid) async {
    await supabase
        .from('activities')
        .update({'status': 'DONE'}).eq('activityid', activityid);
  }

  Future<List<dynamic>> getAttendance(String activityid, {String? id}) async {
    var data = await supabase.from('attendance').select('*').match({
      'activityid': activityid,
      'accountid': id ?? supabase.auth.currentUser!.id
    });

    return data;
  }

  /// Fetch officers or admin account in DB
  Future<List<dynamic>> getOfficers() async {
    print('kita fetch');
    var data = await supabase
        .from('accounts')
        .select('*')
        .or('roles.eq.ADMIN,roles.eq.OFFICER')
        .not('accountid', 'eq', supabase.auth.currentUser!.id);
    print('dah fetch');
    print(data);

    return data;
  }

  /// Sign in the user to the application, will auto login
  /// So the user wont have to login everytime.
  Future<bool> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(password: password, email: email);
      //on sign in, just set the var to false
      isAdminToggled = false;
      return true;
    } catch (e) {
      if (e.toString().contains('login credentials')) {
        throw Exception("Invalid login credentials");
      }

      rethrow;
    }
  }

  /// Send an OTP to user's email for forgot password
  Future<void> sendPasswordOTP(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  /// Will sign out user, and the user will have to relogin
  /// when opening the app again later.
  Future<void> signout() async {
    await supabase.auth.signOut();
  }

  Future<void> deleteFacility(String facilityid) async {
    await supabase.from('facilities').delete().eq('facility', facilityid);
  }

  /// It will return the model Account, this is based on user's login info
  /// If user is not logged in to the application, an error will be thrown out!
  Future<Account> getProfileInfo() async {
    var userid = supabase.auth.currentUser!.id;
    var data =
        await supabase.from('accounts').select('*').eq('accountid', userid);

    return Account(data[0]);
  }

  Future<bool> verifyPasswordOTP(String email, String OTP) async {
    try {
      var data = await supabase.auth
          .verifyOTP(email: email, token: OTP, type: OtpType.recovery);

      if (data.session != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Token has expired or is invalid");
    }
  }

  Future<void> updatePassword(String email, String password) async {
    try {
      await supabase.auth
          .updateUser(UserAttributes(email: email, password: password));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addAttendance(String activityid, String cardid) async {
    //get accountid from cardid

    try {
      if (cardid[0] == 'J') {
        await addAttendanceByScoutID(activityid, cardid);
        return;
      }
      var accid = await supabase
          .from('accounts')
          .select('accountid, fullname')
          .match({'cardid': cardid}).single();
      print(accid);
      await supabase.from('attendance').insert({
        'activityid': activityid,
        'accountid': accid['accountid'],
        'fullname': accid['fullname'],
        'attendancekey':
            '${accid['accountid']}.${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}.$activityid'
      });
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

  Future<List<Facility>> getFacilities() async {
    var data = await supabase.from('facilities').select('*');
    List<Facility> facilities = [];
    for (var element in data) {
      facilities.add(Facility(element));
    }
    return facilities;
  }

  Future<dynamic> getAttendedDates(String facilityid, DateTime timePicked,
      {String? id}) async {
    print("PATUT KAT SINI DOH");

    print(
        ' ${supabase.auth.currentUser!.id} $facilityid ${timePicked.year}-${timePicked.month}-${timePicked.day}%');
    var data = await supabase.rpc('get_access_by_date', params: {
      'uid': id ?? supabase.auth.currentUser!.id,
      'fid': facilityid,
      'date':
          '${timePicked.year}-${timePicked.month.toString().padLeft(2, '0')}-${timePicked.day.toString().padLeft(2, '0')}%'
    });

    print("DATA = $data");
    return data;
  }

  /// Since adding an event requires many params, it is better
  /// for developers to send out a Map instead, below is the required info
  /// for a map.
  ///
  /// Map<String, dynamic>
  /// {
  ///   name, category, location, startdate, enddate, file (FOR IMAGE)
  /// }
  ///
  /// TODO: Update this function to receive class Activity instead.
  Future<void> addEvent(Map<String, dynamic> items) async {
    var accid = supabase.auth.currentUser!.id;

    var activity = await supabase
        .from('activities')
        .insert({
          'name': items['name'],
          'category': items['category'].toString().toUpperCase(),
          'location': items['location'],
          'startdate': items['startdate'],
          'enddate': items['enddate'],
          'is_show_activity': true,
          'created_by': accid,
          'is_show_feed': false,
        })
        .select('activityid')
        .single();

    //upload to db
    //{activityid: blabla}
    await supabase.storage
        .from('activities')
        .upload('${activity['activityid']}/cover.png', items['file']);

    //update activity db

    await supabase.from('activities').update({
      'imageurl': supabase.storage
          .from('activities')
          .getPublicUrl('${activity['activityid']}/cover.png')
    }).eq('activityid', activity['activityid']);
  }

  Future<void> updateEvent(
      Map<String, dynamic> items, String activityID) async {
    var accid = supabase.auth.currentUser!.id;

    await supabase.from('activities').update({
      'name': items['name'],
      'category': items['category'].toString().toUpperCase(),
      'location': items['location'],
      'startdate': items['startdate'],
      'enddate': items['enddate'],
      'is_show_activity': true,
      'created_by': accid,
      'is_show_feed': false,
    }).eq('activityid', activityID);

    //upload to db
    //{activityid: blabla}

    if (items['file'] != null) {
      await supabase.storage
          .from('activities')
          .update('$activityID/cover.png', items['file']);
      //update activity db
      await supabase.from('activities').update({
        'imageurl': supabase.storage
            .from('activities')
            .getPublicUrl('$activityID/cover.png')
      });
    }

    print('dah update');
  }

  Future<dynamic> getScoutDetails(String scoutid) async {
    var data = await supabase
        .from('accounts')
        .select(
            'no_ahli, no_tauliah, unit, daerah,  is_member,position, image_url')
        .eq('accountid', scoutid)
        .single();

    return data;
  }

  Future<void> createFacility(Map<String, dynamic> items) async {
    print(items);
    var accid = supabase.auth.currentUser!.id;

    var facilityid = await supabase
        .from('facilities')
        .insert({
          'created_by': accid,
          'handled_by': accid,
          'name': items['name'],
          'address1': items['address1'],
          'address2': items['address2'],
          'city': items['city'],
          'state': items['state'],
          'postcode': int.parse(items['postcode']),
          'pic': items['pic']
        })
        .select('facility')
        .single();

    await supabase.storage
        .from('facilities')
        .upload('${facilityid['facility']}/cover.png', items['image']);
  }

  Future<dynamic> getNumberAccess(String facilityid, DateTime datetime) async {
    var data = await supabase.rpc('get_number_access', params: {
      'fid': facilityid,
      'date':
          '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}%'
    });

    return data;
  }

  Future<dynamic> getTotalAccess(String facilityid, DateTime datetime) async {
    var data = await supabase.rpc('get_total_access', params: {
      'fid': facilityid,
      'date':
          '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}%'
    });

    print(data);
    return data;
  }

  Future<dynamic> getAllAccess(String facilityid, DateTime datetime) async {
    var data = await supabase.rpc('get_all_access', params: {
      'fid': facilityid,
      'date':
          '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}%'
    });

    return data;
  }

  Future<void> updateFacility(String facilityid, Map<String, dynamic> items,
      {File? newImage}) async {
    print('$facilityid = 75ddee9a-69f9-4630-8d3f-37ee28cf3c54');
    var data = await supabase
        .from('facilities')
        .update({
          'name': items['name'],
          'address1': items['address1'],
          'address2': items['address2'],
          'city': items['city'],
          'state': items['state'],
          'postcode': int.parse(items['postcode']),
          'pic': items['pic']
        })
        .eq('facility', facilityid)
        .select('*');

    if (newImage != null) {
      await supabase.storage
          .from('facilities')
          .remove(['$facilityid/cover.png']);
      print('DAH DELETE');
      await supabase.storage
          .from('facilities')
          .upload('$facilityid/cover.png', newImage);
    }
    print(data);
  }

  String getFacilityImage(String facilityid) {
    return supabase.storage
        .from('facilities')
        .getPublicUrl('$facilityid/cover.png');
  }

  /// Get a list of feed for the user
  Future<List<Activity>> getFeed() async {
    var feed = await supabase
        .from('activities')
        .select('*')
        .match({'is_show_feed': true}).order('created_at');

    List<Activity> activities = [];

    for (var data in feed) {
      activities.add(Activity(data));
    }
    return activities;
  }

  Future<List<Activity>> getActivities({Map<String, dynamic>? filters}) async {
    print(filters);
    List<dynamic> rawData = [];
    List<Activity> activities = [];
    if (filters == null) {
      var activities = await supabase.from('activities').select('*');

      rawData = activities;
    } else {
      var activities = await supabase.rpc('filter_activities', params: {
        'filter':
            '${filters['year']}-${filters['month'].toString().padLeft(2, '0')}-%'
      });

      rawData = activities;
    }

    for (var activity in rawData) {
      activities.add(Activity(activity));
    }

    return activities;
  }

  /// Delete activity functionality
  Future<void> deleteActivity(Activity activity) async {
    await supabase.storage
        .from('activities')
        .remove(['${activity.activityid}/cover.png']);

    await supabase
        .from('activities')
        .delete()
        .eq('activityid', activity.activityid);
  }

  Future<void> createFeed(Map<String, dynamic> items) async {
    var accid = supabase.auth.currentUser!.id;
    var activity = await supabase
        .from('activities')
        .insert({
          'name': items['name'],
          'category': items['category'].toString().toUpperCase(),
          'location': items['location'],
          'startdate': items['startdate'],
          'enddate': items['enddate'],
          'is_show_activity': items['is_show_activity'],
          'created_by': accid,
          'fee': items['fee'],
          'registrationenddate': items['registrationenddate'],
          'description': items['description'],
          'is_show_feed': true,
        })
        .select('activityid')
        .single();

    //upload to storage

    await supabase.storage
        .from('activities')
        .upload('${activity['activityid']}/cover.png', items['file']);

    await supabase.from('activities').update({
      'imageurl': supabase.storage
          .from('activities')
          .getPublicUrl('${activity['activityid']}/cover.png')
    }).eq('activityid', activity['activityid']);
  }

  Future<void> updateFeed(Map<String, dynamic> items, String activityID) async {
    var accid = supabase.auth.currentUser!.id;
    await supabase.from('activities').update({
      'name': items['name'],
      'category': items['category'].toString().toUpperCase(),
      'location': items['location'],
      'startdate': items['startdate'],
      'enddate': items['enddate'],
      'is_show_activity': items['is_show_activity'],
      'created_by': accid,
      'fee': items['fee'],
      'registrationenddate': items['registrationenddate'],
      'description': items['description'],
      'is_show_feed': true,
    }).eq('activityid', activityID);

    //upload to storage
    if (items['file'] != null) {
      await supabase.storage
          .from('activities')
          .update('$activityID/cover.png', items['file']);

      await supabase.from('activities').update({
        'imageurl': supabase.storage
            .from('activities')
            .getPublicUrl('$activityID/cover.png')
      }).eq('activityid', activityID);
    }

    print('dah update');
  }

  Future<void> addAttendanceByScoutID(String activityid, String scoutID) async {
    try {
      var accid = await supabase
          .from('accounts')
          .select('accountid, fullname')
          .eq('no_ahli', scoutID)
          .single();

      print(accid);

      await supabase.from('attendance').insert({
        'activityid': activityid,
        'accountid': accid['accountid'],
        'fullname': accid['fullname'],
        'attendancekey':
            '${accid['accountid']}.${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}.$activityid'
      });
    } catch (e) {
      print(e);
    }
  }
}
