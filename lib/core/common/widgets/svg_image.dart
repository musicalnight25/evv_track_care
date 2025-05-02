import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthcare/core/utils/size_config.dart';


import '../../constants/color_constants.dart';
import '../../constants/image_constants.dart';

class SvgImage extends StatelessWidget {
  final SvgIcons imgPath;
  final Color? color;
  final double size;
  final BoxFit? fit;
  const SvgImage(this.imgPath, {super.key,this.color,this.size = 4.0, this.fit});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      colorFilter: color == null ? null : ColorFilter.mode(color ?? AppColors.black, BlendMode.srcIn) ,
      imgPath.path,
      width: size.r,
      height: size.r,
      fit: fit ?? BoxFit.contain,
      placeholderBuilder: (context) {
        return Container(color: Colors.grey, width: size.r, height: size.r);
      },
    );
  }
}
