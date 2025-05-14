import 'package:journal/models/journal_entry.dart';
import 'package:isar/isar.dart';

// Represents a collection of journal entries
class Journal {
  final Isar? _isar; // Make _isar nullable
  // name of journal
  final String name;

  // list of workout entries
  List<JournalEntry> _entries;

  // Default constructor to initialize the journal with a name and entry list
  Journal({Isar? isar, this.name = 'My work and Jot'}) 
    : _isar = isar,
      _entries = [];

  Future<void> loadEntries() async {
    if (_isar != null) {
      _entries = await _isar.journalEntrys.where().findAll();
    } else {
      // Handle the case where _isar is null (e.g., load from mock data or an empty list)
      _entries = []; 
    }
  }
  // Returns a copy of the entries list
  List<JournalEntry> get entries => List.from(_entries);

  // Inserts a new entry/updates an existing one based on id
  Future<void> upsertEntry(JournalEntry entry) async {
    if (_isar != null) {
      await _isar.writeTxn(() async {
        await _isar.journalEntrys.put(entry);
      });

      final int index = _entries.indexWhere((e) => e.id == entry.id);
      if (index != -1) {
        _entries[index] = entry;
      } else {
        _entries.add(entry);
      }
    } else {
      // Handle the case where _isar is null (e.g., add to an in-memory list)
      final int index = _entries.indexWhere((e) => e.id == entry.id);
      if (index != -1) {
        _entries[index] = entry;
      } else {
        _entries.add(entry);
      }
    }
  }

  // Creates a copy of the journal, including all the fields provided from the entries
  Journal clone() {
    return Journal(isar: _isar, name: name);
  }
}