import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_shimmer_effect.dart';

class AppImageAsset extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final bool isFile;

  const AppImageAsset({
    Key? key,
    @required this.image,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image!.contains('http')
        ? CachedNetworkImage(
            imageUrl: '$image',
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            placeholder: (context, url) => AppShimmerEffectView(
              height: height ?? double.maxFinite,
              width: width ?? double.maxFinite,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
          )
        : isFile
            ? Image.file(File(image!), fit: fit, height: height, width: width, color: color)
            : image!.isEmpty || image!.split('.').last != 'svg'
                ? Image.asset(image!, fit: fit, height: height, width: width, color: color)
                : SvgPicture.asset(image!, height: height, width: width, color: color);
  }
}
