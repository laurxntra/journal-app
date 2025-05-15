import 'package:flutter/material.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:journal/views/all_entries_view.dart';
import 'package:isar/isar.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// Global instance of the Isar database
late Isar isar;

/// Main entry point for the workout journal app
Future<void> main() async {
  // Flutter bindings are initalizrd before async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Getting local storage directory and open the Isar database
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open([JournalEntrySchema], directory: dir.path);

  // Initalizing JournalProvider and load existing entries
  final journalProvider = JournalProvider(isar);
  await journalProvider.loadEntries();

  // Launches the app with JournalProvider
  runApp(
    ChangeNotifierProvider(
      create: (_) => journalProvider,
      child: const MainApp(),
    ),
  );
}

// Root widget that defines the app's theme and structure
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      debugShowCheckedModeBanner: false,
      // Contains the app theme and color schemes
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color.fromRGBO(128, 178, 213, 1),
          onPrimary: Colors.white,
          secondary: const Color(0xFF005B96),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: const Color.fromRGBO(224, 239, 249, 1),
          onSurface: Colors.black,
        ),
        useMaterial3: true,

        // Default styling for input fields
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF011f4b)),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          labelStyle: const TextStyle(color: Color.fromRGBO(43, 70, 89, 1)),
        ),
      ),
      // Main screen displaying all journal entries
      home: const AllEntriesView(),
    );
  }
}
