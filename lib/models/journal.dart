class Journal {
  int? id;
  String title;
  String content;
  String date;

  Journal({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  // Convert Journal to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
  }

  // Convert Map to Journal
  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
    );
  }
}