enum KAssetName { oil, closeBottom }

extension AssetsExtention on KAssetName {
  String get imagePath {
    String rootPath = 'assets';
    String svgDir = '$rootPath/svg';
    String imageDir = '$rootPath/images';

    switch (this) {
      case KAssetName.oil:
        return '$imageDir/oil.png';
      case KAssetName.closeBottom:
        return '$svgDir/close_bottom.svg';
    }
  }
}

