import 'package:scoutify/model/inbox.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InboxDAO {
  var supabase = Supabase.instance.client;

  Future<void> deleteInbox(String inboxID) async {
    await supabase.from('inboxes').delete().eq('id', inboxID);
  }
}

enum InboxType {
  update,
  informatics,
}
