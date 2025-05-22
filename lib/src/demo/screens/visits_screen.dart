import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/config/routes/app_router/route_params.dart';
import 'package:healthcare/core/common/widgets/app_image_assets.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/clients_list_response.dart';
import 'package:healthcare/core/network/network_checker_widget.dart';
import 'package:healthcare/core/utils/common_toast.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:healthcare/src/app_scaffold.dart';
import 'package:healthcare/src/demo/providers/visit_provider.dart';
import 'package:healthcare/src/home/providers/home_provider.dart';
import 'package:healthcare/src/home/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../config/routes/routes.dart';
import '../../../core/common/widgets/svg_image.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/image_constants.dart';
import '../../../core/data/models/response/clients_list_response.dart';
import '../../../core/helper/formatter.dart';
import '../../../core/helper/loader.dart';
import '../../auth/screens/select_agency_screen.dart';
import '../../details/screen/patient_details_screen.dart';
import '../../map_screen/screens/map_screen.dart';
import '../widgets/visits_info_widget.dart';

class DemoRoute extends AppScaffoldRoute {
  const DemoRoute({required this.id, required this.name, required this.location, this.client, required this.lat, required this.long, required this.phone, required this.avatar});

  final String id;
  final String name;
  final String location;
  final Client? client;
  final double? lat;
  final double? long;
  final String? phone;
  final String? avatar;

  @override
  Widget get screen => DemoScreen(params: this);

  @override
  Routes get routeName => Routes.demo;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class DemoScreen extends StatefulWidget {
  final DemoRoute params;

  const DemoScreen({super.key, required this.params});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> with AutomaticKeepAliveClientMixin<DemoScreen> {
  @override
  bool get wantKeepAlive => true;

  DateTime startDate = DateTime.now().subtract(const Duration(days: 3));

  List<Clients> clientData = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((p) async {
      showLoader(context);
      print(widget.params.id.toString());
      print("widget.params.id.toString()");
      await Provider.of<DemoProvider>(context, listen: false).visitsApi(context, id: widget.params.id.toString());
      await Provider.of<DemoProvider>(context, listen: false).clientDetailsApi(context,clientId: widget.params.client?.id.toString(),companyId: widget.params.client?.companyId.toString());
      final currTime = Formatter.stringFromDateTime(DateTime.now(), format: "yyyy-MM-dd");
      await Provider.of<DemoProvider>(context, listen: false).getDataDateWise(currTime.toString());
      await Provider.of<DemoProvider>(context, listen: false).serviceListApi(context);

      hideLoader();

      //  clientData = await loadClients() as List<Clients>;

      setState(() {});
    });
  }

  Future<List<Clients>> loadClients() async {
    // Load the JSON file
    final String response = await rootBundle.loadString('assets/json/client_data.json');
    // Decode the JSON data
    final List<dynamic> data = json.decode(response);
    // Map the JSON data to Client objects
    print("Data of Client  ${data.first}");
    return data.map((client) => Clients.fromJson(client)).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NetworkCheckerWidget(
      child: Consumer2<DemoProvider, HomeProvider>(builder: (context, visit, home, _) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColors.white),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 16),
                              child: Icon(
                                Icons.arrow_back,
                                size: 3.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 8.0, left: 8),
                              child: AppImageAsset(
                                image: AppIcons.logoSvg,
                                height: 26,
                                width: 98,
                              ),),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: GestureDetector(
                              onTap: () {
                                context.popUntil((route) => route.settings.name == Routes.home.path);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 1.w),
                                child: AppImageAsset(image: AppIcons.ic_home)
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 1.7.h,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                      // if (context.isConnected) {
                                      //   context.pushNamedAndRemoveUntil(const SelectAgencyRoute(), (r) => false);
                                      // } else {
                                      //   showSnackbarError("No Internet Connection.!");
                                      // }
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
                /*      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Txt(
                            "Agency : ",
                            fontSize: 2.t,
                            fontWeight: FontWeight.w600,
                          ),
                          Txt(
                            home.companyName ?? "",
                            fontSize: 2.t,
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                          )
                        ],
                      ),*/
                      SizedBox(
                        height: 1.5.h,
                      ),
                      SizedBox(
                        height: 34,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 60,
                          itemBuilder: (context, index) {
                            DateTime date = startDate.add(Duration(days: index));
                            bool isSelected = date.day == visit.selectedDate.day && date.month == visit.selectedDate.month && date.year == visit.selectedDate.year;
                            bool isToday = date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year;

                            return GestureDetector(
                              onTap: () async {
                                visit.setSelectedDate(date);

                                print("Selected Date ${visit.selectedDate}");
                                setState(() {});

                                await Provider.of<DemoProvider>(context, listen: false).getDataDateWise(visit.selectedDate.toString());
                              },
                              child: isSelected
                                  ? Container(
                                alignment: Alignment.center,
                                height: 24,
                                      decoration: BoxDecoration(
                                        color: isSelected ? AppColors.theme : Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: isSelected ? AppColors.theme : Colors.grey,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              isToday
                                                  ? const Txt(
                                                      "Today",
                                                      textColor: Colors.white,
                                                fontSize: 14,
                                                    )
                                                  : const SizedBox(),
                                              SizedBox(width: 2.w),
                                              Text(
                                                DateFormat('d').format(date),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: HurmeGeometricSans1,
                                                  color: isSelected ? AppColors.white : AppColors.appBlack,
                                                ),
                                              ),
                                              SizedBox(width: 2.w),
                                              Text(
                                                DateFormat('MMMM').format(date),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: HurmeGeometricSans1,
                                                  color: isSelected ? AppColors.white : AppColors.appBlack,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 45,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('d').format(date),
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: HurmeGeometricSans1,
                                                color: isSelected ? Colors.white : AppColors.appBlack,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      const Txt(
                        "Visit List",
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        textColor: AppColors.black,
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if(visit.visitData.isNotEmpty)...[
                                ...List.generate(
                                    visit.visitData.length,
                                        (index) => Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                                      child: GestureDetector(
                                          onTap: () async {
                                            showLoader(context);
                                            await Future.delayed(const Duration(milliseconds: 300));
                                            hideLoader();
                                            log('visit.visitData[index].id.toString() ${visit.visitData[index].toJson()}');
                                            await context.pushNamed(PatientDetailsScreenRoute(
                                                id: visit.visitData[index].id.toString(),
                                                clientId: widget.params.id,
                                                companyId: widget.params.client?.companyId.toString() ?? "",
                                                name: widget.params.name,
                                                // startTime: visit.visitData[index].scheduleStartTime.toString(),
                                                // endTime: visit.visitData[index].scheduleEndTime?.toString() ?? "",
                                                startTime: visit.visitData[index].adjInDateTime.toString(),
                                                endTime: visit.visitData[index].adjOutDateTime?.toString() ?? "",
                                                clientListResponse: ClientListResponse(),
                                                status: visit.visitData[index].status == "completed",
                                                imageUrl: widget.params.avatar ?? ""));
                                            //  await context.pushNamed(PatientDetailsScreenRoute(id:clientData[index].clientID ) );
                                          },
                                          child: Stack(
                                            children: [
                                              VisitsInfoWidget(
                                                name: widget.params.name ?? "",
                                                imageUrl: widget.params.avatar ?? "",
                                                startTime: visit.visitData[index].scheduleStartTime.toString() ?? "",
                                                endTime: visit.visitData[index].scheduleEndTime?.toString() ?? "",
                                                location: widget.params.location.toString() ?? "",
                                                status: visit.visitData[index].status.toString() ?? "",
                                              ),
                                              // Text('${visit.visitData[index].scheduleStartTime}')
                                            ],
                                          )),
                                    )),
                                SizedBox(height: 10.h),
                              ]
                              else...[
                                Padding(
                                  padding: EdgeInsets.only(top: 13.h, right: 10.w, left: 10.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(AppIcons.ic_no_data, scale: 0.1),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.h, right: 10.w, left: 10.w),
                                        child: Txt(
                                          "You do not have any visits on this day",
                                          fontSize: 2.5.t,
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center,
                                          textColor: AppColors.Primary,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          selectServiceBottomSheet(context, visit);
                                          //  showDateTimeBottomSheet(context, visit);
                                        },
                                        child: Txt(
                                          "Add Visit",
                                          fontSize: 1.8.t,
                                          fontWeight: FontWeight.bold,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, bottom: 3.w, top: 3.w,right: 3.w),
                              child: InkWell(
                                onTap: () async {
                                  if (context.isConnected) {
                                    await context.pushNamed(MapRoute(
                                        clientLat: widget.params.lat,
                                        // clientDetails?.clientAddress!.firstOrNull?.clientAddressLatitude?.toDouble(),
                                        clientLong: widget.params.long,
                                        //clientDetails?.clientAddress!.firstOrNull?.clientAddressLongitude?.toDouble(),
                                        address: widget.params.location,
                                        imageUrl: widget.params.avatar ?? ""));
                                  } else {
                                    showSnackbarError("No Internet Connection.!");
                                  }
                                },
                                child: Container(
                                  height: 58,
                                  width: 58,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          width: 1, color: const Color(0xffF1F1FF)),
                                      color: const Color(0xffF1F1FF) //Color(0xffF1F1FF),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.h),
                                    child: SvgImage(
                                      SvgIcons.location,
                                      fit: BoxFit.fitHeight,
                                      size: 0.5.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 3.w, bottom: 3.w, top: 3.w),
                              child: InkWell(
                                onTap: () async {
                                  final Uri phoneUri = Uri(scheme: 'tel', path: widget.params.phone); //
                                  try {
                                    await launchUrlString("tel://${widget.params.phone}");
                                  } catch (_) {}
                                },
                                child: Container(
                                  height: 58,
                                  width: 58,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          width: 1, color: const Color(0xffFFF7EB)),
                                      color: const Color(0xffFFF7EB)),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.h),
                                    child: SvgImage(
                                      SvgIcons.phone,
                                      fit: BoxFit.fill,
                                      size: 0.5.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              child: InkWell(onTap: () {
                                //   _showDateTimeDialog(context, visit);
                                //  showDateTimeBottomSheet(context,visit);
                                selectServiceBottomSheet(context, visit);
                                //    await visit.clientVisitsAddApi(companyId: widget.params.client?.companyId,employeeId:widget.params.client?.userId,sequenceID: widget.params.client?.sequenceId,clientId: int.parse(widget.params.client!.clientId.toString())  );

                              },
                                child: const AppImageAsset(image: AppIcons.ic_visits,
                                  height: 72,
                                  width: 72,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      /// Remove Calender
                      /*  Container(
                              height: 4.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 15,
                                itemBuilder: (context, index) {
                                  DateTime date = startDate.add(Duration(days: index));
                                  bool isSelected = date.day == selectedDate.day && date.month == selectedDate.month && date.year == selectedDate.year;
                                  bool isToday = date.day == DateTime.now().day &&
                                      date.month == DateTime.now().month &&
                                      date.year == DateTime.now().year;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedDate = date;
                                      });
                                    },
                                    child: isSelected
                                        ? Container(
                                      decoration: BoxDecoration(
                                        color: isSelected ? AppColors.theme : Colors.transparent,
                                        borderRadius: BorderRadius.circular(2.w),
                                        border: Border.all(
                                          color: isSelected ? Colors.blue : Colors.grey,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                            isToday ?   Txt(
                                                "Today",
                                                textColor: Colors.white,
                                              ) : SizedBox(),
                                              SizedBox(width: 2.w),
                                              Text(
                                                DateFormat('d').format(date),
                                                style: TextStyle(
                                                  fontSize: 1.6.t,
                                                  color: isSelected ? Colors.white : Colors.black,
                                                ),
                                              ),
                                              SizedBox(width: 2.w),
                                              Text(
                                                DateFormat('MMMM').format(date),
                                                style: TextStyle(
                                                  fontSize: 1.6.t,
                                                  color: isSelected ? Colors.white : Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                        : Container(
                                      width: 70,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('d').format(date),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: isSelected ? Colors.white : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),*/
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  /// Select Service

  Future<void> selectServiceBottomSheet(BuildContext context, DemoProvider visit) async {
    DateTime? startDateTime;
    DateTime? endDateTime;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Txt(
                    "Select Service",
                    fontSize: 2.2.t,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: visit.serviceList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            visit.selectService(index, visit.serviceList[index]);
                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                      width: 2.6.h,
                                      height: 2.6.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1.3.h),
                                        border: Border.all(color: Colors.black),
                                        color: AppColors.white,
                                      ),
                                      child: index == visit.selectedIndex
                                          ? Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                width: 1.2.h,
                                                height: 1.2.h,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(0.6.h),
                                                  color: AppColors.Primary,
                                                ),
                                              ),
                                            )
                                          : const SizedBox()),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Txt(
                                    visit.serviceList[index].name ?? "",
                                    fontSize: 2.2.t,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),

                /*  ListView.builder(
                      shrinkWrap: true,
                      itemCount: visit.payerList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            visit.selectClientPayerInfo(index, visit.payerList[index]);
                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                      width: 2.6.h,
                                      height: 2.6.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1.3.h),
                                        border: Border.all(color: Colors.black),
                                        color: AppColors.white,
                                      ),
                                      child: index == visit.selectedIndex
                                          ? Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                width: 1.2.h,
                                                height: 1.2.h,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(0.6.h),
                                                  color: AppColors.Primary,
                                                ),
                                              ),
                                            )
                                          : const SizedBox()),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Flexible(
                                    child: Txt(
                                      visit.payerList[index].payerID ?? "",
                                      fontSize: 2.2.t,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black,
                                      overFlow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),*/

                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          //showDateTimeBottomSheet(context, visit);
                          log('temps datta -->${widget.params.client!.id.toString()}');
                          log('temps datta -->${widget.params.client!.toJson()}');
                          await visit.clientVisitsAddApi(
                            context,
                            companyId: widget.params.client?.companyId?.toInt(),
                            sequenceID: widget.params.client?.sequenceId,
                            clientId: int.parse(widget.params.client!.id.toString()),

                            // endTime: endTime,
                          );
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(1.h),
                          child: const Text("Select Service"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Select Time
  ///
  Future<void> showDateTimeBottomSheet(BuildContext context, DemoProvider visit) async {
    DateTime? startDateTime;
    DateTime? endDateTime;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Txt(
                    "Select Visit Start and End Date & Time",
                    fontSize: 2.t,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Txt(
                        "Selected Service Name : ",
                        fontSize: 1.9.t,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                      ),
                      Txt(
                        visit.selectedService == null ? visit.serviceList.first.name ?? "" : visit.selectedService.name ?? "",
                        fontSize: 1.9.t,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? selectedDate = await _selectDate(context, DateTime.now());
                      if (selectedDate != null) {
                        TimeOfDay? selectedTime = await _selectTime(context, minTime: selectedDate.isSameDate(DateTime.now()) ? DateTime.now() : null);
                        if (selectedTime != null) {
                          setState(() {
                            startDateTime = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );

                            // Reset endDateTime if it is earlier than startDateTime
                            if (endDateTime != null && endDateTime!.isBefore(startDateTime!)) {
                              endDateTime = null;
                            }
                          });
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Text(
                        startDateTime == null ? "Select Start Date & Time" : "Start: ${DateFormat('yyyy-MM-dd hh:mm a').format(startDateTime!)}",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  /* ElevatedButton(
                      onPressed: startDateTime == null
                          ? null
                          : () async {
                              DateTime? selectedDate = await _selectDate(context, startDateTime!);
                              if (selectedDate != null) {
                                TimeOfDay? selectedTime = await _selectTime(
                                  context,
                                  minTime: selectedDate.isSameDate(startDateTime!) ? startDateTime : null,
                                );
                                if (selectedTime != null) {
                                  setState(() {
                                    endDateTime = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                    );
                                  });
                                }
                              }
                            },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Text(
                          endDateTime == null ? " Select End Date & Time " : "End: ${DateFormat('yyyy-MM-dd hh:mm a').format(endDateTime!)}",
                        ),
                      ),
                    ),
                    SizedBox(height: 16),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (startDateTime != null) {
                            Navigator.of(context).pop();
                            print("Start: ${DateFormat('yyyy-MM-dd HH:mm').format(startDateTime!)}");
                            // print("End: ${DateFormat('yyyy-MM-dd HH:mm').format(endDateTime!)}");

                            final startTime = DateFormat('yyyy-MM-dd HH:mm').format(startDateTime!);
                            // final endTime = DateFormat('yyyy-MM-dd HH:mm').format(endDateTime!);
                            await visit.clientVisitsAddApi(
                              context,
                              companyId: widget.params.client?.companyId?.toInt(),
                              sequenceID: widget.params.client?.sequenceId,
                              clientId: int.parse(widget.params.client!.id.toString()),
                              startTime: startTime,
                              // endTime: endTime,
                            );
                          } else {
                            showToast("Select Start and End Date");
                          }
                        },
                        child: const Text("Add Visit"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<DateTime?> _selectDate(BuildContext context, DateTime initialDate) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2100),
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context, {DateTime? minTime}) async {
    final now = DateTime.now();
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(minTime ?? now),
    );

    if (minTime != null && selectedTime != null) {
      final selectedDateTime = DateTime(
        minTime.year,
        minTime.month,
        minTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (selectedDateTime.isBefore(minTime)) {
        showToast("Cannot select a time earlier than the allowed time.");
        return null;
      }
    }

    return selectedTime;
  }
}

extension DateTimeExtensions on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
