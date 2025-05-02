import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/core/common/widgets/svg_image.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/utils/gap.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/image_constants.dart';
import '../../../core/network/network_service.dart';

class PatientDetailsWidget extends StatelessWidget {
  final String? url;
  final Uint8List? imageData;
  final double borderRadius;
  final double? height;
  final ImageProvider placeHolderImage;

  const PatientDetailsWidget({
    super.key,
    this.url,
    this.imageData,
    this.height,
    this.placeHolderImage = const AssetImage(AppImages.loading_shimmer),
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return context.read<NetworkStatus>() == NetworkStatus.offline
        ? imageData != null
        ? buildContainer(MemoryImage(imageData!), BoxFit.cover, Colors.grey.shade100)
        : buildContainer(const AssetImage(AppImages.image_placeholder), BoxFit.fill, Colors.grey.shade100)
        : CachedNetworkImage(
      imageUrl: url ?? "",
      errorWidget: (context, url, error) => buildContainer(const AssetImage(AppImages.image_placeholder), BoxFit.fill, Colors.grey.shade100),
      placeholder: (context, url) => buildContainer(placeHolderImage, BoxFit.cover, Colors.grey.shade100),
      imageBuilder: (context, image) => buildContainer(image, BoxFit.cover, Colors.grey.shade100),
    );
  }

  Container buildContainer(ImageProvider<Object> image, BoxFit fit, Color? color) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w), color: AppColors.home_card_color),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.5.w), border: Border.all(width: 1, color: AppColors.Primary),color:AppColors.Primary,),
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: SvgImage(
                  SvgIcons.bathroom,
                  fit: BoxFit.fill,
                  size: 0.5.h,
                ),
              ),
            ),
            HGap(4.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Txt("Thomas Jevis", fontSize: 2.1.t, fontWeight: FontWeight.w400),
                VGap(0.5.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppColors.hint_text_color_dark,
                      size: 2.2.h,
                    ),
                    HGap(1.w),
                    Txt("11:00-14:30", fontSize: 1.7.t, textColor: AppColors.hint_text_color_dark, fontWeight: FontWeight.w400),
                  ],
                ),
                VGap(0.5.h),

              ],
            ),
            const Spacer(),
            Container(
              height: 3.h,
              width: 3.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.6.h),
                border: Border.all(width: 1)
              ),
              margin: EdgeInsets.symmetric(vertical: 1.h),
              child: Icon(Icons.add,size: 2.h,),
            )

          ],
        ),
      ),
    );
  }
}
