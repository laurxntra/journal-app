import 'package:journal/models/journal_entry.dart';

// Represents a collection of journal entries
class Journal {
  // name of journal
  final String name;

  // list of workout entries
  final List<JournalEntry> _entries;

  // Default constructor to initialize the journal with a name and entry list
  Journal({this.name = 'My Work and Jot', List<JournalEntry>? entries})
    : _entries = entries ?? [];

  // Returns a copy of the entries list
  List<JournalEntry> get entries => List.from(_entries);

  // Inserts a new entry/updates an existing one based on id
  void upsertEntry(JournalEntry entry) {
    // Finds the index of the entry with the matching id
    final int index = _entries.indexWhere((e) => e.id == entry.id);
    
    // If the entry exists, replace it
    if (index != -1) {
      _entries[index] = entry;
    // Otherwise, add a new entry
    } else {
      _entries.add(entry);
    }
  }

  // Creates a copy of the journal, including all the fields provided from the entries
   Journal clone() {
    return Journal(name: name, entries: List.from(_entries));
  }
}