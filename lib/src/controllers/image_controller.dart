import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pics/src/models/image_model.dart';
import 'package:pics/src/services/image_service.dart';
import 'package:pics/src/utils/app_snackbars.dart';
import 'package:saver_gallery/saver_gallery.dart';

class ImageController extends GetxController {
  int _counter = 0;
  final RxBool isLoading = false.obs;
  final RxBool isRefreshing = false.obs;
  final RxBool isDownloading = false.obs;
  final RxInt selectedIndex = (-1).obs;
  final RxList<ImageModel> images = <ImageModel>[].obs;
  final ImageService _imageService = Get.put(ImageService());

  @override
  void onInit() {
    _requestPermission();
    super.onInit();
  }

  void buildImage() async {
    isLoading.value = true;
    _counter++;
    try {
      final image = await _imageService.getImage(_counter);
      images.add(image);
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Error',
        message: 'Field to load image: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void deleteImage(String id) {
    images.removeWhere((image) => image.id == id);
  }

  void onRefreshImage(int index) async {
    try {
      final int randomNum = _randomNumber();

      isRefreshing.value = true;
      selectedIndex.value = index;

      final refreshImage = await _imageService.getImage(randomNum);

      images[index] = refreshImage;

      AppSnackbars.successSnackbar(
        title: 'Success',
        message: 'Image refreshed successfully',
      );
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Error',
        message: 'Field to refresh image: $e',
      );
    } finally {
      isRefreshing.value = false;
      selectedIndex.value = -1;
    }
  }

  int _randomNumber() {
    final Random random = Random();
    return random.nextInt(100);
  }

  Future<void> downloadImage(int index) async {
    try {
      isDownloading.value = true;
      selectedIndex.value = index;
      final imageUrl = images[index].downloadUrl;
      final Uint8List imageData = await _imageService.downloadImage(imageUrl);
      final imageName = 'image_${_randomNumber()}';

      final result = await SaverGallery.saveImage(
        Uint8List.fromList(imageData),
        quality: 60,
        fileName: imageName,
        androidRelativePath: "Pictures/NetworkImages",
        skipIfExists: false,
      );

      if (result.isSuccess) {
        AppSnackbars.successSnackbar(
          title: 'Success',
          message: 'Image downloaded successfully',
        );
      } else {
        AppSnackbars.errorSnackbar(
          title: 'Error',
          message: 'Failed to save image to gallery',
        );
      }
    } catch (e) {
      AppSnackbars.errorSnackbar(
        title: 'Error',
        message: 'Failed to download image: $e',
      );
    } finally {
      isDownloading.value = false;
      selectedIndex.value = -1;
    }
  }

  Future<void> _requestPermission() async {
    bool statuses;
    if (Platform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;
      statuses = sdkInt < 29
          ? await Permission.storage.request().isGranted
          : true;
    } else {
      statuses = await Permission.photosAddOnly.request().isGranted;
    }
    print(statuses);
  }
}
