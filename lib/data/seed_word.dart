import 'package:hive_flutter/hive_flutter.dart';
import 'package:toeic_600/data/load_topic.dart';
import 'package:toeic_600/data/load_word.dart';
import 'package:toeic_600/model/topic.model.dart';
import 'package:toeic_600/model/word.model.dart';

Future<void> seedWord() async {
  await Hive.initFlutter();

  // Open the box for topics
  var box = await Hive.openBox('words');

  // Check if data already exists
  // if (box.isEmpty) {
  //   print('Seeding data...');
  //   List<Word> topics = await loadWordDefinition(word);
  //
  //   for (var topic in topics) {
  //     await box.put(topic.id, topic.toJson());
  //   }
  //   print('Words seeded successfully!');
  // } else {
  //   print('Words already exists in the database.');
  // }
}
