class Version {
  late int id, version;
  late bool isImportant;
  late DateTime createdAt;

  Version.parse(Map<String, dynamic> items) {
    id = items['id'];
    version = items['version'];
    isImportant = items['is_important'];
    createdAt = DateTime.parse(items['created_at']);
  }
}
