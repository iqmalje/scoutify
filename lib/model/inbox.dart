class Inbox {
  //Define variable and constructor, thanks :>
  //Do update, as my variables might be slightly wrong

  late String inboxId,
      name,
      category, //determining icon to use
      details,
      imageurl;
  late bool isRead;

  Inbox({
    required this.inboxId,
    required this.name,
    required this.category,
    required this.details,
    required this.imageurl,
    required this.isRead,
  });
}
