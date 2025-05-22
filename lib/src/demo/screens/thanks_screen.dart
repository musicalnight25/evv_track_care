import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/core/common/widgets/app_image_assets.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/constants/image_constants.dart';
import 'package:healthcare/core/utils/size_config.dart';

import '../../../config/routes/app_router/route_params.dart';
import '../../../config/routes/routes.dart';
import '../../../core/common/widgets/custom_elevated_button.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/network/network_checker_widget.dart';
import '../../../core/utils/gap.dart';
import '../../../core/utils/text.dart';
import '../../auth/providers/auth_provider.dart';

class ThanksRoute implements BaseRoute {
  const ThanksRoute();

  @override
  Widget get screen => ThanksScreen(params: this);

  @override
  Routes get routeName => Routes.thanks;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class ThanksScreen extends StatefulWidget {
  final ThanksRoute params;

  const ThanksScreen({super.key, required this.params});

  @override
  State<ThanksScreen> createState() => _ThanksScreen();
}

class _ThanksScreen extends State<ThanksScreen> {
  late AuthProvider provider;

  Timer? _inactivityTimer;
  final Duration _inactivityDuration = const Duration(seconds: 5); // Set the inactivity duration
  bool _isInactive = false;

  void _resetTimer() {
    // Cancel any existing timer
    _inactivityTimer?.cancel();

    // Reset the inactivity flag
    if (_isInactive) {
      setState(() {
        _isInactive = false;
      });
    }

    // Start a new timer
    _inactivityTimer = Timer(_inactivityDuration, () {
      setState(() {
        _isInactive = true; // Mark as inactive
      });
      _onInactivity();
    });
  }

  void _onInactivity() {
    print("User has been inactive for ${_inactivityDuration.inSeconds} seconds.");
    // Perform any action on inactivity
    // For example, navigate to another screen or show a dialog
    context.popUntil((route) => route.settings.name == Routes.demo.path);
  }

  @override
  void initState() {
    super.initState();
    _resetTimer();
    // _isInactive ? context.popUntil((route) => route.settings.name == Routes.demo.path) :;
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkCheckerWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.lightSeaGreen,width: 0.7)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),
                    Center(
                        child: AppImageAsset(
                      image: AppIcons.ic_sucess,
                          height: 94,
                          width: 94,
                    )),
                    SizedBox(height: 30,),
                    const AppImageAsset(
                        image: AppIcons.ic_thankYou,
                        height: 60,
                        fit: BoxFit.fill),
                    SizedBox(height: 30,),
                    Txt(
                      "Your visit is complete.",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    Txt(
                      "Please hand the device",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    Txt(
                      "back to your caregiver.",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    VGap(5.h),
                    Padding(
                      padding: EdgeInsets.all(1.8.h),
                      child: CustomElevatedButton(
                        width: 109,
                        height: 48,
                        onTap: () async {
                          context.popUntil((route) => route.settings.name == Routes.demo.path);
                        },
                        child: Center(
                          child: Txt(
                            "DONE",
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
