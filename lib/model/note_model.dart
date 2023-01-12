class Note {
  int? id;
  String? title;
  String? content;
  String? dateTimeEdited;
  String? dateTimeCreated;
  int isExpand = 0;

  Note({
    this.id,
    this.title,
    this.content,
    this.dateTimeEdited,
    this.dateTimeCreated,
    required this.isExpand,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateTimeEdited': dateTimeEdited,
      'dateTimeCreated': dateTimeCreated,
      'isExpand': isExpand,
    };
  }
}
