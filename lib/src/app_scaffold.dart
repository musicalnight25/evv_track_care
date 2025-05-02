import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/src/demo/screens/visits_screen.dart';
import 'package:healthcare/src/home/screens/home_screen.dart';
import 'package:healthcare/src/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/app_router/route_params.dart';
import '../config/routes/routes.dart';
import '../core/constants/color_constants.dart';

class AppScaffoldRoute implements BaseRoute {
  final int? initialIndex;

  const AppScaffoldRoute({this.initialIndex});

  @override
  Widget get screen => AppScaffold(params: this);

  @override
  Routes get routeName => Routes.appScaffold;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class AppScaffold extends StatefulWidget {
  final AppScaffoldRoute params;

  const AppScaffold({super.key, required this.params});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

enum BottomNavItem {
  home(Icons.home_filled, "", HomeRoute()),
  activity(Icons.file_present, "", DemoRoute(id: "",name: "",location: "",lat: 0.0,long: 0.0,phone: "0000",avatar: "")),
  profile(Icons.person, "", ProfileRoute());

  final IconData icon;
  final String title;
  final BaseRoute route;

  const BottomNavItem(this.icon, this.title, this.route);
}

class _AppScaffoldState extends State<AppScaffold> {
  int currentIndex = 0;

  late final PageController pctr;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.params.initialIndex ?? 0;
    pctr = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Txt("${BottomNavItem.values[currentIndex].title} Screen", textColor: AppColors.white),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: BottomNavItem.values
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(
                    e.icon,
                    color: currentIndex == e.index ? AppColors.theme : AppColors.black,
                  ),
                  label: e.title,
                ))
            .toList(),
        unselectedItemColor: AppColors.black.withOpacity(0.5),
        selectedItemColor: AppColors.theme,
        currentIndex: currentIndex,
        selectedFontSize: 1.8.h,
        onTap: (index) => setState(() {
          currentIndex = index;
          pctr.jumpToPage(index);
        }),
      ),
      body: Center(
        child: PageView(
          controller: pctr,
          physics: const NeverScrollableScrollPhysics(),

          ///UNCOMMENT THIS LINE TO DISABLE HORIZONTAL SCROLL
          // physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => currentIndex = index),
          children: BottomNavItem.values.map((e) => e.route.screen).toList(),
        ),
      ),
    );
  }
}

//  IndexedStack(
//     index: currentIndex,
//     children: BottomNavItem.values.map((e) => e.route.screen).toList(),
//   )
