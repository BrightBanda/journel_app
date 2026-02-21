class Note {
  final String title;
  final String content;
  final DateTime createdAt;
  final int? mood;
  final int id;

  Note({
    required this.title,
    required this.content,
    required this.createdAt,
    this.mood,
    required this.id,
  });
}
