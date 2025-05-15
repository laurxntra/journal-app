import 'package:flutter/material.dart';
import 'package:journal/views/entry_view.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:intl/intl.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:provider/provider.dart';

// Displays the list of all workout journal entries
class AllEntriesView extends StatelessWidget {
  const AllEntriesView({super.key});

@override
Widget build(BuildContext context) {
  // Accesses the JournalProviderr to retrieve saved entries
  final journalProvider = Provider.of<JournalProvider>(context);
  final entries = journalProvider.entries;

  return Scaffold(
    appBar: AppBar(
      title: Semantics(
        child: const Text('All Workout Entries'),
      ),
      actions: [
        Semantics(
          label: 'Add a new workout entry',
          excludeSemantics: true,
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToEntry(context, JournalEntry.empty()),
          ),
        ),
      ],
    ),
    // List of all entries/empty messages
    body: ListView.builder(
      itemCount: entries.isEmpty ? 1 : entries.length,
      itemBuilder: (context, index) {
        // If the entries are empty, show "No work out entries yet"
        if (entries.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('No workout entries yet.'),
            ),
          );
        // Otherwise fill them with the list tile for each entry
        } else {
          return _createListElementForEntry(context, entries[index]);
        }
      },
    ),
    // FAB to create a new workout entry
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

// Creates a card list for a journal entry
// 
// Parameters:
// - context: build context for navigation
// - entry: The JournalEntry to display
//
// Returns: A widget representing one entry
Widget _createListElementForEntry(BuildContext context, JournalEntry entry) {
  // Show 'Untitled Entry' if there is no title present
  final title = entry.title.isNotEmpty ? entry.title : 'Untitled Entry';
  final subtitle = _formatDateTime(entry.updatedAt);

  return Padding(
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
          onTap: () => _navigateToEntry(context, entry),
          trailing: const Icon(Icons.chevron_right),
          leading: const Icon(Icons.fitness_center),
        ),
      ),
    ),
  );
}

// Navigates to the EntryView screen for editing/creating an entry
//
// Returns an
Future<void> _navigateToEntry(BuildContext context, JournalEntry entry) async {
  final journalProvider = Provider.of<JournalProvider>(context, listen: false);

  final JournalEntry? newEntry = await Navigator.push<JournalEntry>(
    context,
    MaterialPageRoute(builder: (context) => EntryView(entry: entry)),
  );

  if (newEntry != null) {
    await journalProvider.upsertJournalEntry(newEntry);
  }
}


  String _formatDateTime(DateTime when) {
    return DateFormat.yMd().add_jm().format(when);
  }
}