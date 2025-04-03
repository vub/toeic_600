import 'package:hive_flutter/hive_flutter.dart';
import 'package:toeic_600/model/topic.model.dart';
import 'package:toeic_600/model/word.model.dart';

class WordsRepository {
  static const String boxName = 'words';

  Future<void> initialize() async {
    // Ensure Hive is initialized
    await Hive.initFlutter();

    // Open the topics box
    await Hive.openBox(boxName);
  }

  Future<List<Word>> getAll() async {
    var box = Hive.box(boxName);
    List<Word> words = box.values.map((e) {
      return Word.fromJson(Map<String, dynamic>.from(e));
    }).toList();
    return words;
  }

  Future<Map<int, dynamic>?> getOneById(int id) async {
    var box = Hive.box(boxName);
    return box.get(id);
  }

  Future<void> saveWords(List<Map<int, dynamic>> words) async {
    var box = Hive.box(boxName);
    for (var word in words) {
      await box.put(word['id'], word);
    }
  }
}
