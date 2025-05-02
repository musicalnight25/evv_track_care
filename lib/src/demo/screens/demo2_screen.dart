import 'package:healthcare/config/routes/routes.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/app_router/route_params.dart';

 class Demo2Route implements BaseRoute {
  const Demo2Route();
  @override
  Routes get routeName => Routes.demo2;

  @override
  Widget get screen => const Demo2Screen();
  
  @override

  TransitionType get type => AppConsts.transitionType;
}

class Demo2Screen extends StatefulWidget {
  const Demo2Screen({super.key});

  @override
  State<Demo2Screen> createState() => _Demo2ScreenState();
}

class _Demo2ScreenState extends State<Demo2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.random,
      appBar: AppBar(
        title: const Txt("Demoe 2  "),
      ),
    );
  }
}
