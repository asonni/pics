import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

import 'package:pics/src/models/image_model.dart';
import 'package:pics/src/widgets/image_list.dart';
import 'package:pics/src/widgets/loading_indicator.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 0;
  bool isLoading = false;
  bool isRefreshing = false;
  int selectedIndex = -1;
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

  void onRefreshImage(int index) async {
    try {
      final int randomNum = randomNumber();

      setState(() {
        isRefreshing = true;
        selectedIndex = index;
      });

      var response = await get(
        Uri.parse('https://picsum.photos/id/$randomNum/info'),
      );
      var jsonData = json.decode(response.body);
      var refreshImage = ImageModel.fromJson(jsonData);
      setState(() {
        images[index] = refreshImage;
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isRefreshing = false;
        selectedIndex = -1;
      });
    }
  }

  int randomNumber() {
    final Random random = Random();
    return random.nextInt(100);
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
          : ImageList(
              images: images,
              onDelete: deleteImage,
              onRefresh: onRefreshImage,
              isRefreshing: isRefreshing,
              selectedIndex: selectedIndex,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : buildImage,
        child: isLoading
            ? LoadingIndicator(
                color: Colors.black,
                strokeWidth: 3,
              )
            : Icon(Icons.add, size: 35),
      ),
    );
  }
}
