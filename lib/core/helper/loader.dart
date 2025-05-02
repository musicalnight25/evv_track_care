import 'package:healthcare/core/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/routes/app_router/router.dart';
import '../constants/color_constants.dart';
import '../utils/devlog.dart';

BuildContext? c;

showLoader(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      c = rootNavigatorKey.currentContext;
      return const LoaderPage();
    },
  );
}

hideLoader() {
  try {
    Navigator.pop(c ?? rootNavigatorKey.currentContext!);
  } catch (e) {
    devlogError("error in hide loader : $e");
  }
}

class LoaderPage extends StatefulWidget {
  const LoaderPage({super.key});

  @override
  AddPromptPageState createState() => AddPromptPageState();
}

class AddPromptPageState extends State<LoaderPage> {
  TextEditingController nameAlbumController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return animatedDialogueWithTextFieldAndButton(context);
  }

  animatedDialogueWithTextFieldAndButton(context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        return;
      },
      child: Material(
        color: Colors.grey.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4.w)),
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(1, 1))]),
                child: const Column(
                  children: <Widget>[
                    CupertinoActivityIndicator(color: AppColors.theme, radius: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
