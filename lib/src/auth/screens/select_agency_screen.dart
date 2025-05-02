
import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/config/routes/app_router/route_params.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/constants/image_constants.dart';
import 'package:healthcare/core/network/network_checker_widget.dart';
import 'package:healthcare/core/utils/common_toast.dart';
import 'package:healthcare/core/utils/gap.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:healthcare/src/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/src/home/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../../../config/routes/routes.dart';
import '../../../core/common/widgets/custom_elevated_button.dart';
import '../../../core/common/widgets/svg_image.dart';
import '../../../core/helper/loader.dart';
import '../../auth/providers/auth_provider.dart';

class SelectAgencyRoute extends AppScaffoldRoute {
  const SelectAgencyRoute();

  @override
  Widget get screen => SelectAgencyScreen(params: this);

  @override
  Routes get routeName => Routes.home;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class SelectAgencyScreen extends StatefulWidget {
  final SelectAgencyRoute params;

  const SelectAgencyScreen({super.key, required this.params});

  @override
  State<SelectAgencyScreen> createState() => _SelectAgencyScreenState();
}

class _SelectAgencyScreenState extends State<SelectAgencyScreen> with AutomaticKeepAliveClientMixin<SelectAgencyScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((p) async {
      showLoader(context);
      await Provider.of<AuthProvider>(context, listen: false).getAgency();
      hideLoader();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NetworkCheckerWidget(
      child: Scaffold(
        body: SafeArea(
          child: Consumer<AuthProvider>(builder: (context, auth, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VGap(6.h),
                Center(
                    child: SvgImage(
                  SvgIcons.logo_svg,
                  fit: BoxFit.fitHeight,
                  size: 1.h,
                )),
                VGap(3.h),
                Txt(
                  "Select Your Agency",
                  fontWeight: FontWeight.bold,
                  fontSize: 2.2.t,
                ),
                VGap(3.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.h),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        childAspectRatio: 0.95, // Adjust item height
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: auth.companies.length,
                      itemBuilder: (context, index) {
                        final item = auth.companies[index];
                        return InkWell(
                          onTap: () {
                            auth.selectedIndex = index;
                            auth.notify();
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: index == auth.selectedIndex ? AppColors.Primary : Colors.white, width: 2)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      item.logo != null ? "${auth.getImageBaseUrl().toString()}/images/logo/${item.logo}" : AppConsts.staticLogo,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                        onTap: () async {
                          if (auth.selectedIndex != null) {
                            final id = auth.selectedIndex;
                            await auth.setCompanyId(context, auth.companies[id ?? 0].name.toString(), auth.companies[id ?? 0].id.toString());
                            await context.pushNamedAndRemoveUntil(const HomeRoute(), (r) => false);
                          } else {
                            showToast("Please select agency");
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Txt(
                            "Continue",
                            fontSize: 1.7.t,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
