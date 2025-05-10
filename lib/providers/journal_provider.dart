import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';

// Manages the Journal and provides the updates for the app
class JournalProvider extends ChangeNotifier {
  final Journal _journal;

  JournalProvider(this._journal);
  
  // Returns an unmodifiable list of journal entries
  List<JournalEntry> get entries => List.unmodifiable(_journal.entries);

  // Returns a clone of the journal to prevent direct modifications
  Journal get journal => _journal.clone();

  // Calls upsertEntry to make sure listeners are notified of any changes
  void upsertJournalEntry(JournalEntry entry) {
    _journal.upsertEntry(entry);
    // Makes sure the UI updates when data is being changed
    notifyListeners();
  }
}