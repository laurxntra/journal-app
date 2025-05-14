import 'package:flutter/material.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:journal/views/all_entries_view.dart';
import 'package:journal/models/journal.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:journal/models/journal_entry.dart';

late Isar isar;

Future<void> main() async {
  // ensure that all of the Flutter Widgets are initialized 
  // and have a binding before calling runApp
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  isar = await Isar.open([JournalEntrySchema], directory: dir.path);

  final journal = Journal(isar: isar);


  runApp(
    ChangeNotifierProvider(
      create: (_) => JournalProvider(journal, isar),
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
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(128, 178, 213, 1),
          onPrimary: Colors.white,
          secondary: Color(0xFF005B96),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Color.fromRGBO(224, 239, 249, 1),
          onSurface: Colors.black
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF011f4b)), // Dark blue border
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          labelStyle: const TextStyle(color: Color.fromRGBO(43, 70, 89, 1)), // Label color
        ),
      ),
      home: AllEntriesView(),
    );
  }
}

