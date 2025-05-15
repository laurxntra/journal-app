import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:isar/isar.dart';

// Manages the Journal and notifies listeners for any updates
class JournalProvider extends ChangeNotifier {
  // Journal object that stores the workout entries
  final Journal _journal;

  // Indicates whether the journal data is currently being loaded
  bool _isLoading = false;

  // Private constructor used internally
  JournalProvider._(this._journal);

  /// Factory constructor to create a JournalProvider instance
  /// 
  /// Parameters:
  /// - isar: The Isar database passed in for journal storage
  factory JournalProvider(Isar isar) {
    final journal = Journal(isar: isar);
    return JournalProvider._(journal);
  }

  // Getter for the list of journal entries
  //
  // Returns:
  // - A unmodifiable list to prevent accidental edits
  List<JournalEntry> get entries => List.unmodifiable(_journal.entries);
  
  // Returns: a cloned copy of the current journal
  Journal get journal => _journal.clone();

  // Returns: whether the journal is currently loading data
  bool get isLoading => _isLoading;

  /// Loads journal entries from the database and updates listeners
  Future<void> loadEntries() async {
    _isLoading = true;
    // notifies UI to show loading state
    notifyListeners();

    // Loads entries from Isar database
    await _journal.loadEntries();

    _isLoading = false;

    // notifies UI to show updated data
    notifyListeners();
  }

  /// Adds or updates a journal entry and reloads the list
  ///
  /// Parameters: 
  /// - entry: The JournalEntry to be saved or updated
  Future<void> upsertJournalEntry(JournalEntry entry) async {
    // Save/update in the database
    await _journal.upsertEntry(entry);
    // Refresh the internal list
    await _journal.loadEntries();
    // Notifies UI
    notifyListeners();
  }
}
