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
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Workout Entries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToEntry(context, JournalEntry.empty()),
          ),
        ],
      ),
      body: Consumer<JournalProvider>(
        builder: (context, journalProvider, child) {
          final entries = journalProvider.entries;

          if (entries.isEmpty) {
            return const Center(
              child: Text('No workout entries yet.'),
            );
          }

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) =>
                _createListElementForEntry(context, entries[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEntry(context, JournalEntry.empty()),
        child: const Icon(Icons.add),
      ),
    );
  }

Widget _createListElementForEntry(BuildContext context, JournalEntry entry) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: GestureDetector(
      onTap: () => _navigateToEntry(context, entry),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          title: Text(entry.title.isNotEmpty ? entry.title : 'Untitled Entry'),
          subtitle: Text(_formatDateTime(entry.updatedAt)),
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

    if (!context.mounted || newEntry == null) return;

    final journalProvider = Provider.of<JournalProvider>(context, listen: false);
    await journalProvider.upsertJournalEntry(newEntry);
  }

  String _formatDateTime(DateTime when) {
    return DateFormat.yMd().add_jm().format(when);
  }
}
