import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';

Journal makeMockJournal() {
  return Journal(
    name: 'Work and Jot',
    entries: [
      JournalEntry.fromText(
        text: 'Leg day',
        title: 'Leg Press',
        sets: 4,
        reps: 10,
        weight: 80
      ),
      JournalEntry.fromText(
        text: 'Morning Run',
        title: 'Cardio',
        duration: 45,
      ),
      JournalEntry.fromText(
        text: 'Ab Day',
        title: 'Crunches',
        sets: 3,
        reps: 20,
      ),
    ],
  );
}