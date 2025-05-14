import 'package:isar/isar.dart';
part 'journal_entry.g.dart';

@collection
// Represents a single journal entry with a unique id, text, and time stamps
class JournalEntry {
  // Unique id for the journal entry (managed by Isar)
  Id? id;

  // Text for the content of the journal entry (exercise name)
  late String workoutName;

  // Timestamp that indicates when the last entry was edited
  late DateTime updatedAt;

  // Timestamp that indicates when the entry was first made
  late DateTime createdAt;

  // Title for the journal entry
  late String title;

  // Number of sets performed in the workout session
  int sets;

  // Number of repetitions per set
  int reps;

  // Duration of the workout in minutes (for runners)
  int duration;

  // Amount of weight used in lbs
  int weight;

  // Factory constructor to create a new journal entry with default values. Automatically
  // assigns a unique id and sets time stamps
  factory JournalEntry.fromText({
      String workoutName = '',
      String title = '',
      int sets = 0,
      int reps = 0,
      int duration = 0,
      int weight = 0,
    }) {
    final now = DateTime.now();
    return JournalEntry(
        workoutName: workoutName,
        title: title,
        sets: sets,
        reps: reps,
        duration: duration,
        weight: weight,
        updatedAt: now,
        createdAt: now);
  }

  // Constructor for creating a journal entry with specific values
  JournalEntry({
      required this.workoutName,
      this.id,
      required this.updatedAt,
      required this.createdAt,
      required this.title,
      this.sets = 0,
      this.reps = 0,
      this.duration = 0,
      this.weight = 0
  });

  // Factory constructor for an empty journal entry
  factory JournalEntry.empty() {
    final now = DateTime.now();
    return JournalEntry(
      workoutName: 'Untitled Workout',
      title: 'Untitled Entry',
      sets: 0,
      reps: 0,
      duration: 0,
      weight: 0,
      updatedAt: now,
      createdAt: now,
    );
  }

  // Constructor to create a new entry from an existing one with an updated text
  // Keeps the original entry's Id and timestamp but updates the modified time
  JournalEntry.withUpdatedText(JournalEntry entry, String newText)
      : id = entry.id,
        createdAt = entry.createdAt,
        updatedAt = DateTime.now(),
        workoutName = newText,
        title = entry.title,
        sets = entry.sets,
        reps = entry.reps,
        duration = entry.duration,
        weight = entry.weight;
}
