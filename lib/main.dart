import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Image Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageGallery(),
    );
  }
}

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<AssetImage> _images = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final List<String> assetImages = [
      'assets/images/D1.jpg',
      'assets/images/D2.jpg',
      'assets/images/D3.jpg',
      'assets/images/D4.jpg',
      'assets/images/D5.jpg',
      'assets/images/D6.jpg',
      'assets/images/D7.jpg'
    ];

    final List<AssetImage> imageList =
        assetImages.map((path) => AssetImage(path)).toList();

    setState(() {
      _images = imageList;
    });
  }

  void _showPreviousImage() {
    setState(() {
      _currentIndex =
          _currentIndex > 0 ? _currentIndex - 1 : _images.length - 1;
    });
  }

  void _showNextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _images.length;
    });
  }

  void _showRandomImage() {
    final randomIndex = Random().nextInt(_images.length);
    setState(() {
      _currentIndex = randomIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: Center(
        child: _images != null && _images.isNotEmpty
            ? Image(image: _images[_currentIndex])
            : Text('No images found.'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _showPreviousImage,
            heroTag: 'prevBtn',
            tooltip: 'Previous',
            child: Icon(Icons.arrow_back),
          ),
          FloatingActionButton(
            onPressed: _showRandomImage,
            heroTag: 'randBtn',
            tooltip: 'Random',
            child: Icon(Icons.shuffle),
          ),
          FloatingActionButton(
            onPressed: _showNextImage,
            heroTag: 'nextBtn',
            tooltip: 'Next',
            child: Icon(Icons.arrow_forward),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
