import 'package:journal/models/journal_entry.dart';
import 'package:isar/isar.dart';

// Represents a collection of journal entries
class Journal {
  final Isar _isar;
  // name of journal
  final String name;

  // list of workout entries
  List<JournalEntry> _entries;

  // Default constructor to initialize the journal with a name and entry list
  Journal({required Isar isar, this.name = 'My work and Jot'})
    : _isar = isar,
    _entries = [];

  Future<void> loadEntries() async {
    _entries = await _isar.journalEntrys.where().findAll();
  }
  // Returns a copy of the entries list
  List<JournalEntry> get entries => List.from(_entries);

  // Inserts a new entry/updates an existing one based on id
  Future<void> upsertEntry(JournalEntry entry) async {
    await _isar.writeTxn(() async {
      await _isar.journalEntrys.put(entry);
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

  // Creates a copy of the journal, including all the fields provided from the entries
   Journal clone() {
    final cloned = Journal(isar: _isar, name: name);
    cloned._entries = List.from(_entries);
    return cloned;
  }
}