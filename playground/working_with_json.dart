import 'dart:convert';

void main() {
  final rawJson = '{"image": "http://google.com/google.jpg", "id": 1}';
  final parsedJson = json.decode(rawJson);
  final imageModel = ImageModel.fromJson(parsedJson);

  print(imageModel.id);
  print(imageModel.image);
}

class ImageModel {
  int id;
  String image;

  ImageModel(this.id, this.image);

  // redirecting constructor
  ImageModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'];
}
