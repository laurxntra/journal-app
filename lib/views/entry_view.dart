import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';

/// A screen to view and edit a single workout journal entry
/// Updates are saved when the user taps the save button and returns the updated entry
///
/// Parameters:
/// - entry: The JournalEntry to display and edit
class EntryView extends StatefulWidget {
  final JournalEntry entry;

  const EntryView({super.key, required this.entry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  // Editable state for each field in the form
  late String currentText; // Entry workout name
  late int currentSets; // Entry number of sets
  late int currentReps; // Entry number of repetitions
  late int currentWeight; // Entry weight used
  late int currentDura; // entry duration
  late String currentTitle; // entry workout title

  @override
  void initState() {
    super.initState();
    // Initalize current values from the provided JournalEntry/use default
    currentText =
        widget.entry.text.isNotEmpty ? widget.entry.text : 'Untitled Workout';
    currentSets = widget.entry.sets;
    currentReps = widget.entry.reps;
    currentWeight = widget.entry.weight;
    currentDura = widget.entry.duration;
    currentTitle = widget.entry.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          header: true,
          // Displays workout title or an empty string if none
          child: Text(currentTitle.isNotEmpty ? currentTitle : ''),
        ),
      ),
      body: PopScope(
        canPop: false,
        // Handles back navigation to save updated entry
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            _popBack(context);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Workout Title
              Semantics(
                label: 'Workout Title',
                excludeSemantics: true,
                child: TextFormField(
                  initialValue: currentTitle,
                  onChanged: (newTitle) =>
                      setState(() => currentTitle = newTitle),
                  decoration: InputDecoration(
                    labelText: 'Workout Title',
                    hintText: 'e.g. Leg Day',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Workout Name
              Semantics(
                label: 'Workout Name',
                excludeSemantics: true,
                child: TextFormField(
                  initialValue: currentText,
                  onChanged: (newText) => setState(() => currentText = newText),
                  decoration: InputDecoration(
                    labelText: 'Workout Name',
                    hintText: 'e.g. Leg Press',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Sets field
              Semantics(
                label: 'Amount of sets',
                excludeSemantics: true,
                child: TextFormField(
                  initialValue: currentSets.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (newSet) => setState(
                      () => currentSets = int.tryParse(newSet) ?? currentSets),
                  decoration: InputDecoration(
                    labelText: 'Amount of sets',
                    hintText: 'e.g. 5 sets',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Reps field
              Semantics(
                label: 'Amount of repetitions',
                excludeSemantics: true,
                child: TextFormField(
                  initialValue: currentReps.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (newRep) => setState(
                      () => currentReps = int.tryParse(newRep) ?? currentReps),
                  decoration: InputDecoration(
                    labelText: 'Amount of repetitions',
                    hintText: 'e.g. 30 repetitions',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Weight field
              Semantics(
                label: 'Amount of weight',
                excludeSemantics: true,
                child: TextFormField(
                  initialValue: currentWeight.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (newWeight) => setState(() =>
                      currentWeight = int.tryParse(newWeight) ?? currentWeight),
                  decoration: InputDecoration(
                    labelText: 'Amount of weight',
                    hintText: 'e.g. 120 lbs',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Duration field
              Semantics(
                label: 'Duration of workout (in minutes)',
                excludeSemantics: true,
                child: TextFormField(
                  initialValue: currentDura.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (newDura) => setState(
                      () => currentDura = int.tryParse(newDura) ?? currentDura),
                  decoration: InputDecoration(
                    labelText: 'Duration of workout (in minutes)',
                    hintText: 'e.g. 120 minutes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Button to save changes and return updated entry
              Semantics(
                label: 'Save Workout Entry',
                excludeSemantics: true,
                button: true,
                child: ElevatedButton(
                  onPressed: () => _popBack(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(128, 178, 213, 1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Creates an updated JournalEntry from the current field values and will
  /// navigate back to the previous screen and pass the results
  ///
  /// Parameters:
  /// - context: build context for navigator
  void _popBack(BuildContext context) {
    final updatedEntry = JournalEntry(
      text: currentText,
      title: currentTitle,
      id: widget.entry.id,
      createdAt: widget.entry.createdAt,
      updatedAt: DateTime.now(),
      sets: currentSets,
      reps: currentReps,
      duration: currentDura,
      weight: currentWeight,
    );

    Navigator.pop(context, updatedEntry);
  }
}
