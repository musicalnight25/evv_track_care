import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/core/common/widgets/custom_image.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/utils/gap.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/image_constants.dart';
import '../../../core/network/network_service.dart';
import '../../auth/providers/auth_provider.dart';

class PatientInfoWidget extends StatelessWidget {
  final String? url;
  final Uint8List? imageData;
  final String? imageUrl;
  final double borderRadius;
  final double? height;
  final String? name;
  final String? address;
  final String? startTime;
  final String? endTime;
  final ImageProvider placeHolderImage;

  const PatientInfoWidget({
    super.key,
    this.url,
    this.imageData,
    this.imageUrl,
    this.height,
    this.name,
    this.address,
    this.startTime,
    this.endTime,
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
        child:Consumer<AuthProvider>(builder: (context, auth,_)  {
            return Row(
              children: [
                CustomImage(
                 url: imageUrl  != "" ? "${auth.getImageBaseUrl().toString()}/images/avatars/$imageUrl" : "${auth.getImageBaseUrl().toString()}/avatars.jpg",height: 10.h,width: 10.h,fit: BoxFit.fill,
                ),
              /*  Image.asset(
                  AppImages.ic_demo_img,
                  height: 10.h,
                  width: 10.h,
                  fit: BoxFit.fill,
                ),*/
                HGap(2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Txt(name ?? "", fontSize: 2.1.t, fontWeight: FontWeight.w500),
                      VGap(0.5.h),
                    /*  Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.hint_text_color_dark,
                            size: 2.2.h,
                          ),
                          HGap(1.w),
                          Txt(startTime == "" ? "--" : "${Formatter.stringDateFromString(startTime,reqFormat: "yyyy-MM-dd HH:mm:ss",resFormat: "HH:mm:a")} - ${Formatter.stringDateFromString(endTime,reqFormat: "yyyy-MM-dd HH:mm:ss",resFormat: "HH:mm:a")}", fontSize: 1.7.t, textColor: AppColors.hint_text_color_dark, fontWeight: FontWeight.w400),
                        ],
                      ),
                      VGap(0.5.h),*/
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.theme,
                            size: 2.5.h,
                          ),
                          HGap(1.w),
                          Expanded(child: Txt(address == "null,null,null,null,null" ? "--" : address ?? "",maxLines: 3, fontSize: 1.7.t, textColor: AppColors.hint_text_color_dark, fontWeight: FontWeight.w400,overFlow: TextOverflow.ellipsis,)),
                        ],
                      )
                    ],
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return Container(
                        height: 0.4.h,
                        width: 0.4.h,
                        decoration: BoxDecoration(
                          color: AppColors.dot_dark,
                          borderRadius: BorderRadius.circular(0.2.h)
                        ),
                        margin: EdgeInsets.symmetric(vertical: 1.h),
                      );
                    }))
              ],
            );
          }
        ),
      ),
    );
  }
}
