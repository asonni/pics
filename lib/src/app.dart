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
  final List<ImageModel> images = [];

  void buildImage() async {
    counter++;
    var response = await get(
      Uri.parse('https://picsum.photos/id/$counter/info'),
    );
    var jsonData = json.decode(response.body);
    var image = ImageModel.fromJson(jsonData);

    setState(() {
      images.add(image);
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
      body: ImageList(images),
      floatingActionButton: FloatingActionButton(
        onPressed: buildImage,
        child: Icon(Icons.add, size: 35),
      ),
    );
  }
}
