class Word {
  // final int id;
  final CurrentWord currentWord;
  final List<Sense> senses;
  final Map<String, Comparison> comparisons;
  final List<Video> videos;
  final List<Quote> quotes;

  Word({
    // required this.id,
    required this.currentWord,
    required this.senses,
    required this.comparisons,
    required this.videos,
    required this.quotes,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      // id: int.parse(json['id']),
      currentWord: CurrentWord.fromJson(json['currentWord']), // Default empty instance if null
      senses: (json['senses'] as List?)
          ?.map((i) => Sense.fromJson(i))
          .toList() ?? [], // Default to empty list if null
      comparisons: (json['comparisons'] as Map<String, dynamic>?)
          ?.map((k, v) => MapEntry(k, Comparison.fromJson(v))) ?? {}, // Default to empty map if null
      videos: (json['videos'] as List?)
          ?.map((i) => Video.fromJson(i))
          .toList() ?? [], // Default to empty list if null
      quotes: (json['quotes'] as List?)
          ?.map((i) => Quote.fromJson(i))
          .toList() ?? [], // Default to empty list if null
    );
  }
}

class CurrentWord {
  final String wordRoot;
  final int id;
  final String phonemic;
  final String bigId;
  final List<String> wordForms;

  CurrentWord({
    required this.wordRoot,
    required this.id,
    required this.phonemic,
    required this.bigId,
    required this.wordForms,
  });

  factory CurrentWord.fromJson(Map<String, dynamic> json) {
    return CurrentWord(
      wordRoot: json['wordRoot'],
      id: json['id'],
      phonemic: json['phonemic'],
      bigId: json['bigId'],
      wordForms: List<String>.from(json['wordForms']),
    );
  }
}

class Sense {
  final String id;
  final String de;
  final String ty;
  final String ex;
  final String use;
  final String sy;
  final String op;
  final String re;
  final String tp;
  final List<String> cl;
  final String imageSrc;
  final List<Tip> tips;

  Sense({
    required this.id,
    required this.de,
    required this.ty,
    required this.ex,
    required this.use,
    required this.sy,
    required this.op,
    required this.re,
    required this.tp,
    required this.cl,
    required this.imageSrc,
    required this.tips,
  });

  factory Sense.fromJson(Map<String, dynamic> json) {
    return Sense(
      id: json['id'],
      de: json['de'],
      ty: json['ty'],
      ex: json['ex'],
      use: json['use'],
      sy: json['sy'],
      op: json['op'],
      re: json['re'],
      tp: json['tp'],
      cl: List<String>.from(json['cl']),
      imageSrc: json['ImageSrc'],
      tips: (json['Tips'] as List).map((i) => Tip.fromJson(i)).toList(),
    );
  }
}

class Tip {
  final String title;
  final String description;
  final String example;
  final String imageUrl;

  Tip({
    required this.title,
    required this.description,
    required this.example,
    required this.imageUrl,
  });

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      title: json['title'],
      description: json['description'],
      example: json['example'],
      imageUrl: json['imageUrl'],
    );
  }
}

class Comparison {
  final String wordRoot;
  final String wordDefinition;
  final String wordImage;

  Comparison({
    required this.wordRoot,
    required this.wordDefinition,
    required this.wordImage,
  });

  factory Comparison.fromJson(Map<String, dynamic> json) {
    return Comparison(
      wordRoot: json['wordRoot'],
      wordDefinition: json['wordDefinition'],
      wordImage: json['wordImage'],
    );
  }
}

class Video {
  final String text;
  final String title;
  final String videoId;
  final String controls;

  Video({
    required this.text,
    required this.title,
    required this.videoId,
    required this.controls,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      text: json['Text'],
      title: json['Title'],
      videoId: json['VideoId'],
      controls: json['Controls'],
    );
  }
}

class Quote {
  final String imageSrc;
  final String text;
  final String title;
  final String name;

  Quote({
    required this.imageSrc,
    required this.text,
    required this.title,
    required this.name,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      imageSrc: json['ImageSrc'],
      text: json['Text'],
      title: json['Title'],
      name: json['Name'],
    );
  }
}
