import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:isar/isar.dart';


// Manages the Journal and provides the updates for the app
class JournalProvider extends ChangeNotifier {
  final Journal _journal;
  final Isar _isar;
  bool _isLoading = false;

  JournalProvider(this._journal, this._isar);
  
  // Returns an unmodifiable list of journal entries
  List<JournalEntry> get entries => List.unmodifiable(_journal.entries);

  // Returns a clone of the journal to prevent direct modifications
  Journal get journal => _journal.clone();
  bool get isLoading => _isLoading;

  Future<void> loadEntries() async {
    _isLoading = true;
    notifyListeners();

    await _journal.loadEntries();

    _isLoading = false;
    notifyListeners();
  }

  // Calls upsertEntry to make sure listeners are notified of any changes
  void upsertJournalEntry(JournalEntry entry) async {
    _journal.upsertEntry(entry);
    
    await _isar.writeTxn(() async {
      await _isar.journalEntrys.put(entry);
    });
    // Makes sure the UI updates when data is being changed
    notifyListeners();
  }
}