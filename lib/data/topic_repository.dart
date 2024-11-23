import 'package:hive_flutter/hive_flutter.dart';
import 'package:toeic_600/model/topic.model.dart';

class TopicsRepository {
  static const String boxName = 'topics';

  Future<void> initialize() async {
    // Ensure Hive is initialized
    await Hive.initFlutter();

    // Open the topics box
    await Hive.openBox(boxName);
  }

  Future<List<Topic>> getAll() async {
    var box = Hive.box(boxName);
    List<Topic> topics = box.values.map((e) {
      return Topic.fromMap(Map<String, dynamic>.from(e));
    }).toList();
    return topics;
  }

  Future<Map<int, dynamic>?> getOneById(int id) async {
    var box = Hive.box(boxName);
    return box.get(id);
  }

  Future<void> saveTopics(List<Map<int, dynamic>> topics) async {
    var box = Hive.box(boxName);
    for (var topic in topics) {
      await box.put(topic['id'], topic);
    }
  }
}
