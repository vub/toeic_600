import 'package:hive_flutter/hive_flutter.dart';
import 'package:toeic_600/data/load_topic.dart';
import 'package:toeic_600/model/topic.model.dart';

Future<void> seedData() async {
  await Hive.initFlutter();

  // Open the box for topics
  var box = await Hive.openBox('topics');

  // Check if data already exists
  if (box.isEmpty) {
    print('Seeding data...');
    List<Topic> topics = await loadTopics();

    for (var topic in topics) {
      await box.put(topic.id, topic.toJson());
    }
    print('Topics seeded successfully!');
  } else {
    print('Topics already exists in the database.');
  }
}
