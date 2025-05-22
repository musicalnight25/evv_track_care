import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthcare/core/common/widgets/app_image_assets.dart';
import 'package:healthcare/core/common/widgets/custom_elevated_button.dart';
import 'package:healthcare/core/common/widgets/custom_text_field.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/constants/image_constants.dart';
import 'package:healthcare/core/extensions/string_validation_extension.dart';
import 'package:healthcare/core/helper/loader.dart';
import 'package:healthcare/core/network/network_checker_widget.dart';
import 'package:healthcare/core/utils/common_toast.dart';
import 'package:healthcare/core/utils/devlog.dart';
import 'package:healthcare/core/utils/gap.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:healthcare/src/auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../config/routes/app_router/route_params.dart';
import '../../../config/routes/routes.dart';
import '../../../core/common/widgets/svg_image.dart';

class LoginRoute implements BaseRoute {
  @override
  Widget get screen => LoginScreen(params: this);

  @override
  Routes get routeName => Routes.login;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class LoginScreen extends StatefulWidget {
  final LoginRoute params;

  const LoginScreen({super.key, required this.params});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordctr = TextEditingController();

  TextEditingController emailctr = TextEditingController();

  bool passwordShow = true;
  bool isRemember = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (kDebugMode) {
        //   emailctr.text = "ann.muller@swiftdata.test";
        // emailctr.text = "allenbaiyee@gmail.com";//"""viralmer51@gmail.com";
        // passwordctr.text = "ann.muller@swiftdata.test";
        // passwordctr.text = "#iMbu2017!";//"jlKbKDc07";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColors.white),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          devlog("pop invoked in login page with resust : $didPop");
          SystemNavigator.pop();
        },
        child: NetworkCheckerWidget(
          child: Scaffold(
            backgroundColor: AppColors.home_card_color,
            body: SafeArea(
              child: Consumer<AuthProvider>(builder: (context, auth, _) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipPath(
                            clipper: DiagonalClipper(),
                            child: Container(
                              height: 280,
                              alignment: Alignment.topCenter,
                              decoration:  const BoxDecoration(
                                color: AppColors.white,
                                image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: AssetImage(AppIcons.ic_login_top),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      VGap(2.h),
                      const Center(
                        child: AppImageAsset(image: AppIcons.logoSvg,
                        height: 46,
                        ),
                      ),
                      VGap(7.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: const Txt(
                          "Welcome back!",
                          fontWeight: FontWeight.w600,
                          fontSize: 21,
                        ),
                      ),
                      VGap(2.5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: CustomTextField(
                          radius: 11,
                          ctr: emailctr,
                          fontSize: 14,
                          contentPadding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 5.w),
                          labelText: "Email",
                        ),
                      ),
                      VGap(1.2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: CustomTextField(
                          radius: 11,
                          ctr: passwordctr,
                          lines: 1,
                          obsecuredText: passwordShow,
                          fontSize: 14,
                          contentPadding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 5.w),
                          labelText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              passwordShow = !passwordShow;
                              setState(() {});
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppImageAsset(image: AppIcons.ic_eye, height: 14, width: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                      VGap(1.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: GestureDetector(onTap: () {
                                  isRemember = !isRemember;
                                  setState(() {});
                                },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: isRemember
                                          ? AppColors.Primary
                                          : null,
                                      border: Border.all(
                                        color: AppColors.Primary,
                                      ),
                                    ),
                                    child: isRemember
                                        ? const Icon(Icons.check, color: AppColors.white, size: 15,)
                                        : null,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () async {
                                  isRemember = !isRemember;
                                  setState(() {});
                                },
                                child: const Txt(
                                  "Remember me",
                                  textColor: AppColors.hint_text_color_dark,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VGap(1.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () async {
                            await launchUrlString(AppConsts.forgotPassword);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: const Txt(
                              "Forgot your password?",
                              textColor: AppColors.hint_text_color_dark,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      VGap(2.5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                              onTap: () async {
                                if (emailctr.text.isEmpty) {
                                  showToast("Please enter email");
                                } else if (!emailctr.text.isValidEmail) {
                                  showToast("Please enter valid email");
                                } else if (passwordctr.text.isEmpty) {
                                  showToast("Please enter password");
                                } else {
                                  showLoader(context);
                                  final res = await auth.userLogin(context,
                                      email: emailctr.text.trim(),
                                      password: passwordctr.text.trim(),
                                      listen: false,
                                  isRememberMe: isRemember
                                  );
                                  log('res: $res');
                                  hideLoader();
                                  if (res) await auth.skipScreen(context);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: const Txt(
                                  "Login",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  textColor: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

///

class LeftTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height); // Bottom-left
    path.lineTo(size.width, 0); // Top-right
    path.lineTo(0, 0); // Top-left
    path.lineTo(size.width, size.height); // Top-left
    path.close(); // Close the path to form a triangle
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0); // Start at top-left
    path.lineTo(0, size.height); // Down to bottom-left
    path.lineTo(size.width, size.height - 80); // Diagonal up to bottom-right with offset
    path.lineTo(size.width, 0); // Top-right
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
