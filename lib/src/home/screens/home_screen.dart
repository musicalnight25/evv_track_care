import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/config/routes/app_router/route_params.dart';
import 'package:healthcare/core/common/widgets/app_image_assets.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/constants/image_constants.dart';
import 'package:healthcare/core/network/network_checker_widget.dart';
import 'package:healthcare/core/network/network_service.dart';
import 'package:healthcare/core/utils/common_toast.dart';
import 'package:healthcare/core/utils/devlog.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:healthcare/src/app_scaffold.dart';
import 'package:healthcare/src/home/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../config/routes/routes.dart';
import '../../../core/common/widgets/custom_elevated_button.dart';
import '../../../core/common/widgets/svg_image.dart';
import '../../../core/data/models/response/clients_list_response.dart';
import '../../../core/helper/loader.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/screens/select_agency_screen.dart';
import '../../demo/screens/visits_screen.dart';
import '../widgets/patient_info_widget.dart';

extension IsConnected on BuildContext {
  bool get isConnected {
    return this.read<NetworkStatus>() == NetworkStatus.online;
  }
}

class HomeRoute extends AppScaffoldRoute {
  const HomeRoute();

  @override
  Widget get screen => HomeScreen(params: this);

  @override
  Routes get routeName => Routes.home;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class HomeScreen extends StatefulWidget {
  final HomeRoute params;

  const HomeScreen({super.key, required this.params});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(const Duration(days: 3));

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((p) async {
      showLoader(context);
      await Provider.of<HomeProvider>(context, listen: false).companyDetailsApi();
      hideLoader();
  //    await Provider.of<HomeProvider>(context, listen: false).offlineFetchApi();
    });
  }

  Future<List<Clients>> loadClients() async {
    final String response = await rootBundle.loadString('assets/json/client_data.json');
    final List<dynamic> data = json.decode(response);
    print("Data of Client  ${data.first}");
    return data.map((client) => Clients.fromJson(client)).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NetworkCheckerWidget(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColors.bgColor),
        child: Scaffold(
          body: SafeArea(
            child: Consumer<HomeProvider>(builder: (context, home, _) {
              return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 30.0, left: 25),
                            child: Row(
                              children: [
                                AppImageAsset(
                                  image: AppIcons.logoSvg,
                                  height: 26,
                                  width: 98,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.bgColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Txt(
                                  "Agency : ",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                 Expanded(
                                  child: Txt(
                                    home.companyName ?? "",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.black,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          if (context.isConnected) {
                                            context.pushNamedAndRemoveUntil(const SelectAgencyRoute(), (r) => false);
                                          } else {
                                            showSnackbarError("No Internet Connection.!");
                                          }
                                        },
                                        child: const AppImageAsset(image: AppIcons.ic_more,
                                        height: 15,
                                          width: 10,
                                          fit: BoxFit.contain,
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.7.h,
                          ),
                          const Txt(
                            "Client List",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            textColor: AppColors.black,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(
                                color: AppColors.appGreyLight,
                                width: 0.7
                              )
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10,),
                                const AppImageAsset(image: AppIcons.ic_search),
                                Expanded(
                                  child: TextField(
                                    controller: home.searchController,
                                    onChanged: (q) async {
                                      await Provider.of<HomeProvider>(context,
                                          listen: false)
                                          .filterClients(
                                          q, home.finalClientData);
                                    },
                                    style: const TextStyle(
                                      color: AppColors.hint_text_color_dark,
                                      fontSize: 14,
                                      fontFamily: 'HurmeGeometricSans1',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle: const TextStyle(
                                        color: AppColors.hint_text_color_dark,
                                        fontSize: 14,
                                        fontFamily: 'HurmeGeometricSans1',
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 2.w,
                                      ),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        /*  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: home.searchController,
                                      onChanged: (q) async {
                                        await Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .filterClients(
                                                q, home.finalClientData);
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Search...',
                                          border: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,

                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 2.w,
                                          ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        home.searchController.text.isNotEmpty,
                                    child: InkWell(
                                        onTap: () async {
                                          home.searchController.text = "";
                                          await Provider.of<HomeProvider>(
                                                  context,
                                                  listen: false)
                                              .filterClients(
                                                  "", home.finalClientData);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 2.5.h,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  )
                                ],
                              ),
                            ),
                          ),*/
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  if(home.clientData.isNotEmpty)
                                    ...List.generate(
                                      home.clientData.length,
                                      (index) => home.clientData.isNotEmpty
                                          ? Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                                              child: GestureDetector(onTap: () async {
                                                // showLoader(context);
                                                // await Future.delayed(Duration(milliseconds: 600));
                                                // hideLoader();
                                                // await context.pushNamed(PatientDetailsScreenRoute(id: home.clientData[index].client?.id.toString() ?? "", clientListResponse: home.clientData[index]));
                                                print("Client Data ${home.clientData[index].providerIdentification?.name}");
                                                FocusManager.instance.primaryFocus?.unfocus();
                                                print(home.clientData[index].client?.avatar);
                                                print(home.clientData[index].client?.avatar);
                                                devlog("clientAddressLine1 : ${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientAddressLine1}");
                                                await context.pushNamed(DemoRoute(
                                                    id: home.clientData[index].client!.id.toString(),
                                                    name:
                                                        "${home.clientData[index].client?.clientFirstName ?? ""} ${home.clientData[index].client?.clientMiddleInitial != null ? "${home.clientData[index].client?.clientMiddleInitial} " : ""}${home.clientData[index].client?.clientLastName}",
                                                    location: home.clientData[index].client?.clientAddresses?.firstOrNull?.clientAddressLine1 == null
                                                        ? "--"
                                                        : "${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientAddressLine1 ?? ""},${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientAddressLine2 ?? ""},${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientCity ?? ""},${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientState ?? ""},${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientCounty ?? ""}",
                                                    client: home.clientData[index].client!,
                                                    lat: home.clientData[index].clientAddress?.firstOrNull!.clientAddressLatitude?.toDouble(),
                                                    long: home.clientData[index].clientAddress?.firstOrNull!.clientAddressLongitude?.toDouble(),
                                                    phone: home.clientData[index].clientPhone?.firstOrNull?.clientPhone.toString(),
                                                    avatar: home.clientData[index].client?.avatar ?? ""));
                                              }, child: Builder(builder: (context) {
                                                return PatientInfoWidget(
                                                  name:
                                                      "${home.clientData[index].client?.clientFirstName ?? ""} ${home.clientData[index].client?.clientMiddleInitial != null ? "${home.clientData[index].client?.clientMiddleInitial} " : ""}${home.clientData[index].client?.clientLastName ?? ""}",
                                                  imageUrl: home.clientData[index].client?.avatar,
                                                  startTime:
                                                      home.clientData[index].visitTime?.firstOrNull?.createdAt == null ? "" : home.clientData[index].visitTime?.firstOrNull?.createdAt.toString(),
                                                  endTime: home.clientData[index].visitTime?.firstOrNull?.updatedAt == null ? "" : home.clientData[index].visitTime?.firstOrNull?.updatedAt.toString(),
                                                  address:
                                                      "${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientAddressLine1},${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientAddressLine2 ?? ""},${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientCity ?? ""},${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientState ?? ""},${home.clientData[index].client?.clientAddresses?.firstOrNull?.clientCounty ?? ""}",
                                                );
                                              })),
                                            )
                                          : const Center(
                                              child: Txt(
                                              "Data Not Found",
                                              textColor: Colors.black,
                                            ))),
                                  if(home.clientData.isEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(top: 15.h, right: 10.w, left: 10.w),
                                      child: Column(
                                        children: [
                                          Image.asset(AppIcons.ic_no_data, scale: 0.1),
                                          Txt(
                                            "No client found in this company",
                                            fontSize: 2.5.t,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.bold,
                                            textColor: AppColors.Primary,
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                        height: 74,
                        decoration: const BoxDecoration(
                          color: AppColors.appGreyWhite
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 3.h,
                              ),
                              const AppImageAsset(image: AppIcons.ic_home),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (context.isConnected) {
                                    _showLogoutDialog(context);
                                  } else {
                                    showSnackbarError("No Internet Connection.!");
                                  }
                                },
                                child: Icon(
                                  Icons.logout,
                                  size: 3.h,
                                  color: AppColors.appGreyBlack,
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  /// Logout Popup

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //    Image.asset(AppIcons.ic_confirm_logout, height: 5.h, color: AppColors.purple(context),),
              SizedBox(height: 3.h),

              Text(
                'Are you sure you want to log out?',
                style: TextStyle(fontSize: 1.8.t, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                        onTap: () {
                          context.read<AuthProvider>().logout(context);
                        },
                        color: Colors.red,
                        border: ButtonBorder(width: 0, color: Colors.red),
                        child: Center(
                            child: Txt(
                          "Logout",
                          fontSize: 1.7.t,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w400,
                        ))),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(
                    child: CustomElevatedButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                            child: Txt(
                          "Cancel",
                          fontSize: 1.7.t,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w400,
                        ))),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }
}
