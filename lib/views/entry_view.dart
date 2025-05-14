import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';

class EntryView extends StatefulWidget {
  final JournalEntry entry;

  const EntryView({super.key, required this.entry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  late String currentText;
  late int currentSets;
  late int currentReps;
  late int currentWeight;
  late int currentDura;
  late String currentTitle;

  @override
  void initState() {
    super.initState();
    currentText = widget.entry.text.isNotEmpty ? widget.entry.text : 'Untitled Workout';
    currentSets = widget.entry.sets;
    currentReps = widget.entry.reps;
    currentWeight = widget.entry.weight;
    currentDura = widget.entry.duration;
    currentTitle = widget.entry.title;
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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(currentTitle.isNotEmpty ? currentTitle : ''),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title of the workout 
              Semantics(
                label: 'Workout Title', 
                child: TextFormField(
                  initialValue: currentTitle,
                  onChanged: (newTitle) => setState(() => currentTitle = newTitle),
                  decoration: InputDecoration(
                    labelText: 'Workout Title',
                    hintText: 'e.g. Leg Day',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16,),

              // Workout name text field
              Semantics(
                label: 'Workout Name',
                child: TextFormField(
                  initialValue: currentText,
                  onChanged: (newText) => setState(() => currentText = newText),
                  decoration: InputDecoration(
                    labelText: 'Workout Name',
                    hintText: 'e.g. Leg Press',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
            
              // Number of sets field
              Semantics(
                label: 'Amount of sets', 
                child: TextFormField(
                  initialValue: currentSets.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (newSet) => setState(() => currentSets = int.tryParse(newSet) ?? currentSets),
                  decoration: InputDecoration(
                    labelText: 'Amount of sets',
                    hintText: 'e.g. 5 sets',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
            
              // Number of reps field
              Semantics(
                label: 'Amount of repetitions', 
                child: TextFormField(
                  initialValue: currentReps.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (newRep) => setState(() => currentReps = int.tryParse(newRep) ?? currentReps),
                  decoration: InputDecoration(
                    labelText: 'Amount of repetitions',
                    hintText: 'e.g. 30 repetitions',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
            
              // Amount of weight
              Semantics(
                label: 'Amount of weight',
                child: TextFormField(
                  initialValue: currentWeight.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (newWeight) => setState(() => currentWeight = int.tryParse(newWeight) ?? currentWeight),
                  decoration: InputDecoration(
                    labelText: 'Amount of weight',
                    hintText: 'e.g. 120 lbs',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16,),

              // Duration of workout
              Semantics(
                label: 'Duration of workout (in minutes)',
                child: TextFormField(
                  initialValue: currentDura.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (newDura) => setState(() => currentDura = int.tryParse(newDura) ?? currentDura),
                  decoration: InputDecoration(
                    labelText: 'Duration of workout (in minutes)',
                    hintText: 'e.g. 120 minutes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
            
              // Save button
              Semantics(
                label: 'Save Workout Entry',
                button: true,
                child: ElevatedButton(
                  onPressed: () => _popBack(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(128, 178, 213, 1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _popBack(BuildContext context){
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
