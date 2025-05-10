import 'package:flutter/material.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:journal/views/all_entries_view.dart';
import 'package:journal/models/journal.dart';
import 'package:provider/provider.dart';

void main() {
  // ensure that all of the Flutter Widgets are initialized 
  // and have a binding before calling runApp
  WidgetsFlutterBinding.ensureInitialized();

  final journal = Journal(entries: []);


  runApp(
    ChangeNotifierProvider(
      create: (_) => JournalProvider(journal),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: AllEntriesView(),
    );
  }
}

