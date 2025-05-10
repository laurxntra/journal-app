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
  late int currentSets;
  late int currentReps;
  late int currentWeight;
  late int currentDura;
  late String currentTitle;

  @override
  void initState() {
    super.initState();
    currentText = widget.entry.workoutName;
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
              TextFormField(
                initialValue: currentTitle,
                onChanged: (newTitle) => setState(() => currentTitle = newTitle),
                decoration: const InputDecoration(labelText: 'Workout Title'),
              ),
              const SizedBox(height: 16,),

              // Workout name text field
              TextFormField(
                initialValue: currentText,
                onChanged: (newText) => setState(() => currentText = newText),
                decoration: const InputDecoration(labelText: 'Workout Name'),
              ),
              const SizedBox(height: 16,),
            
              // Number of sets field
              TextFormField(
                initialValue: currentSets.toString(),
                keyboardType: TextInputType.number,
                onChanged: (newSet) => setState(() => currentSets = int.tryParse(newSet) ?? currentSets),
                decoration: const InputDecoration(labelText: 'Amount of sets'),
              ),
              const SizedBox(height: 16,),
            
              // Number of reps field
              TextFormField(
                initialValue: currentReps.toString(),
                keyboardType: TextInputType.number,
                onChanged: (newRep) => setState(() => currentReps = int.tryParse(newRep) ?? currentReps),
                decoration: const InputDecoration(labelText: 'Amount of repetitions'),
              ),
              const SizedBox(height: 16,),
            
              // Amount of weight
              TextFormField(
                initialValue: currentWeight.toString(),
                keyboardType: TextInputType.number,
                onChanged: (newWeight) => setState(() => currentWeight = int.tryParse(newWeight) ?? currentWeight),
                decoration: const InputDecoration(labelText: 'Amount of weight'),
              ),
              const SizedBox(height: 16,),

              // Duration of workout
              TextFormField(
                initialValue: currentDura.toString(),
                keyboardType: TextInputType.number,
                onChanged: (newDura) => setState(() => currentDura = int.tryParse(newDura) ?? currentDura),
                decoration: const InputDecoration(labelText: 'Duration of workout'),
              ),
              const SizedBox(height: 16,),
            
              ElevatedButton(
                onPressed: () => _popBack(context),
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }


  void _popBack(BuildContext context){
    final updatedEntry = JournalEntry(
      workoutName: currentText,
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

