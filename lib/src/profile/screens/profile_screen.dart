import 'package:healthcare/core/network/network_checker_widget.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:healthcare/src/app_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/routes.dart';

class ProfileRoute extends AppScaffoldRoute {
  const ProfileRoute();

  @override
  Widget get screen => ProfileScreen(params: this);

  @override
  Routes get routeName => Routes.profile;
}

class ProfileScreen extends StatefulWidget {
  final ProfileRoute params;

  const ProfileScreen({super.key, required this.params});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin<ProfileScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NetworkCheckerWidget(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

               Padding(
                 padding:  EdgeInsets.all(2.h),
                 child: Txt("Profile Screen ",fontSize: 2.3.t,fontWeight: FontWeight.bold,),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
