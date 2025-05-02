import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (kDebugMode) {
        //   emailctr.text = "ann.muller@swiftdata.test";
        emailctr.text = "allenbaiyee@gmail.com";//"""viralmer51@gmail.com";
        // passwordctr.text = "ann.muller@swiftdata.test";
        passwordctr.text = "#iMbu2017!";//"jlKbKDc07";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        devlog("pop invoked in login page with resust : $didPop");
        SystemNavigator.pop();
      },
      child: NetworkCheckerWidget(
        child: Scaffold(
          body: SafeArea(
            child: Consumer<AuthProvider>(builder: (context, auth, _) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h - 2,
                      child: Stack(
                        children: [
                          Image.asset(
                            AppIcons.ic_login_top,
                            width: 100.w,
                            height: 40.h - 3,
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Transform.rotate(
                              angle: 3.142857,
                              child: ClipPath(
                                clipper: LeftTriangleClipper(),
                                child: Container(
                                  width: 100.w,
                                  height: 10.h,
                                  color: AppColors.bgColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    VGap(4.h),
                    Center(
                      child: SvgImage(
                        SvgIcons.logo_svg,
                        fit: BoxFit.fitHeight,
                        size: 1.h,
                      ),
                    ),
                    VGap(2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Txt(
                        "Welcome back!",
                        fontWeight: FontWeight.w600,
                        fontSize: 2.3.t,
                      ),
                    ),
                    VGap(2.5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: CustomTextField(
                        ctr: emailctr,
                        fontSize: 1.6.t,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 5.w),
                        labelText: "Email",
                      ),
                    ),
                    VGap(1.2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: CustomTextField(
                        ctr: passwordctr,
                        lines: 1,
                        obsecuredText: passwordShow,
                        fontSize: 1.6.t,
                        contentPadding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 5.w),
                        labelText: "Password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            passwordShow = !passwordShow;
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.remove_red_eye_sharp,
                            color: AppColors.Primary,
                          ),
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
                          child: Txt(
                            "Forgot your password?",
                            textColor: AppColors.grey,
                            fontSize: 1.6.t,
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
                                final res = await auth.userLogin(context, email: emailctr.text.trim(), password: passwordctr.text.trim(), listen: false);
                                hideLoader();
                                if (res) await auth.skipScreen(context);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Txt(
                                "Login",
                                fontSize: 1.7.t,
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
