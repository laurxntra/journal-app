import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';

class EntryView extends StatefulWidget {
  final JournalEntry entry;

  const EntryView({super.key, required this.entry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView>{

  late String currentText;

  @override
  void initState() {
    super.initState();
    currentText = widget.entry.text;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _popBack(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Workout Entry'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: TextFormField(
            initialValue: currentText,
            onChanged: (newText) => setState(() => currentText = newText),
            decoration: const InputDecoration(labelText: 'Entry Text'),
          ),
        ),
      ),
    );
  }

  void _popBack(BuildContext context){
    final updatedEntry = JournalEntry(
      text: currentText,
      id: widget.entry.id,
      createdAt: widget.entry.createdAt,
      updatedAt: DateTime.now(),
    );

    Navigator.pop(context, updatedEntry);
  }

}

