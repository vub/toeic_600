class WordRef {
  final int id;
  final String word;
  final String key;

  WordRef({
    required this.id,
    required this.word,
    required this.key,
  });

  factory WordRef.fromJson(Map<String, dynamic> json) {
    return WordRef(
      id: json['id'],
      word: json['word'],
      key: json['key'],
    );
  }

  /// Creates a WordRef object from a Map.
  factory WordRef.fromMap(Map<String, dynamic> map) {
    return WordRef(
      id: map['id'] as int,
      word: map['word'] as String,
      key: map['key'] as String,
    );
  }
}

class Topic {
  final int id;
  final String topic;
  final String image;
  final List<WordRef> words;

  Topic({
    required this.id,
    required this.topic,
    required this.image,
    required this.words,
  });



  factory Topic.fromJson(Map<String, dynamic> json) {
    var wordsJson = json['words'] as List;
    List<WordRef> wordsList = wordsJson.map((word) => WordRef.fromJson(word)).toList();

    return Topic(
      id: json['id'],
      topic: json['topic'],
      image: json['image'],
      words: wordsList,
    );
  }

  /// Converts a Topic object to a Map (e.g., for storage or serialization).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic': topic,
      'image': image,
      'words': words.map((word) => {
        'id': word.id,
        'word': word.word,
        'key': word.key,
      }).toList(),
    };
  }

  /// Creates a Topic object from a Map, including nested WordRefs.
  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      id: map['id'] as int,
      topic: map['topic'] as String,
      image: map['image'] as String,
      words: (map['words'] as List)
          .map((word) => WordRef.fromMap(Map<String, dynamic>.from(word)))
          .toList(),
    );
  }
}
