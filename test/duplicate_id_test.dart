// import 'package:flutter_test/flutter_test.dart';
// import 'package:isar/isar.dart';
// import 'package:journal/models/journal_entry.dart';
// import 'package:journal/providers/journal_provider.dart';

// /// This test file is used to test the functionality of the JournalProvider class
// /// and the JournalEntry class using Isar
// /// Feel free to ignore errors here while completing part 1
// /// These tests may be helpful for you to debug your code in part 2

// Future<Isar> getIsar() async {
//   await Isar.initializeIsarCore(
//     download: true,
//   );
//   final dir = '';
//   return Isar.open(
//     [JournalEntrySchema],
//     directory: dir,
//   );
// }

// void main() async {
//   final isar = await getIsar();
//   final JournalProvider journalProvider = JournalProvider(isar);

//   test('Can create and save a journal entry', () async {
//     final entry = JournalEntry.fromText(
//       text: 'The work is mysterious and important.',
//     );
//     journalProvider.upsertJournalEntry(entry);

//     // wait for the entry to be saved
//     await Future.delayed(
//       const Duration(
//         milliseconds: 1000,
//       ),
//     );

//     // Retrieve the entry from the database
//     final retrievedEntries = isar.journalEntrys.where().findAllSync();
//     assert(retrievedEntries.length == 1);
//     assert(entry.text == retrievedEntries[0].text);
//   });

//   test('Replacing Entry doesnt change ID', () async {
//     // Create a new entry and save it
//     final entry = JournalEntry.fromText(
//       text: 'I feel nothing',
//     );
//     journalProvider.upsertJournalEntry(entry);

//     // wait for the entry to be saved
//     await Future.delayed(
//       const Duration(
//         milliseconds: 1000,
//       ),
//     );

//     // Update the entry's text and save it again
//     final updatedEntry =
//         JournalEntry.withUpdatedText(entry, 'I feel something');

//     journalProvider.upsertJournalEntry(updatedEntry);

//     // wait for the entry to be saved
//     await Future.delayed(
//       const Duration(
//         milliseconds: 1000,
//       ),
//     );

//     // Retrieve the entry from the database and check if the ID is the same
//     final retrievedEntry = await isar.journalEntrys.get(entry.id!);
//     assert(entry.id == retrievedEntry!.id);
//     assert(entry.text != retrievedEntry!.text);
//   });

//   test('Creating multiple entries correctly increments ID', () async {
//     // Create a new entry and save it
//     final entry = JournalEntry.fromText(
//       text: 'Welcome to the Music Dance Experience',
//     );
//     journalProvider.upsertJournalEntry(entry);

//     // wait for the entry to be saved
//     await Future.delayed(
//       const Duration(
//         milliseconds: 1000,
//       ),
//     );

//     // Create another entry and save it
//     final entry2 = JournalEntry.fromText(
//       text: 'The Music Dance Experience is officially cancelled',
//     );
//     journalProvider.upsertJournalEntry(entry2);

//     // wait for the entry to be saved
//     await Future.delayed(
//       const Duration(
//         milliseconds: 1000,
//       ),
//     );

//     // Retrieve the entries from the database and check if the IDs are different
//     final retrievedEntry1 = await isar.journalEntrys.get(entry.id!);
//     final retrievedEntry2 = await isar.journalEntrys.get(entry2.id!);

//     assert(retrievedEntry1!.id != retrievedEntry2!.id);
//   });

//   await isar.writeTxn(() async {
//     await isar.clear();
//   });
// }
