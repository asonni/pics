import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pics/src/controllers/image_controller.dart';
import 'package:pics/src/models/image_model.dart';
import 'package:pics/src/widgets/loading_indicator.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;
  final void Function(String) onDelete;
  final void Function(int) onRefresh;
  final bool isRefreshing;
  final int selectedIndex;

  const ImageList({
    super.key,
    required this.images,
    required this.onDelete,
    required this.onRefresh,
    this.isRefreshing = false,
    this.selectedIndex = -1,
  });

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.find();
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    images[index].downloadUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return Container(
                        alignment: Alignment.center,
                        color: Colors.black12,
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            onRefresh(index);
                          },
                          icon: isRefreshing && index == selectedIndex
                              ? LoadingIndicator(
                                  color: Colors.greenAccent,
                                  width: 15,
                                  height: 15,
                                  strokeWidth: 2.5,
                                )
                              : Icon(Icons.refresh, color: Colors.greenAccent),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withValues(alpha: 0.5),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  images[index].author,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Obx(() {
                                  final bool isDownloading =
                                      imageController.isDownloading.value;
                                  final int selectedIndex =
                                      imageController.selectedIndex.value;
                                  return IconButton(
                                    onPressed: () {
                                      if (isDownloading &&
                                          selectedIndex == index) {
                                        return;
                                      }
                                      imageController.downloadImage(index);
                                    },
                                    icon:
                                        isDownloading && selectedIndex == index
                                        ? LoadingIndicator(
                                            width: 15,
                                            height: 15,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.download,
                                            color: Colors.white,
                                          ),
                                  );
                                }),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                final imageId = images[index].id;
                                onDelete(imageId);
                              },
                              // onPressed: () => onDelete(index),
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
