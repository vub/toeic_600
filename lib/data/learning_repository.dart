import 'package:hive/hive.dart';
import 'package:toeic_600/model/learning_status.model.dart';

/// Repository to manage learning statuses
class LearningRepository {
  static const String boxName = 'learning';

  /// Initialize the Hive box
  static Future<void> initBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<int>(boxName); // Box stores int values (LearningStatus index)
    }
  }

  /// Find status by word ID
  Future<LearningStatus?> findStatusByWordId(int wordId) async {
    final box = Hive.box<int>(boxName);
    final record = box.get(wordId);
    return record != null ? LearningStatus.values[record] : null;
  }

  /// Find statuses by a list of word IDs
  Future<Map<int, LearningStatus>> findStatusesByWordIdList(List<int> wordIds) async {
    final box = Hive.box<int>(boxName);
    final result = <int, LearningStatus>{};

    for (final id in wordIds) {
      final record = box.get(id);
      if (record != null) {
        result[id] = LearningStatus.values[record];
      }
    }
    return result;
  }

  /// Update word status by ID
  Future<void> updateWordStatusById(int wordId, LearningStatus status) async {
    final box = Hive.box<int>(boxName);
    await box.put(wordId, status.index);
  }

/// Count all words by LearningStatus
///
}
// How to use
// void main() async {
//   await LearningRepository.initBox();
//
//   final repository = LearningRepository();
//
//   // Update a word's status
//   await repository.updateWordStatusById(1, LearningStatus.shouldLearn);
//
//   // Find status by word ID
//   final status = await repository.findStatusByWordId(1);
//   print(status); // Output: LearningStatus.shouldLearn
//
//   // Find statuses for a list of word IDs
//   final statuses = await repository.findStatusesByWordIdList([1, 2, 3]);
//   print(statuses); // Output: {1: LearningStatus.shouldLearn}
// }
