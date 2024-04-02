class Inbox {
  //Define variable and constructor, thanks :>
  //Do update, as my variables might be slightly wrong

  late String id, title, description, type, target_id;
  late String? imageURL, target_group;
  late bool? has_read;
  late DateTime time;

  Inbox({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.description,
    required this.type,
    required this.target_group,
    required this.target_id,
    required this.has_read,
  });

  Inbox.parse(Map<String, dynamic> items) {
    id = items['id'];
    title = items['title'];
    time = DateTime.parse(items['time']);
    description = items['description'];
    type = items['type'];
    imageURL = items['imageURL'];
    target_group = items['target_group'];
    target_id = items['target_id'];
    has_read = items['has_read'];

    // now parse /n -> new line

    description = description.replaceAll('/n', '\n\n');

    // time + 8
    time = time.add(const Duration(hours: 8));
  }
}
