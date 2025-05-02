import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/config/routes/app_router/route_params.dart';
import 'package:healthcare/core/common/widgets/custom_elevated_button.dart';
import 'package:healthcare/core/common/widgets/custom_image.dart';
import 'package:healthcare/core/common/widgets/svg_image.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/constants/image_constants.dart';
import 'package:healthcare/core/data/models/response/clients_details_response.dart';
import 'package:healthcare/core/network/network_checker_widget.dart';
import 'package:healthcare/core/utils/common_toast.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/src/auth/providers/auth_provider.dart';
import 'package:healthcare/src/demo/providers/visit_provider.dart';
import 'package:healthcare/src/details/provider/patient_details_provider.dart';
import 'package:healthcare/src/details/screen/sign_or_record_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../config/routes/routes.dart';
import '../../../core/data/models/requests/visits_reqs/clients_list_response.dart';
import '../../../core/helper/formatter.dart';
import '../../../core/helper/loader.dart';
import '../../../core/utils/bottom_sheet_utils.dart';
import '../../../core/utils/gap.dart';
import '../../home/providers/home_provider.dart';

class PatientDetailsScreenRoute implements BaseRoute {
  const PatientDetailsScreenRoute(
      {required this.id,
      required this.clientId,
      required this.companyId,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.clientListResponse,
      required this.status,
      required this.imageUrl});

  final String id;
  final String clientId;
  final String companyId;
  final String name;
  final String imageUrl;
  final String startTime;
  final String endTime;
  final bool status;
  final ClientListResponse clientListResponse;

  @override
  Widget get screen => PatientDetailsScreen(params: this);

  @override
  Routes get routeName => Routes.patient;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class PatientDetailsScreen extends StatefulWidget {
  final PatientDetailsScreenRoute params;

  const PatientDetailsScreen({super.key, required this.params});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> with AutomaticKeepAliveClientMixin<PatientDetailsScreen> {
  @override
  bool get wantKeepAlive => true;

  bool firstBox = false;
  bool secondBox = false;
  bool thirdBox = false;
  bool fourthBox = false;

  bool firstBoxCheck = false;
  bool secondBoxCheck = false;
  bool thirdBoxCheck = false;
  bool fourthBoxCheck = false;

  String? time1 = "07:30";
  String? time2 = "08:30";
  String? time3 = "09:00";
  String? time4 = "10:15";
  String? finalTime = "";

  List<ClientDetails> allClientsDetails = [];

  // ClientDetails? clientDetails;
  ClientListResponse? clientDetails;
  String? endTime;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((p) async {
      showLoader(context);
      await Provider.of<PatientDetailsProvider>(context, listen: false).clearData(widget.params.status);
      await Provider.of<PatientDetailsProvider>(context, listen: false).visitDetailsApi(visitId: widget.params.id);
      if (widget.params.endTime.isNotEmpty) {
        endTime = widget.params.endTime;
      }
      hideLoader();
    });
  }

  ClientDetails? getClientDetails(List<ClientDetails> clients, String clientId) {
    return clients.firstWhere((client) => client.clientID == clientId);
  }

  Future<List<ClientDetails>> loadClientsDetails() async {
    // Load the JSON file
    final String response = await rootBundle.loadString('assets/json/clients_details.json');
    // Decode the JSON data
    final List<dynamic> data = json.decode(response);
    // Map the JSON data to Client objects
    print("Data of Client  ${data.first}");
    return data.map((client) => ClientDetails.fromJson(client)).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NetworkCheckerWidget(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer4<PatientDetailsProvider, DemoProvider, HomeProvider, AuthProvider>(builder: (context, patient, visit, home, auth, _) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 3.4.h,
                                width: 3.4.h,
                                color: AppColors.bgColor,
                                child: const Icon(Icons.keyboard_arrow_left),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.popUntil((route) => route.settings.name == Routes.home.path);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 1.w),
                                child: Icon(
                                  Icons.home_filled,
                                  size: 3.h,
                                  color: AppColors.Primary,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      CustomImage(
                        url: widget.params.imageUrl != ""
                            ? "${auth.getImageBaseUrl().toString()}/images/avatars/${widget.params.imageUrl}"
                            : "${auth.getImageBaseUrl().toString()}/avatars.jpg",
                        height: 13.h,
                        width: 13.h,
                        fit: BoxFit.cover,
                      ),
                      /*  Image.asset(
                        AppImages.ic_demo_img,
                        height: 13.h,
                        width: 13.h,
                        fit: BoxFit.cover,
                      ),*/
                      VGap(2.h),
                      // Txt("${clientDetails?.client?.clientFirstName} ${clientDetails?.client?.clientMiddleInitial} ${clientDetails?.client?.clientLastName}", fontSize: 2.2.t, fontWeight: FontWeight.w600),
                      Txt(widget.params.name, fontSize: 2.2.t, fontWeight: FontWeight.w600),
                      VGap(0.3.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.hint_text_color_dark,
                            size: 2.2.h,
                          ),
                          HGap(1.w),
                          /*  Txt(clientDetails?.visitTime?.firstOrNull?.scheduleStartTime == null ? "--" :"${Formatter.stringDateFromString(clientDetails?.visitTime?.firstOrNull?.scheduleStartTime.toString(), reqFormat: "yyyy-MM-dd HH:mm:ss", resFormat: "HH:mm:a")} - ${Formatter.stringDateFromString(clientDetails?.visitTime?.firstOrNull?.scheduleEndTime.toString(), reqFormat: "yyyy-MM-dd HH:mm:ss", resFormat: "HH:mm:a")}",
                                fontSize: 1.7.t, textColor: AppColors.hint_text_color_dark, fontWeight: FontWeight.w400),*/
                          Txt(
                              patient.startTime == null
                                  ? "--"
                                  : "${Formatter.stringDateFromString(patient.startTime.toString().toString(), reqFormat: "yyyy-MM-dd HH:mm:ss", resFormat: "hh:mm:a")} ${patient.endTime == null ? "-" : Formatter.stringDateFromString(patient.endTime.toString().toString(), reqFormat: "yyyy-MM-dd HH:mm:ss", resFormat: "hh:mm:a")}",
                              fontSize: 1.7.t,
                              textColor: AppColors.hint_text_color_dark,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      VGap(0.3.h),
                      //  if(home.clientData[0].providerIdentification?.name != null)

                      Row(
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
                      ),
                      VGap(0.3.h),
                      if (patient.service != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Txt(
                              "Service : ",
                              fontSize: 2.t,
                              fontWeight: FontWeight.w600,
                            ),
                            Txt(
                              patient.service?.name ?? "",
                              fontSize: 2.t,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black,
                            )
                          ],
                        ),

                      VGap(0.8.h),

                      VGap(2.h),
                      Visibility(
                        visible: patient.taskData.isNotEmpty,
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ...List.generate(
                                    patient.taskData.length,
                                    (index) => Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(3.w),
                                              color: const Color(0xffF7F8F9),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w), color: AppColors.home_card_color),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        HGap(1.w),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Txt(
                                                                patient.taskData[index].taskReading ?? "",
                                                                fontSize: 2.2.t,
                                                                fontWeight: FontWeight.w600,
                                                                maxLines: 2,
                                                                textAlign: TextAlign.start,
                                                              ),
                                                              VGap(0.5.h),
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Icon(
                                                                    Icons.watch_later_outlined,
                                                                    color: AppColors.hint_text_color_dark,
                                                                    size: 2.2.h,
                                                                  ),
                                                                  HGap(1.w),
                                                                  Txt("${Formatter.stringDateFromString(patient.taskData[index].createdAt.toString(), reqFormat: "yyyy-MM-dd' 'HH:mm:ss.SSS", resFormat: "hh:mm:a")}",
                                                                      fontSize: 1.7.t, textColor: AppColors.hint_text_color_dark, fontWeight: FontWeight.w400),
                                                                ],
                                                              ),
                                                              //   VGap(0.5.h),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                AnimatedSize(
                                                  duration: const Duration(milliseconds: 300),
                                                  child: Visibility(
                                                    visible: firstBox,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 1.5.h,
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(2.5.w),
                                                            border: Border.all(width: 0, color: const Color(0xff009DE0).withOpacity(0.06)),
                                                            color: const Color(0xff009DE0).withOpacity(0.06),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(3.5.h),
                                                            child: SvgImage(
                                                              SvgIcons.bathroom,
                                                              fit: BoxFit.fill,
                                                              size: 0.5.h,
                                                              color: AppColors.Primary,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.5.h,
                                                        ),
                                                        Txt(
                                                          time1 ?? "",
                                                          textColor: AppColors.grey,
                                                        ),
                                                        SizedBox(
                                                          height: 1.5.h,
                                                        ),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              width: 30.w,
                                                              decoration: BoxDecoration(border: Border.all(width: 1, color: AppColors.grey), borderRadius: BorderRadius.circular(8.w)),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                                                child: const Icon(
                                                                  Icons.close,
                                                                  color: AppColors.grey,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (!firstBoxCheck) {
                                                                  showLoader(context);
                                                                  await Future.delayed(const Duration(milliseconds: 600));
                                                                  hideLoader();
                                                                }

                                                                firstBoxCheck = true;
                                                                setState(() {});
                                                              },
                                                              child: Container(
                                                                width: 30.w,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(width: 1, color: firstBoxCheck ? AppColors.Primary : AppColors.grey), borderRadius: BorderRadius.circular(8.w)),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                                                  child: Icon(
                                                                    Icons.done,
                                                                    color: firstBoxCheck ? AppColors.Primary : AppColors.grey,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                firstBox
                                                    ? SizedBox(
                                                        height: 3.h,
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          ),
                                        )),
                              ],
                            ),
                          ),
                        ),
                      ),

                      VGap(2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: !patient.statusData && patient.taskData.isNotEmpty,
                              child: Expanded(
                                child: CustomElevatedButton(
                                  alignment: Alignment.center,
                                  onTap: () async {
                                    if (patient.statusData) {
                                      showToast("Visit is already completed");
                                    } else {
                                      if (patient.startTime == null) {
                                        showDateTimeBottomSheetstart(context);
                                      } else if (patient.endTime == null) {
                                        showDateTimeBottomSheet(context, patient.startTime);
                                      } else if (patient.startTime != null && patient.endTime != null) {
                                        await context.pushNamed(SignOrRecordRoute(id: widget.params.id, clientid: widget.params.clientId, endTime: patient.endTime.toString()));
                                      }
                                    }
                                  },
                                  color: patient.statusData ? Colors.green.shade800 : AppColors.Primary,
                                  child: Padding(
                                    padding: EdgeInsets.all(1.8.h),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Txt(
                                          patient.startTime == null
                                              ? "Start Time"
                                              : patient.endTime == null
                                                  ? "End Time"
                                                  : "Visit Complete",
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.white,
                                          fontSize: 2.t,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            HGap(2.w),
                            Expanded(
                              child: CustomElevatedButton(
                                alignment: Alignment.center,
                                onTap: () async {
                                  if (patient.statusData) {
                                    showToast("Visit Already Completed");
                                  } else {
                                    await visit.taskListApi(context, companyId: widget.params.companyId, clientId: widget.params.clientId);

                                    await BottomSheetUtils.showTaskListSheet(context, visit.taskNames, widget.params.clientId, widget.params.companyId, widget.params.id);
                                  }
                                },
                                color: patient.statusData ? Colors.green.shade800 : AppColors.Primary,
                                child: Padding(
                                  padding: EdgeInsets.all(1.8.h),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SvgImage(SvgIcons.home),
                                      HGap(4.w),
                                      Txt(
                                        patient.statusData ? "Visit Completed" : "Add Tasks",
                                        fontWeight: FontWeight.w600,
                                        textColor: Colors.white,
                                        fontSize: 2.t,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            /* HGap(5.w),
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.5.w), border: Border.all(width: 1, color: Color(0xffF4F5F9)), color: Color(0xffF4F5F9)),
                                child: Padding(
                                  padding: EdgeInsets.all(2.4.h),
                                  child: Icon(
                                    Icons.watch_later_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              )*/
                          ],
                        ),
                      ),

                      // ...List.generate(4, (index) => Padding(
                      //   padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.8.h),
                      //   child: GestureDetector(onTap: () {
                      //   //  context.pushNamed(PatientDetailsScreenRoute());
                      //   },child: PatientDetailsWidget()),
                      // )),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // closeAllBox(){
  //   firstBox = false;
  //   secondBox = false;
  //   thirdBox = false;
  //   fourthBox = false;
  //
  // }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w))),
      context: context,
      builder: (BuildContext ctx) {
        return SizedBox(
          // height: 60.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 8.h,
              ),
              Txt(
                "Set your start time",
                fontWeight: FontWeight.bold,
                fontSize: 2.t,
              ),
              SizedBox(
                height: 2.h,
              ),
              Txt(
                "Pick a time of the day, when you would \nstart working and you can stop when \nyou are done",
                fontSize: 1.6.t,
                textAlign: TextAlign.center,
                textColor: AppColors.grey,
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt(
                    "09:45",
                    fontSize: 2.4.t,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                  HGap(1.w),
                  Txt(
                    "AM",
                    fontSize: 2.2.t,
                    textAlign: TextAlign.center,
                    textColor: AppColors.grey,
                  ),
                ],
              ),
              VGap(2.h),
              SizedBox(
                  height: 15.h,
                  width: 100.w,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime newDate) {
                      print("new data : ${newDate.hour} : ${newDate.minute}");
                      finalTime = "${newDate.hour}:${newDate.minute}";
                      setState(() {});
                    },
                  )),
              SizedBox(
                height: 2.h,
              ),
              CustomElevatedButton(
                width: 50.w,
                onTap: () {
                  if (firstBox) {
                    time1 = finalTime;
                  } else if (secondBox) {
                    time2 = finalTime;
                  } else if (thirdBox) {
                    time3 = finalTime;
                  } else {
                    time4 = finalTime;
                  }
                  setState(() {});
                  Navigator.pop(context);
                },
                color: AppColors.Primary,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 3.w),
                  child: Txt(
                    "Start",
                    textAlign: TextAlign.center,
                    textColor: Colors.white,
                    fontSize: 1.9.t,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Select Time
  ///
  Future<void> showDateTimeBottomSheet(BuildContext context, DateTime? startdate) async {
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
                    "Select Visit End Time",
                    fontSize: 2.t,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      // DateTime? selectedDate =
                      //     await _selectDate(context, startdate!);
                      // if (selectedDate != null) {
                      TimeOfDay? selectedTime = await _selectTime(context, minTime: startdate);
                      if (selectedTime != null) {
                        setState(() {
                          startDateTime = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );

                          // Reset endDateTime if it is earlier than startDateTime
                          if (endDateTime != null && endDateTime!.isBefore(startDateTime!)) {
                            endDateTime = null;
                          }
                        });
                      }
                      // }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Text(
                        startDateTime == null ? "Select End Time" : "End: ${DateFormat('yyyy-MM-dd hh:mm a').format(startDateTime!)}",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                            //  print("Start: ${DateFormat('yyyy-MM-dd HH:mm').format(startDateTime!)}");
                            // print("End: ${DateFormat('yyyy-MM-dd HH:mm').format(endDateTime!)}");

                            // final startTime = DateFormat('yyyy-MM-dd HH:mm').format(startDateTime!);

                            final endTime = DateFormat('yyyy-MM-dd HH:mm').format(startDateTime!);
                            await Provider.of<DemoProvider>(context, listen: false).visitEndApi(visitId: widget.params.id.toString(), endTime: endTime);
                            await Provider.of<PatientDetailsProvider>(context, listen: false).visitDetailsApi(visitId: widget.params.id);

                            Navigator.of(context).pop();
                            //await context.pushNamed(SignOrRecordRoute(id: widget.params.id, clientid: widget.params.clientId,endTime: endTime));
                          } else {
                            showToast("Select End Date & Time");
                          }
                        },
                        child: const Text("End Visit"),
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
      initialTime: TimeOfDay.fromDateTime(now),
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

  /// Select Time
  ///
  Future<void> showDateTimeBottomSheetstart(BuildContext context) async {
    DateTime? startDateTime = DateTime.now();
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
                    "This is your start time for this task",
                    fontSize: 2.t,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Txt(
                  //       "Selected Service Name : ",
                  //       fontSize: 1.9.t,
                  //       textAlign: TextAlign.center,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     Txt(
                  //       "${visit.selectedService == null ? visit.serviceList.first.name ?? "" : visit.selectedService.name ?? ""}",
                  //       fontSize: 1.9.t,
                  //       textAlign: TextAlign.center,
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.black)),
                    margin: EdgeInsets.all(2.w),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
                      child: Text(
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        startDateTime == null ? "Select Start Date & Time" : DateFormat('hh:mm a').format(startDateTime),
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
                          print("Start: ${DateFormat('yyyy-MM-dd HH:mm').format(startDateTime)}");
                          // print("End: ${DateFormat('yyyy-MM-dd HH:mm').format(endDateTime!)}");

                          final startTime = DateFormat('yyyy-MM-dd HH:mm').format(startDateTime);
                          // final endTime = DateFormat('yyyy-MM-dd HH:mm').format(endDateTime!);
                          await Provider.of<DemoProvider>(context, listen: false).visitStartApi(visitId: widget.params.id, startTime: startTime);
                          await Provider.of<PatientDetailsProvider>(context, listen: false).visitDetailsApi(visitId: widget.params.id);
                          Navigator.of(context).pop();
                                                },
                        child: const Text("Start Visit"),
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

  Future<DateTime?> _selectDatestart(BuildContext context, DateTime initialDate) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2100),
    );
  }

  Future<TimeOfDay?> _selectTimestart(BuildContext context, {DateTime? minTime}) async {
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
