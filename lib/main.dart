import 'package:flutter/material.dart';
import 'package:journal/util/journal_mocker.dart';
import 'package:journal/views/all_entries_view.dart';
import 'package:journal/models/journal.dart';

void main() {
  // ensure that all of the Flutter Widgets are initialized 
  // and have a binding before calling runApp
  WidgetsFlutterBinding.ensureInitialized();

  final mockJournal = makeMockJournal();

  runApp(MainApp(journal: mockJournal));
}

class MainApp extends StatelessWidget {
  final Journal journal;

  const MainApp({super.key, required this.journal});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      debugShowCheckedModeBanner: false, // to not block the + button
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: AllEntriesView(),
    );
  }
}
