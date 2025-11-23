class ImageModel {
  final String id;
  final String author;
  final String downloadUrl;

  ImageModel({
    required this.id,
    required this.author,
    required this.downloadUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    return ImageModel(
      id: parsedJson['id'],
      author: parsedJson['author'],
      downloadUrl: parsedJson['download_url'],
    );
  }
}
