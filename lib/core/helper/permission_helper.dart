import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common/widgets/app_open_settings.dart';

class PermissionHelper {
  PermissionHelper._privateConstructor();

  static final PermissionHelper instance = PermissionHelper._privateConstructor();

  static Future<PermissionStatus> askLocationPermission() async {
    PermissionStatus permissionStatus;
    permissionStatus = await Permission.location.request();
    log("permissionStatus ---> $permissionStatus");
    if (permissionStatus.isPermanentlyDenied) {
      // await openAppSettings();
      Future.delayed(
        Duration.zero,
            () {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return const AppOpenSettings(errorText: 'Your location is disabled,\n please Enable it',);
            },
          );
        },
      );
    }
    return permissionStatus;
  }

  static Future<bool> checkLocationPermission() async {
    PermissionStatus permissionStatus;
    permissionStatus = await Permission.location.status;
    log('permissionStatus ==---> $permissionStatus');
    return permissionStatus.isGranted || permissionStatus.isLimited;
  }
}
