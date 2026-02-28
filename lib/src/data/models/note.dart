class Note {
  final String title;
  final String content;
  final DateTime createdAt;
  final int mood;
  final String id;
  final String folderId;

  Note({
    required this.title,
    required this.content,
    required this.createdAt,
    required this.mood,
    required this.id,
    required this.folderId,
  });
}
