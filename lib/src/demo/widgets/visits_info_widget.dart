import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/core/common/widgets/app_image_assets.dart';
import 'package:healthcare/core/common/widgets/custom_image.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/utils/gap.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/image_constants.dart';
import '../../../core/helper/formatter.dart';
import '../../../core/network/network_service.dart';
import '../../auth/providers/auth_provider.dart';

class VisitsInfoWidget extends StatelessWidget {
  final String? url;
  final Uint8List? imageData;
  final double borderRadius;
  final String? imageUrl;
  final double? height;
  final String? name;
  final String? startTime;
  final String? endTime;
  final String? location;
  final String? status;
  final ImageProvider placeHolderImage;

  const VisitsInfoWidget({
    super.key,
    this.url,
    this.imageData,
    this.height,
    this.imageUrl,
    this.name,
    this.startTime,
    this.endTime,
    this.location,
    this.status,
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
      errorWidget: (context, url, error) => buildContainer(const AssetImage(AppImages.avatar), BoxFit.fill, Colors.grey.shade100),
      placeholder: (context, url) => buildContainer(placeHolderImage, BoxFit.cover, Colors.grey.shade100),
      imageBuilder: (context, image) => buildContainer(image, BoxFit.cover, Colors.grey.shade100),
    );
  }

  Container buildContainer(ImageProvider<Object> image, BoxFit fit, Color? color) {
    // print("Start and End Time ${startTime} - ${endTime}");
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.lightSeaGreen,
          width: 0.7
        ),
          borderRadius: BorderRadius.circular(14), color: AppColors.bgColor),
      child: Padding(
        padding: EdgeInsets.all(3.5.w),
        child: Consumer<AuthProvider>(builder: (context, auth, _) {
          return Row(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12,top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImage(
                          url: imageUrl != ""
                              ? "${auth.getImageBaseUrl().toString()}/images/avatars/$imageUrl"
                              : "${auth.getImageBaseUrl().toString()}/avatars.jpg",
                          height: 68,
                          width: 68,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                   Positioned(
                    right: 0,
                    child: AppImageAsset(
                        image: status == "completed"
                            ? AppIcons.ic_completed_oval
                            : status == "pending"
                            ? AppIcons.ic_pending_oval
                            : AppIcons.ic_pending_oval,
                        height: 34,
                        width: 34,
                        fit: BoxFit.fill),
                  ),
                ],
              ),
              // Image.asset(
              //   AppImages.ic_demo_img,
              //   height: 10.h,
              //   width: 10.h,
              //   fit: BoxFit.fill,
              // ),
              HGap(2.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Align(alignment:Alignment.topRight,child: Padding(
                    //   padding:  EdgeInsets.all(0.5.w),
                    //   child: Txt(status == "pending" ? "Pending" : "Completed",textColor:status == "pending" ? AppColors.Primary : Colors.orange,textAlign: TextAlign.end,fontSize: 1.75.t,fontWeight: FontWeight.w600,),
                    // )),
                    Row(
                      children: [
                        Expanded(
                            child: Txt(
                          name ?? "",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          overFlow: TextOverflow.ellipsis,
                        )),
                        HGap(2.w),
                        if (status == "pending")
                          const Txt(
                            "Pending",
                            textColor: AppColors.appOrange,
                            textAlign: TextAlign.end,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        if (status == "executing")
                          Txt(
                            "Executing",
                            textColor: Colors.green.shade900,
                            textAlign: TextAlign.end,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        if (status == "completed")
                          const Txt(
                            "Completed",
                            textColor: AppColors.lightSeaGreen,
                            textAlign: TextAlign.end,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                      ],
                    ),
                    VGap(0.3.h),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //
                    //   children: [
                    //     Icon(
                    //       Icons.watch_later_outlined,
                    //       color: AppColors.hint_text_color_dark,
                    //       size: 2.2.h,
                    //     ),
                    //     HGap(1.w),
                    //     Txt("${Formatter.stringDateFromString(startTime.toString(),reqFormat: "yyyy-MM-dd HH:mm:ss",resFormat: "HH:mm:a")} ${endTime.toString().isNotEmpty ? "- ${Formatter.stringDateFromString(endTime.toString(), reqFormat: "yyyy-MM-dd HH:mm:ss", resFormat: "HH:mm:a")}": ""}", fontSize: 1.7.t, textColor: AppColors.hint_text_color_dark, fontWeight: FontWeight.w400),
                    //   ],
                    // ),
                    // VGap(0.5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: AppImageAsset(image: AppIcons.ic_clock),
                        ),
                        HGap(2.w),
                        Txt(
                          DateFormat("dd/MM/yy").format(
                              DateFormat("yyyy-MM-dd HH:mm:ss")
                                  .parse(startTime!)),
                          maxLines: 1,
                          fontSize: 13,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w400,
                          overFlow: TextOverflow.ellipsis,
                        ),
                        if(status == "completed")...[
                          HGap(2.w),
                          const Txt(
                            '|',
                            maxLines: 1,
                            fontSize: 14,
                            textColor: AppColors.hint_text_color_dark,
                            fontWeight: FontWeight.w400,
                            overFlow: TextOverflow.ellipsis,
                          ),
                          HGap(2.w),
                          Txt(
                            '${Formatter.dateTimeFromStringddMMYY(
                              startTimeStr: startTime,
                              endTimeStr: endTime,
                            )}',
                            maxLines: 1,
                            fontSize: 13,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w400,
                            overFlow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                    VGap(0.3.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: AppImageAsset(image: AppIcons.ic_location,color: AppColors.Primary,),
                        ),
                        HGap(1.w),
                        Expanded(
                            child: Txt(
                          location ?? "",
                          maxLines: 3,
                          fontSize: 13,
                          textColor: AppColors.hint_text_color_dark,
                          fontWeight: FontWeight.w400,
                          overFlow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ],
                ),
              ),

              /*Column(
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
                    }))*/
            ],
          );
        }),
      ),
    );
  }
}


