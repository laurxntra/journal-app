import 'package:flutter/material.dart';
import 'package:journal/views/entry_view.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:intl/intl.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:provider/provider.dart';

class AllEntriesView extends StatelessWidget {
  const AllEntriesView({super.key});

@override
Widget build(BuildContext context) {
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
    body: entries.isEmpty
        ? const Center(child: Text('No workout entries yet.'))
        : ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) =>
                _createListElementForEntry(context, entries[index]),
          ),
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


  Widget _createListElementForEntry(BuildContext context, JournalEntry entry) {
  final title = entry.title.isNotEmpty ? entry.title : 'Untitled Entry';
  final subtitle = _formatDateTime(entry.updatedAt);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        leading: Semantics(
          label: 'Workout entry: $title, last updated on $subtitle',
          excludeSemantics: true,
          child: const Icon(Icons.fitness_center),
        ),
      ),
    ),
  );
}


  Future<void> _navigateToEntry(BuildContext context, JournalEntry entry) async {
    final newEntry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntryView(entry: entry)),
    );

    // Ensure the newEntry is not null before attempting to upsert it
    if (newEntry != null) {
      final journalProvider = Provider.of<JournalProvider>(context, listen: false);
      await journalProvider.upsertJournalEntry(newEntry);
    }
  }

  String _formatDateTime(DateTime when) {
    return DateFormat.yMd().add_jm().format(when);
  }
}
