class Journal {
  final int? id;
  final String title;
  final String content;
  final String? imagePath; // Tambahan untuk menyimpan path gambar
  final String date;

  Journal({
    this.id,
    required this.title,
    required this.content,
    this.imagePath,
    required this.date,
  });

  // Convert Journal ke Map (untuk disimpan ke database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imagePath': imagePath,
      'date': date,
    };
  }

  // Convert Map dari database ke Journal
  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      imagePath: map['imagePath'],
      date: map['date'],
    );
  }
}
