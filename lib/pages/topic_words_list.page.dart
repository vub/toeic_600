import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';

import 'package:toeic_600/model/topic.model.dart';
import 'package:toeic_600/model/word.model.dart';
import 'package:toeic_600/data/load_word.dart';
import 'package:toeic_600/widgets/load_image.widget.dart';
import 'package:toeic_600/pages/word_detail.page.dart';

class WordListByTopicPage extends StatefulWidget {
  final Topic item;

  const WordListByTopicPage({Key? key, required this.item}) : super(key: key);

  @override
  _WordListByTopicPageState createState() => _WordListByTopicPageState();
}

class _WordListByTopicPageState extends State<WordListByTopicPage> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  Future<Word> _loadWordDefinition(String word) async {
    return await loadWordDefinition(word);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.topic),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.item.words.length,
          itemBuilder: (context, index) {
            String word = widget.item.words[index].key;
            return FutureBuilder<Word>(
              future: _loadWordDefinition(word),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Card(
                      child: ListTile(
                        title: Text("Loading..."),
                      ),
                    ),
                  );
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  print(snapshot.error.toString());
                  print(snapshot.stackTrace.toString());
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Card(
                      child: ListTile(
                        title: Text("Error loading word"),
                      ),
                    ),
                  );
                }

                final wordDefinition = snapshot.data!;
                final firstSense = wordDefinition.senses.isNotEmpty
                    ? wordDefinition.senses.first
                    : null;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      leading: firstSense?.imageSrc != null &&
                          firstSense!.imageSrc.isNotEmpty
                          ? LoadImageWidget(
                        url: firstSense.imageSrc,
                      )
                          : const SizedBox(width: 50, height: 50),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            wordDefinition.currentWord.wordRoot,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // IconButton(
                          //   icon: const Icon(Icons.volume_up),
                          //   onPressed: () => _speak(wordDefinition.wordRoot),
                          // ),
                        ],
                      ),
                      // subtitle: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     if (wordDefinition.phonemic.isNotEmpty)
                      //       Text("Phonemic: ${wordDefinition.phonemic}"),
                      //     if (firstSense != null)
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text("Type: ${firstSense.type}"),
                      //           Text("Definition: ${firstSense.definition}"),
                      //           if (firstSense.example.isNotEmpty)
                      //             Text("Example: ${firstSense.example}"),
                      //         ],
                      //       ),
                      //   ],
                      // ),
                      onTap: () async {
                        Word wordDefinition =
                        await loadWordDefinition(word);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WordDetailPage(wordDefinition: wordDefinition),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
