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
        title: const Text('All Journal Entries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add New Entry',
            onPressed: () {
              final newEntry = JournalEntry.fromText(text: 'New Entry');
              _navigateToEntry(context, newEntry);
            },
          ),
        ],
      ),
      body: Consumer<JournalProvider>(
        builder: (context, journalProvider, child) {
          final entries = journalProvider.entries;
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) => _createListElementForEntry(context, entries[index]),
          );
        },
      ),
      
    );
  }

  Widget _createListElementForEntry(BuildContext context, JournalEntry entry) {
    return ListTile(
      title: Text(entry.title.isNotEmpty ? entry.title : 'Untitled Entry'),
      subtitle: Text(_formatDateTime(entry.updatedAt)),
      onTap: () => _navigateToEntry(context, entry),
    );
  }

  Future<void> _navigateToEntry(BuildContext context, JournalEntry entry) async {
    final newEntry = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => EntryView(entry: entry))
    );

    // If the widget tree is unmounted do not execute
    if (!context.mounted || newEntry == null) return;


    final journalProvider = Provider.of<JournalProvider>(context, listen: false);

    journalProvider.upsertJournalEntry(newEntry);

  }

  _formatDateTime(DateTime when){
    return DateFormat.yMd().add_jm().format(when);
  }

}