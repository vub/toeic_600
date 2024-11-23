import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:toeic_600/model/word.model.dart';

Future<Word> loadWordDefinition(String word) async {
  final String response =
  await rootBundle.loadString('assets/words/$word.json');
  final data = await json.decode(response);
  return Word.fromJson(data);
}
