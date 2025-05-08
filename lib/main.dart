import 'package:flutter/material.dart';
import 'package:journal/views/all_entries_view.dart';

void main() {
  // TODO(required): Need to ensure that all of the Flutter Widgets are initialized
  // and have a binding before calling runApp

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
      home: const AllEntriesView(),
    );
  }
}
