 
 import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/core/presentation/widgets/global_loader.dart';

enum ImageFor { asset, network }

/// A unified image loader that can handle both regular images and SVGs
/// based on the file extension. Default to asset loading.
class GlobalImageLoader extends StatelessWidget {
  const GlobalImageLoader({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit,
    this.color,
    this.imageFor = ImageFor.asset,
  });

  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final ImageFor? imageFor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // Check if the image is an SVG based on file extension
    final bool isSvg = imagePath.toLowerCase().endsWith('.svg');

    // Handle network images
    if (imageFor == ImageFor.network) {
      if (isSvg) {
        return SvgPicture.network(
          imagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
          placeholderBuilder: (BuildContext context) => GlobalLoader(text: ''),
        );
      } else {
        return Image.network(
          imagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          errorBuilder: (context, exception, stackTrace) => const Text('😢'),
        );
      }
    }
    // Handle asset images (default)
    else {
      if (isSvg) {
        return SvgPicture.asset(
          imagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
        );
      } else {
        return Image.asset(
          imagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          errorBuilder: (context, exception, stackTrace) => const Text('😢'),
        );
      }
    }
  }
} 
 