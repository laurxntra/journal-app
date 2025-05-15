import 'package:journal/models/journal_entry.dart';
import 'package:isar/isar.dart';

// Represents a journal that manages a collection of JournalEntry objects.
class Journal {
  // References to the Isar database
  final Isar _isar;

  // name of journal
  final String name;

  // list of workout entries
  List<JournalEntry> _entries;

  // Constructor to initalize the Journal with a given name and associated Isar
  //
  // Parameters:
  // - isar: The Isar database referenced used
  // - name: The name for the journal
  Journal({required Isar isar, this.name = 'My work and Jot'})
    : _isar = isar,
    _entries = [];

  // Loads all journal entries from the Isar database and populates the entries list
  Future<void> loadEntries() async {
    _entries = await _isar.journalEntrys.where().findAll();
  }
  // Returns a copy of the entries list
  List<JournalEntry> get entries => List.from(_entries);

  // Inserts a new entry/updates an existing one based on id
  // 
  // Parameters:
  // - entry: the journal entry to insert or update
  Future<void> upsertEntry(JournalEntry entry) async {
    await _isar.writeTxn(() async {
      // insert or update entry in the database to get its id
      final id = await _isar.journalEntrys.put(entry);

      // If this is a new entry, update the local object's id
      if (entry.id == null || entry.id == 0) {
        entry.id = id;
      }
    });

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

  // Creates a copy of the journal instance
  // 
  // Returns: A new Journal object with identical properties and data
   Journal clone() {
    final cloned = Journal(isar: _isar, name: name);
    cloned._entries = List.from(_entries);
    return cloned;
  }
}