import 'package:flutter/material.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/text.dart';

class AppOpenSettings extends StatelessWidget {
 final String? errorText;
  const AppOpenSettings({super.key,this.errorText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(right: 10, left: 15, top: 10),
      contentPadding:
          const EdgeInsets.only(right: 10, left: 15, top: 10, bottom: 20),
      shape: Border.all(style: BorderStyle.none),
      title:const Txt(
        'Alert',
        textColor: AppColors.black,
        fontSize: 18,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Txt(
            '$errorText',
            textColor: AppColors.black,
            fontSize: 18,
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: AppColors.Primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:const Txt(
                    'Close',
                    textColor: AppColors.white,
                    textAlign: TextAlign.center,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await openAppSettings();
                  // Geolocator.openLocationSettings();
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: AppColors.Primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:const Txt(
                    'Go Settings',
                    textColor: AppColors.white,
                    textAlign: TextAlign.center,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
