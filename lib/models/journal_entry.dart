// Represents a single journey entry with a unique id, text, and time stamps
class JournalEntry {
  // Unique id for the journal entry
  final int id;

  // Text for the content of the journal entry (exercise name)
  final String text;

  // Timestamp that indicates when the last entry was edited
  final DateTime updatedAt;

  // Timestamp that indicates when the entry was first made
  final DateTime createdAt;

  // Title for the journal entry
  final String title;

  // Number of sets performed in the workout session
  final int sets;

  // Number of repetitions per set 
  final int reps;

  // Duration of the workout in minutes (for runners)
  final int duration;

  // Amount of weight used in lbs
  final int weight;

  // Factory constructor to create a new journal entry with default values. Automatically
  // assigns a unique id and set time stamps
  factory JournalEntry.fromText({
      String text = '',
      String title = '',
      int sets = 0,
      int reps = 0,
      int duration = 0,
      int weight = 0,
    }) {
    final when = DateTime.now();
    return JournalEntry(
        text: text,
        title: title,
        sets: sets,
        reps: reps,
        duration: duration,
        weight: weight,
        id: SequentialIDMaker.nextID(),
        updatedAt: when,
        createdAt: when);
  }

  // Constructor for creating a journal entry with specific values
  JournalEntry(
      {required this.text,
      required this.id,
      required this.updatedAt,
      required this.createdAt,
      this.title = '',
      this.sets = 0,
      this.reps = 0,
      this.duration = 0,
      this.weight = 0});

  // Constructor to create a new entry from an existing one with an updated text
  // Keeps the original entry's Id and timestamp but updates the modified time
  JournalEntry.withUpdatedText(JournalEntry entry, newText)
      : id = entry.id,
        createdAt = entry.createdAt,
        updatedAt = DateTime.now(),
        text = newText,
        title = entry.title,
        sets = entry.sets,
        reps = entry.reps,
        duration = entry.duration,
        weight = entry.weight;
}

// Generates the unique id for the journal entries, increases the number
// so there is a new unique id for the next entry
class SequentialIDMaker {
  static int _lastID = 0;
  static int nextID() {
    _lastID += 1;
    return _lastID;
  }
}
