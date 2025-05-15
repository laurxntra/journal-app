import 'package:isar/isar.dart';
part 'journal_entry.g.dart';

@Collection()
// Represents a single journal entry with a unique id, text, and time stamps
class JournalEntry {
  // Unique id for the journal entry (managed by Isar)
  Id? id;

  // Text for the content of the journal entry (exercise name)
  late String text;

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


  // Factory constructor that creates a new journal entry with default values
  // Parameters:
  // - text: name of exercise
  // - title: Title of the workout entry
  // - sets: number of sets
  // - reps: number of repetitions
  // - duration: Duration in minutes
  // - weight: weight in pounds
  //
  // Returns:
  // - A JournalEntry with all the fields initalized 
  factory JournalEntry.fromText({
      String text = '',
      String title = '',
      int sets = 0,
      int reps = 0,
      int duration = 0,
      int weight = 0,
    }) {
    final now = DateTime.now();
    return JournalEntry(
        text: text,
        title: title,
        sets: sets,
        reps: reps,
        duration: duration,
        weight: weight,
        updatedAt: now,
        createdAt: now);
  }

  // Main constructor for creating a journal entry
  //
  // Parameters:
  // - text: name of exercise
  // - id: id, this is used when loaded from Isar
  // - createdAt: Timestamp when the entry was created
  // - updatedAt: Timestamp of last update
  // - title: title of the workout entry
  // - sets: number of sets
  // - reps: number of repetitions
  // - duration: amount of time in minutes
  // - weight: amount of weight
  JournalEntry({
      this.text = 'Untitled Workout',
      this.id,
      required this.updatedAt,
      required this.createdAt,
      this.title = 'Untitled Entry',
      this.sets = 0,
      this.reps = 0,
      this.duration = 0,
      this.weight = 0
  });

  // Factory constructor to create  a completely empty journal entry
  // 
  // Returns: A JournalEntry with default values and current timestamps
  factory JournalEntry.empty() {
    final now = DateTime.now();
    return JournalEntry(
      text: 'Untitled Workout',
      title: 'Untitled Entry',
      sets: 0,
      reps: 0,
      duration: 0,
      weight: 0,
      updatedAt: now,
      createdAt: now,
    );
  }

  // Constructor that creates a new journal entry from an existing one
  //
  // Parameters:
  // - entry: the original journal entry to copy from
  // - newText: the new exercise text
  //
  // Returns: A modified JournalEntry with updated text and timestamp
  JournalEntry.withUpdatedText(JournalEntry entry, String newText)
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
