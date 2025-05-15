import 'package:flutter/material.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:journal/views/all_entries_view.dart';
import 'package:isar/isar.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

late Isar isar;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open([JournalEntrySchema], directory: dir.path);

  // Create the provider using only Isar
  final journalProvider = JournalProvider(isar);
  await journalProvider.loadEntries();

  runApp(
    ChangeNotifierProvider(
      create: (_) => journalProvider, // reuse the loaded provider
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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF011f4b)),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          labelStyle: const TextStyle(color: Color.fromRGBO(43, 70, 89, 1)),
        ),
      ),
      home: const AllEntriesView(),
      builder: (context, child) {
        return Semantics(
          label: 'Workout Journal',
          excludeSemantics: true,
          child: child!,
        );
      },
    );
  }
}
