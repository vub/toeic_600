import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toeic_600/model/word.model.dart';
import 'package:toeic_600/widgets/load_image.widget.dart';

class WordDetailPage extends StatefulWidget {
  final Word wordDefinition;

  const WordDetailPage({Key? key, required this.wordDefinition})
      : super(key: key);

  @override
  _WordDetailPageState createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  late FlutterTts _flutterTts;
  late PageController _pageController;
  double maxHeight = 0;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _pageController = PageController(viewportFraction: 0.9, keepPage: true);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _speakPhonemic(String text) async {
    await _flutterTts.setVoice({"name": "en-us-x-sfg"});
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wordDefinition.currentWord.wordRoot),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.wordDefinition.currentWord.wordRoot,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue)),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          '/${widget.wordDefinition.currentWord.phonemic.split('|').first}/',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.blueAccent),
                        ),
                        IconButton(
                          icon: const Icon(Icons.volume_up),
                          onPressed: () => _speakPhonemic(
                              widget.wordDefinition.currentWord.wordRoot),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.wordDefinition.senses.length,
                        effect: WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.blue,
                          dotColor: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 500, // Set a fixed height for the carousel
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.wordDefinition.senses.length,
                        itemBuilder: (context, index) {
                          final sense = widget.wordDefinition.senses[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 10),
                            child: Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sense.ty,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.green),
                                        ),
                                        Text(sense.de,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 8),
                                        Text(
                                          sense.ex,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (sense.imageSrc.isNotEmpty)
                                    Flexible(
                                      flex: 1,
                                      child:
                                          LoadImageWidget(url: sense.imageSrc),
                                    )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // Distribute buttons evenly
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      // To avoid column taking full height
                      children: [
                        IconButton(
                          onPressed: () {
                            // Your button action here
                          },
                          icon: const Icon(Icons.arrow_back_outlined),
                        ),
                        const Text('Back', style: TextStyle(fontSize: 12)),
                        // Description text
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Your button action here
                          },
                          icon: const Icon(Icons
                              .book), // You might want a more relevant icon
                        ),
                        const Text('Should Learn',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Your button action here
                          },
                          icon: const Icon(Icons
                              .check_circle), // You might want a more relevant icon
                        ),
                        const Text('Already Knew',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Your button action here
                          },
                          icon: const Icon(Icons.arrow_forward_outlined),
                        ),
                        const Text('Next', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
