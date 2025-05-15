import 'package:flutter/material.dart';
import 'package:journal/views/entry_view.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:intl/intl.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:provider/provider.dart';

// A stateless widget that displays all workout journal entries in a scrollable list
// This will allow users to tap on entries to view/edit them or even create a new one
class AllEntriesView extends StatelessWidget {
  const AllEntriesView({super.key});


@override
Widget build(BuildContext context) {
  // Access the journal provider to get current entries
  final journalProvider = Provider.of<JournalProvider>(context);
  final entries = journalProvider.entries;

  return Scaffold(
    appBar: AppBar(
      title: Semantics(
        child: const Text('All Workout Entries'),
      ),
    ),
    body: ListView.builder(
      itemCount: entries.isEmpty ? 1 : entries.length,
      itemBuilder: (context, index) {
        // If there are no entries, show the message 'no workout entries yet"
        // Otherwise, build the list of entries
        if (entries.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('No workout entries yet.'),
            ),
          );
        } else {
          return _createListElementForEntry(context, entries[index]);
        }
      },
    ),
    // Add a new workout entry
    floatingActionButton: Semantics(
      label: 'Add a new workout entry',
      excludeSemantics: true,
      child: FloatingActionButton(
        onPressed: () => _navigateToEntry(context, JournalEntry.empty()),
        child: const Icon(Icons.add),
      ),
    ),
  );
}

// Creates a styled and accessible list item for a single JournalEntry
// 
// Parameters:
// - context: Current build context
// - entry: The journal entry to display
// 
// Returns: A ListTile widget with entry details
Widget _createListElementForEntry(BuildContext context, JournalEntry entry) {
  final title = entry.title.isNotEmpty ? entry.title : 'Untitled Entry';
  final subtitle = _formatDateTime(entry.updatedAt);

  return Padding(
    // Adds horizontal and vertical padding around the list item
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Semantics(
      label: 'View workout entry: $title, last updated on $subtitle',
      button: true,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(title),
          subtitle: Text(subtitle),
          key: Key('entry_file_${entry.id}'),
          onTap: () => _navigateToEntry(context, entry),
          trailing: const Icon(Icons.chevron_right),
          leading: const Icon(Icons.fitness_center),
        ),
      ),
    ),
  );
}

// Navigates to the entry editing screen and awaits potential changes
//
// Parameters:
// - context: build context to use navigation
// - entry: the journal entry to view or edit
Future<void> _navigateToEntry(BuildContext context, JournalEntry entry) async {
  // Grab the JournalProvider without listening for updates
  final journalProvider = Provider.of<JournalProvider>(context, listen: false);

  // Navigate to the EntryView page, waits asynch for the user to return
  // an updated or new JournalEntry
  final JournalEntry? newEntry = await Navigator.push<JournalEntry>(
    context,
    MaterialPageRoute(builder: (context) => EntryView(entry: entry)),
  );

  // If the user saved changes and returned a new/updated entry, update 
  // the journal using the provider to persist the changes
  if (newEntry != null) {
    await journalProvider.upsertJournalEntry(newEntry);
  }
}

  // Formats a DateTime into a string for UI display
  //
  // Parameters:
  // - when: The DateTime to format
  //
  // Returns: A formatted date/time string
  String _formatDateTime(DateTime when) {
    return DateFormat.yMd().add_jm().format(when);
  }
}
