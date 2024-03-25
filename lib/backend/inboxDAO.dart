import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/model/inbox.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InboxDAO {
  var supabase = Supabase.instance.client;

  Future<void> deleteInbox(String inboxID) async {
    await supabase.from('inboxes').delete().eq('id', inboxID);
  }

  Future<void> markSeen(String inboxID) async {
    await supabase.from('inboxes').update({'has_read': true}).eq('id', inboxID);
  }

  Future<void> markAllSeen() async {
    await supabase.from('inboxes').update({'has_read': true}).eq(
        'target_id', CurrentAccount.getInstance().accountid);
  }

  Future<void> deleteAll() async {
    await supabase
        .from('inboxes')
        .delete()
        .eq('target_id', CurrentAccount.getInstance().accountid);
  }
}

enum InboxType {
  update,
  informatics,
}
