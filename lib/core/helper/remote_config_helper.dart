import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/api_constants.dart';

class RemoteConfigService {
  RemoteConfigService._privateConstructor();

  static final RemoteConfigService instance =
      RemoteConfigService._privateConstructor();
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> setupRemoteConfig() async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: Duration.zero, minimumFetchInterval: Duration.zero));
      await remoteConfig.ensureInitialized();
      await remoteConfig.fetchAndActivate();
    } on FirebaseException catch (e) {
      log('Remote exception --> ${e.message.toString()}');
    }
  }

  Future<void> getAppUpdateInfo(BuildContext context) async {
    String updateString = remoteConfig.getString('app_update');

    if (updateString.isNotEmpty) {
      Map<String, dynamic> updateMap = jsonDecode(updateString);

      Map<String, dynamic> appUpdateMap =
          updateMap[Platform.isAndroid ? 'android' : 'ios'];
      log('updateMap --> $updateMap');
      String whatsNew = appUpdateMap['whats_new'];
      String updateLink = Platform.isAndroid
          ? Apis.playStoreLink
          : Apis.appStoreLink;
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String buildNumber = packageInfo.buildNumber;

      int remoteAppVersionInt = appUpdateMap['app_version'];
      int buildNumberInt = int.parse(buildNumber);

      if (remoteAppVersionInt > buildNumberInt) {
        return showAppDialog(
            context,
            title: 'New Update Available',
            subtitle: whatsNew,
            canPop: appUpdateMap['update_type'] == 'hard' ? false : true,
            buttonText: 'Update Now',
            showBackButton:
                appUpdateMap['update_type'] == 'hard' ? false : true,
            onTap: () async => await launchUrlString(updateLink,mode: LaunchMode.externalApplication),
            backBtText: 'Later',
            backOnTap: () => Get.back(),
          );
      }
    }
  }
}

Future showAppDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String buttonText,
  required GestureTapCallback? onTap,
  String? backBtText,
  GestureTapCallback? backOnTap,
  bool showButton = true,
  bool barrierDismissible = true,
  bool showBackButton = true,
  bool canPop = true,
  Color? lottieBgColor,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return PopScope(
        canPop: canPop,
        child: Dialog(
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                 Txt(
                  title,
                  fontSize: 20,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Txt(
                    subtitle,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.appBlack87,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (showBackButton)
                      GestureDetector(
                        onTap: backOnTap ?? () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.Primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Txt(
                            backBtText ?? '',
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    if (showButton) ...[
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: onTap ?? () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.Primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:Txt(
                            buttonText ?? '',
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
