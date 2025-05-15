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
    title: const Text('All Workout Entries'),
  ),
  body: ListView.builder(
    itemCount: entries.isEmpty ? 1 : entries.length,
    itemBuilder: (context, index) {
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
  floatingActionButton: Semantics(
    label: 'Add a new workout entry',
    excludeSemantics: true,
    child: FloatingActionButton(
      key: const Key('add_entry_button'),
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