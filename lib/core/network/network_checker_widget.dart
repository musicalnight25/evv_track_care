import 'package:healthcare/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthcare/src/home/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../di_container.dart';
import '../constants/color_constants.dart';
import '../constants/image_constants.dart';
import '../utils/text.dart';
import 'network_service.dart';

class NetworkCheckerWidget extends StatelessWidget {
  final Widget child;

  const NetworkCheckerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    NetworkStatus networkStatus = Provider.of<NetworkStatus>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      body:  SafeArea(
        child: Column(
          children: [
            if (homeProvider.syncingOfflineData) LinearProgressIndicator(),
            Expanded(child: child),
            if(networkStatus == NetworkStatus.offline)
            Container(
                padding: EdgeInsets.symmetric(vertical: 0.5.h),
                color: AppColors.grey.shade800,
                child: const Center(child: Txt("No Internet Connection", textColor: Colors.white))),
          ],
        ),
      ) ,
    );

    // return Scaffold(
    //   body: networkStatus == NetworkStatus.online ? child : Column(
    //     children: [
    //       Expanded(child: child),
    //       Container(
    //         width: double.infinity,
    //         color: AppColors.theme,
    //         padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.2.h),
    //         alignment: Alignment.center,
    //         child: Txt("No Internet Connection.!", textColor: Colors.white, fontSize: 1.6.t),
    //       )
    //     ],
    //   ),
    // );
  }
}

class NoInternetWdget extends StatelessWidget {
  const NoInternetWdget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImages.no_internet_galaxy),
              Txt("No Internet", fontSize: 4.t, textColor: AppColors.theme),
              Txt("Check your Internet Connection..!", fontSize: 1.5.t, textColor: Colors.black),
              SizedBox(height: 2.h),
              SizedBox(
                width: 55.w,
                // padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: ElevatedButton(
                    onPressed: () {
                      Di.sl<NetworkService>().checkConnection();
                    },
                    child: Txt("Retry", textColor: Colors.white, fontSize: 2.t, fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
