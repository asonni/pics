import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

import 'package:pics/src/models/image_model.dart';
import 'package:pics/src/widgets/image_list.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 0;
  bool isLoading = false;
  final List<ImageModel> images = [];

  void buildImage() async {
    counter++;

    setState(() {
      isLoading = true;
    });

    var response = await get(
      Uri.parse('https://picsum.photos/id/$counter/info'),
    );
    var jsonData = json.decode(response.body);
    var image = ImageModel.fromJson(jsonData);

    setState(() {
      images.add(image);
      isLoading = false;
    });
  }

  void deleteImage(String id) {
    setState(() {
      images.removeWhere((image) => image.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lets build image'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: images.isEmpty
          ? Center(
              child: Text(
                'No images found',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          : ImageList(images: images, onDelete: deleteImage),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : buildImage,
        child: isLoading
            ? SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(),
              )
            : Icon(Icons.add, size: 35),
      ),
    );
  }
}
