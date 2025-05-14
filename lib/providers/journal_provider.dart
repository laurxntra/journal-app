import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:isar/isar.dart';

// Manages the Journal and provides updates to the app
class JournalProvider extends ChangeNotifier {
  final Journal _journal;
  bool _isLoading = false;

  // Private constructor used internally
  JournalProvider._(this._journal);

  // Single factory constructor that both tests and app will use
  factory JournalProvider(Isar isar) {
    final journal = Journal(isar: isar);
    return JournalProvider._(journal);
  }

  List<JournalEntry> get entries => List.unmodifiable(_journal.entries);
  Journal get journal => _journal.clone();
  bool get isLoading => _isLoading;

  Future<void> loadEntries() async {
    _isLoading = true;
    notifyListeners();

    await _journal.loadEntries();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> upsertJournalEntry(JournalEntry entry) async {
    await _journal.upsertEntry(entry);
    notifyListeners();
  }
}
