import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';

Journal makeMockJournal() {
  return Journal(
    name: 'Work and Jot',
    entries: [
      JournalEntry.fromText(
        title: 'Leg day',
        workoutName: 'Leg Press',
        sets: 4,
        reps: 10,
        weight: 80
      ),
      JournalEntry.fromText(
        title: 'Morning Run',
        workoutName: 'Cardio',
        duration: 45,
      ),
      JournalEntry.fromText(
        title: 'Ab Day',
        workoutName: 'Crunches',
        sets: 3,
        reps: 20,
      ),
    ],
  );
}