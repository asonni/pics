import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pics/src/models/image_model.dart';

class ImageService extends GetxService {
  Future<ImageModel> getImage(int counter) async {
    try {
      final response = await get(
        Uri.parse('https://picsum.photos/id/$counter/info'),
      );
      final jsonData = json.decode(response.body);
      return ImageModel.fromJson(jsonData);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Uint8List> downloadImage(String url) async {
    try {
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
