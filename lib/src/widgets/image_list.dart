import 'package:flutter/material.dart';
import 'package:pics/src/models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;
  final void Function(String) onDelete;

  const ImageList({
    super.key,
    required this.images,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        images[index].author,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
        );
      },
    );
  }
}
