import 'package:flutter/services.dart';
import 'package:healthcare/core/common/widgets/app_image_assets.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/utils/gap.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/core/utils/text.dart';
// import 'package:healthcare/src/auth/screens/select_agency_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/common/widgets/svg_image.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/image_constants.dart';
import '../../../core/helper/remote_config_helper.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/screens/login_screen.dart';

import '../../../config/routes/app_router/route_params.dart';
import '../../../config/routes/routes.dart';

class SplashRoute implements BaseRoute {
  @override
  Widget get screen => SplashScreen(params: this);

  @override
  Routes get routeName => Routes.splash;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class SplashScreen extends StatefulWidget {
  final SplashRoute params;

  const SplashScreen({super.key, required this.params});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      await Future.delayed(Duration.zero,() {
        RemoteConfigService.instance.getAppUpdateInfo(context);
      },);
      await Provider.of<AuthProvider>(context, listen: false).skipScreen(context);
      /// TOKEN BASED LOGIN
    //    isToken ? context.pushNamedAndRemoveUntil(AppScaffoldRoute(), (route) => false) :  context.pushNamedAndRemoveUntil(LoginRoute(), (route) => false);

    //    context.pushNamedAndRemoveUntil(AppScaffoldRoute(), (route) => false);

    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColors.bgColor),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
             AppImageAsset(image: AppImages.imgSplash,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
               fit: BoxFit.cover,
            ),
        /*    Row(
              children: [
                VGap(2.h),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: SvgImage(
                SvgIcons.logo_svg,
                fit: BoxFit.fitHeight,
                size: 1.h,
              ),//Image.asset(AppIcons.ic_app_logo_top, width: 80.w),
            ),
            Padding(
              padding: EdgeInsets.only(left: 80.w),
              child: Transform.rotate(
                  angle: 0.785,
                  child: Container(
                    height: 1.6.h,
                    width: 1.6.h,
                    color: Colors.grey,
                  )),
            ),
            VGap(1.h),
            Padding(
              padding: EdgeInsets.only(left: 23.w),
              child: Transform.rotate(
                  angle: 0.785,
                  child: Container(
                    height: 2.5.h,
                    width: 2.5.h,
                    color: AppColors.themeLight.withOpacity(0.29),
                  )),
            ),
            VGap(0.2.h),
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Txt("Digital \nManagement \nPlatform for \nCaregivers", fontWeight: FontWeight.w500, fontSize: 4.t, textAlign: TextAlign.start),
                  const Spacer(),
                  Transform.translate(
                      offset: Offset(2.h, 0),
                      child: Transform.rotate(
                          angle: 0.785,
                          child: Container(
                            height: 4.h,
                            width: 4.h,
                            color: AppColors.themeLight,
                          ))),
                ],
              ),
            ),
            VGap(2.h),
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      children: List.generate(10, (i) {
                    return Container(
                      height: 0.4.h,
                      width: 1,
                      color: AppColors.theme,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                    );
                  })),
                  HGap(3.w),
                  Txt("Take the First \nStep to Providing \nbetter HealthCare", fontWeight: FontWeight.w500, fontSize: 2.2.t, textAlign: TextAlign.start),
                  HGap(5.w),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Transform.rotate(
                        angle: 0.785,
                        child: Container(
                          height: 1.7.h,
                          width: 1.7.h,
                          color: AppColors.themeLight.withOpacity(0.29),
                        )),
                  ),
                ],
              ),
            ),
            VGap(2.h),
            SizedBox(
              height: 35.h - 2,
              child: Stack(
                children: [
                  Image.asset(
                    AppIcons.ic_login_top,
                    width: 100.w,
                    height: 35.h - 3,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Transform.rotate(
                      angle: 3.14,
                      child: ClipPath(
                        clipper: LeftTriangleClipper(),
                        child: Container(
                          width: 100.w,
                          height: 10.h,
                          color: AppColors.bgColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: Transform.translate(
                        offset: Offset(-2.h, 0),
                        child: Transform.rotate(
                            angle: 0.785,
                            child: Container(
                              height: 4.h,
                              width: 4.h,
                              color: AppColors.themeLight,
                            ))),
                  ),
                  Transform.translate(
                      offset: Offset(0, 2.9.h),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 5.8.h,
                            width: 5.8.h,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.h), border: Border.all(width: 1, color: AppColors.themeLight)),
                            child: Icon(
                              Icons.arrow_upward_outlined,
                              size: 2.5.h,
                              color: AppColors.themeLight,
                            ),
                          )))
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
