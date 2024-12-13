import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart';

int calculate() {
  return 6 * 7;
}

class Converter {
  String? convertImage(FileSystemEntity selectedFile, String format) {
    final file = selectedFile as File;
    final bytes = file.readAsBytesSync();
    final image = decodeImage(bytes);

    Uint8List? newImage;

    if (format == 'jpg' && image != null) {
      newImage = encodeJpg(image);
    } else if (format == 'png' && image != null) {
      newImage = encodePng(image);
    } else {
      print("Unsupported file type");
    }

    if (newImage != null) {
      final newPath = replaceExtension(selectedFile.path, format);
      File(newPath).writeAsBytesSync(newImage);
      return newPath;
    }

    return null;
  }

  String replaceExtension(String path, String newExtention) {
    return path.replaceAll(RegExp(r'(png|jpg|jpeg)'), newExtention);
  }
}
