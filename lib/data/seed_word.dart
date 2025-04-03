import 'package:hive_flutter/hive_flutter.dart';
import 'package:toeic_600/data/load_topic.dart';
import 'package:toeic_600/data/load_word.dart';
import 'package:toeic_600/data/topic_repository.dart';
import 'package:toeic_600/model/topic.model.dart';
import 'package:toeic_600/model/word.model.dart';

Future<void> seedWord() async {
  await Hive.initFlutter();

  // Open the box for topics
  var box = await Hive.openBox('words');

  // Check if data already exists
  if (box.isEmpty) {
    print('Seeding data...');
    final TopicsRepository repository = TopicsRepository();
    await repository.initialize(); // Ensure repository is ready
    final topicsData = await repository.getAll();
    for (var topic in topicsData) {
      for (var word in topic.words) {
        var wordJson = await loadWordJson(word.key);
        await box.put(word.id, wordJson);
      }
    }
  } else {
    print('Words already exists in the database.');
  }
}
