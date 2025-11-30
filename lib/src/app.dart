import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/src/widgets/image_list.dart';
import '/src/widgets/loading_indicator.dart';
import '/src/controllers/image_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.put(ImageController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Lets build image'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        return imageController.images.isEmpty
            ? Center(
                child: Text(
                  'No images found',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            : ImageList(
                images: imageController.images,
                onDelete: imageController.deleteImage,
                onRefresh: imageController.onRefreshImage,
                isRefreshing: imageController.isRefreshing.value,
                selectedIndex: imageController.selectedIndex.value,
              );
      }),
      floatingActionButton: Obx(() {
        return FloatingActionButton(
          onPressed: imageController.isLoading.value
              ? null
              : imageController.buildImage,
          child: imageController.isLoading.value
              ? LoadingIndicator(
                  color: Colors.black,
                  strokeWidth: 3,
                )
              : Icon(Icons.add, size: 35),
        );
      }),
    );
  }
}
