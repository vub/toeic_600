import 'package:flutter/material.dart';
import 'package:toeic_600/data/topic_repository.dart';
import 'package:toeic_600/model/topic.model.dart';
import 'package:toeic_600/pages/topic_words_list.page.dart';

class TopicList extends StatefulWidget {
  const TopicList({Key? key}) : super(key: key);

  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  late Future<List<Topic>> topicsFuture;
  final TopicsRepository repository = TopicsRepository();

  @override
  void initState() {
    super.initState();
    // Initialize topicsFuture using TopicsRepository
    topicsFuture = loadTopicsFromRepository();
  }

  Future<List<Topic>> loadTopicsFromRepository() async {
    await repository.initialize(); // Ensure repository is ready
    final topicsData = await repository.getAll();
    return topicsData;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Topic>>(
        future: topicsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No topics available'));
          }

          final topics = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.9,
            ),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WordListByTopicPage(item: topic),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/topics/${topic.image}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            '${index + 1}. ${topic.topic}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
