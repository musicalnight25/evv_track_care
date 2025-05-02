import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/image_constants.dart';
import '../../network/network_service.dart';


class CustomImage extends StatelessWidget {
  final String url;
  final Uint8List? imageData;
  final double borderRadius;
  final double? height;
  final BoxFit? fit;
  final double? width;
  final Color? color;
  final double? size;
  final BoxShape? shape;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final ImageProvider placeHolderImage;

  const CustomImage({
    super.key,
    required this.url,
    this.imageData,
    this.height,
    this.color,
    this.fit,
    this.shape,
    this.size,
    this.width,
    this.borderRadius = 10,
    this.placeHolderImage = const AssetImage(AppImages.loading_shimmer),
    this.border,
    this.boxShadow,
  }) : assert(
            size == null || (height == null && width == null),
            "\n\nIf you give size, it will apply as height and width\n"
            "Consider give height and width or size.\n");

  @override
  Widget build(BuildContext context) {
    return context.read<NetworkStatus>() == NetworkStatus.offline
        ? imageData != null
            ? buildContainer(MemoryImage(imageData!), fit ?? BoxFit.cover, color)
            : buildContainer(const AssetImage(AppImages.image_placeholder), BoxFit.fill, Colors.grey.shade100)
        : CachedNetworkImage(
      imageUrl: url,
            errorWidget: (context, url, error) => buildContainer(const AssetImage(AppImages.avatar), BoxFit.fill, Colors.grey.shade100, border, boxShadow),
            placeholder: (context, url) => buildContainer(placeHolderImage, BoxFit.cover, Colors.grey.shade100, border, boxShadow),
            imageBuilder: (context, image) => buildContainer(image, fit ?? BoxFit.cover, color, border, boxShadow),
          );
  }

  Container buildContainer(ImageProvider<Object> image, BoxFit fit, Color? color, [BoxBorder? border, List<BoxShadow>? boxShadow]) {
    return Container(
      height: size ?? height,
      width: size ?? width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: shape != null ? null : BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: boxShadow,
        shape: shape ?? BoxShape.rectangle,
        image: DecorationImage(
          fit: fit,
          image: image,
        ),
      ),
    );
  }
}
