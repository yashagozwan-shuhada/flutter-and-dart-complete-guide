class ImageAssetPath {
  ImageAssetPath._();

  static String _path(String image) => 'assets/images/$image.png';

  static final gps = _path('tracking_app');
}
