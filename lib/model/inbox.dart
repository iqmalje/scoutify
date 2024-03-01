class Inbox {
  //Define variable and constructor, thanks :>
  //Do update, as my variables might be slightly wrong

  late String inboxId,
      title,
      image_url,
      description,
      type,
      target_group,
      target_id;
  late bool isRead;

  Inbox({
    required this.inboxId,
    required this.title,
    required this.image_url,
    required this.description,
    required this.type,
    required this.target_group,
    required this.target_id,
    required this.isRead,
  });
}
