import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:toeic_600/model/topic.model.dart';

Future<List<Topic>> loadTopics() async {
  final jsonString = await rootBundle.loadString('assets/topic.json');
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((data) => Topic.fromJson(data)).toList();
}
