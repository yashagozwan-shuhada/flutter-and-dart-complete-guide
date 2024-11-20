import 'package:flutter/material.dart';
import 'package:pics/src/model/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  const ImageList({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final image = images[index];
        return buildImage(image);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: images.length,
    );
  }

  Widget buildImage(ImageModel image) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      foregroundDecoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Image.network(image.url),
          const SizedBox(height: 8),
          Text(
            image.title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
