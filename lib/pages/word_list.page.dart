import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:toeic_600/model/topic.model.dart';
import 'package:toeic_600/model/word.model.dart';
import 'package:toeic_600/data/load_word.dart';
import 'package:toeic_600/data/load_topic.dart';
import 'package:toeic_600/pages/word_detail.page.dart';

class WordList extends StatefulWidget {
  const WordList({Key? key}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  late Future<List<Topic>> topicsFuture;

  @override
  void initState() {
    super.initState();
    topicsFuture = loadTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: FutureBuilder<List<Topic>>(
        future: topicsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No words available'));
          }

          final words = snapshot.data!.expand((topic) => topic.words).toList();
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              mainAxisExtent: 48,
            ),
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              return InkWell(
                onTap: () async {
                  Word wordDefinition = await loadWordDefinition(word.key);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WordDetailPage(wordDefinition: wordDefinition),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  margin: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(word.word,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class WordListPage extends StatefulWidget {
  const WordListPage({Key? key}) : super(key: key);

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          controller: _tabController,
          // isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'To Learn'),
            Tab(text: 'Learning'),
            Tab(text: 'Known'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Content for To Learn tab
          WordList(),
          Center(child: Text('To Learn Content')),
          // Content for Learning tab
          Center(child: Text('Learning Content')),
          // Content for Known tab
          Center(child: Text('Known Content')),
        ],
      ),
    );
  }
}