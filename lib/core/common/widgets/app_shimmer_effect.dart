import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerEffectView extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;

  const AppShimmerEffectView({Key? key, this.height, this.width, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE0E0E0),
      highlightColor: const Color(0xFFF5F5F5),
      child: Container(
        height: height ?? 30,
        width: width ?? 50,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
        ),
      ),
    );
    //   Shimmer.fromColors(
    //   baseColor: AppColorConstant.appWhite.withOpacity(0.5),
    //   highlightColor: AppColorConstant.appWhite.withOpacity(0.5),
    //   child: Container(
    //     height: height ?? 30,
    //     width: width ?? 50,
    //     decoration: BoxDecoration(
    //       color: AppColorConstant.appWhite.withOpacity(0.5),
    //       borderRadius: BorderRadius.circular(borderRadius ?? 4),
    //     ),
    //   ),
    // );
  }
}
