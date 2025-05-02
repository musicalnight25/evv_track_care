import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcare/config/routes/app_router/route_extensions.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                  child: Image.asset(
                AppImages.success,
                scale: 0.2.h,
              )),
              Txt(
                "Thank You!",
                fontWeight: FontWeight.bold,
                fontSize: 5.t,
              ),
              Txt(
                "Your visit is complete.",
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                fontSize: 2.2.t,
              ),
              Txt(
                "Please hand the device",
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                fontSize: 2.2.t,
              ),
              Txt(
                "back to your caregiver.",
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                fontSize: 2.2.t,
              ),
              VGap(5.h),
              Padding(
                padding: EdgeInsets.all(1.8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      onTap: () async {
                        context.popUntil((route) => route.settings.name == Routes.demo.path);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Txt(
                          "Done",
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white,
                          fontSize: 2.2.t,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
