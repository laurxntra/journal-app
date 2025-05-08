class JournalEntry {
  final int id;

  final String text;

  final DateTime updatedAt;

  final DateTime createdAt;

  factory JournalEntry.fromText({String text = ''}) {
    final when = DateTime.now();
    return JournalEntry(
        text: text,
        id: SequentialIDMaker.nextID(),
        updatedAt: when,
        createdAt: when);
  }

  JournalEntry(
      {required this.text,
      required this.id,
      required this.updatedAt,
      required this.createdAt});

  JournalEntry.withUpdatedText(JournalEntry entry, newText)
      : id = entry.id,
        createdAt = entry.createdAt,
        updatedAt = DateTime.now(),
        text = newText;
}

class SequentialIDMaker {
  static int _lastID = 0;
  static int nextID() {
    _lastID += 1;
    return _lastID;
  }
}
