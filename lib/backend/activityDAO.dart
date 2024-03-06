import 'package:scoutify/model/activity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActivityDAO {
  var supabase = Supabase.instance.client;

  Future<List<Activity>> getAttendedActivities(String filter) async {
    var data = await supabase.rpc('filter_attended_activities',
        params: {'filter': filter, 'aid': supabase.auth.currentUser!.id});

    List<Activity> activities = [];
    for (var activity in data) {
      activities.add(Activity(activity));
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

  Future<List<dynamic>> getAttendance(String activityid, {String? id}) async {
    var data = await supabase.from('attendance').select('*').match({
      'activityid': activityid,
      'accountid': id ?? supabase.auth.currentUser!.id
    });

    return data;
  }

  Future<void> deleteActivity(Activity activity) async {
    await supabase.storage
        .from('activities')
        .remove(['${activity.activityid}/cover.png']);

    await supabase
        .from('activities')
        .delete()
        .eq('activityid', activity.activityid);
  }
}