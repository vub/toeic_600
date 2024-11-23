import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadImageWidget extends StatefulWidget {
  final String url;

  LoadImageWidget({required this.url});

  @override
  _LoadImageWidgetState createState() => _LoadImageWidgetState();
}

class _LoadImageWidgetState extends State<LoadImageWidget> {
  late String assetPath;
  bool? assetExists;

  @override
  void initState() {
    super.initState();
    assetPath = getAssetPathFromUrl(widget.url);
    _checkAssetExists();
  }

  // Method to get asset path from URL
  String getAssetPathFromUrl(String url) {
    final path = url.split('senses/').last;
    return 'assets/senses/$path';
  }

  // Method to check if the asset exists
  Future<void> _checkAssetExists() async {
    try {
      await rootBundle.load(assetPath);
      setState(() {
        assetExists = true;
      });
    } catch (e) {
      setState(() {
        assetExists = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (assetExists == null) {
      return const CircularProgressIndicator(color: Colors.grey, strokeWidth: 4.0); // Show loading spinner while checking
    }
    if (assetExists == true) {
      return Image.asset(assetPath, fit: BoxFit.cover); // Load the image from assets if it exists
    } else {
      return const Icon(Icons.broken_image); // Show an icon if the image is not found
    }
  }
}
