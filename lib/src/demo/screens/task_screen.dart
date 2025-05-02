import 'package:flutter/material.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/constants/image_constants.dart';
import 'package:healthcare/core/utils/common_toast.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/src/demo/providers/visit_provider.dart';
import 'package:provider/provider.dart';

import '../../../config/routes/app_router/route_params.dart';
import '../../../config/routes/routes.dart';
import '../../../core/common/widgets/custom_elevated_button.dart';
import '../../../core/common/widgets/custom_text_field.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/data/models/requests/visits_reqs/clients_list_response.dart';
import '../../../core/helper/formatter.dart';
import '../../../core/network/network_checker_widget.dart';
import '../../../core/utils/devlog.dart';
import '../../../core/utils/gap.dart';
import '../../../core/utils/text.dart';
import '../../auth/providers/auth_provider.dart';

class TaskRoute implements BaseRoute {
  final String? name;
  final String? visitID;
  final ClientListResponse clientListResponse;

  const TaskRoute({this.name, required this.clientListResponse,required this.visitID});

  @override
  Widget get screen => TaskScreen(params: this);

  @override
  Routes get routeName => Routes.task;

  @override
  TransitionType get type => AppConsts.transitionType;
}

class TaskScreen extends StatefulWidget {
  final TaskRoute params;

  const TaskScreen({super.key, required this.params});

  @override
  State<TaskScreen> createState() => _TaskScreen();
}

class _TaskScreen extends State<TaskScreen> {
  late AuthProvider provider;

  List<String> statusList = ["Task Completed","Client Refused"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((p) async {

      await Provider.of<DemoProvider>(context, listen: false).clearData();

    });

    provider = context.read<AuthProvider>();
    devlog('--> --> --> DemoScreen__CALLED <-- <-- <--');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = context.read<AuthProvider>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkCheckerWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: AppColors.Primary),
        ),
        body: DefaultTabController(
          length: 1,
          child: Column(
            children: [
              VGap(2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.ic_demo_img,
                      height: 10.h,
                      width: 10.h,
                      fit: BoxFit.cover,
                    ),
                    HGap(4.w),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(
                            widget.params.name ?? "",
                            fontSize: 2.2.t,
                            fontWeight: FontWeight.w500,
                          ),
                          VGap(0.5.h),
                          RichText(
                            text: TextSpan(
                              text: "Clock In : ",
                              style: TxtStyle(fontSize: 2.t, fontWeight: FontWeight.w600),
                              children: [TextSpan(text: "${Formatter.stringFromDateTime(DateTime.now(), format: "hh:mm a")}", style: TxtStyle(fontWeight: FontWeight.w400))],
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              VGap(2.h),
              TabBar(labelColor: AppColors.Primary, labelStyle: TextStyle(fontSize: 2.2.t, fontWeight: FontWeight.bold), indicatorColor: AppColors.Primary, tabs: const [
                Tab(text: "Task"),

              ]),
              Expanded(
                child: TabBarView(
                  children: [_TaskFragment(clientListResponse: widget.params.clientListResponse,visitId: widget.params.visitID ?? "",)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskFragment extends StatefulWidget {
  const _TaskFragment({required this.clientListResponse,required this.visitId});
  final ClientListResponse clientListResponse;
  final String visitId;
  @override
  State<_TaskFragment> createState() => _TaskFragmentState();
}

class _TaskFragmentState extends State<_TaskFragment> {
  TextEditingController? taskctr;

  @override
  void initState() {
    taskctr = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkCheckerWidget(
      child: Consumer<DemoProvider>(builder: (context, visit, _) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            children: [
              /* VGap(2.h),
                CustomTextField(
                  ctr: taskctr,
                  hintText: "Add Task..",
                  lines: 5,
                ),*/
              VGap(2.h),
              CustomElevatedButton(
                onTap: () async {
                  //if (taskctr?.text != "") showToast("Task submit successfully");


                  await visit.taskListApi(context,companyId: await visit.getCompanyId() ?? "",clientId:widget.clientListResponse.client?.clientId );
                  // BottomSheetUtils.showTaskListSheet(context, visit.taskNames);
                },
                height: 6.h,
                alignment: Alignment.center,
                color: AppColors.white,
                child: Center(
                  child: Txt(
                    "Select Task",
                    fontSize: 2.2.t,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.Primary,
                  ),
                ),
              ),
              VGap(2.h),
              Expanded(
                child: ListView(
                  children: [
                    Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),boxShadow:const [BoxShadow(color: Colors.grey,blurRadius: 6)]),margin: EdgeInsets.all(2.w),
                      child: Visibility(
                        visible: visit.selectedTaskNames.isNotEmpty,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: visit.selectedTaskNames.length,
                          // separatorBuilder: (context, index) => Divider(
                          //   thickness: 0.5,
                          //   height: 0,
                          //   color: AppColors.grey,
                          // ),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CheckboxListTile(
                                  onChanged: (e) {
                                    if (visit.finalSelectedTaskNames.contains(visit.selectedTaskNames[index])) {
                                      visit.finalSelectedTaskNames.remove(visit.selectedTaskNames[index]);
                                    } else {
                                      visit.finalSelectedTaskNames.add(visit.selectedTaskNames[index]);
                                    }
                                    print("Selected task ${visit.selectedTaskNames}");
                                    setState(() {});
                                  },
                                  value: visit.finalSelectedTaskNames.contains(visit.selectedTaskNames[index]),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  title: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h),
                                    child: Txt(visit.selectedTaskNames[index], fontSize: 2.t),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                onTap: () async {
                  //if (taskctr?.text != "") showToast("Task submit successfully");
      
                  if (visit.selectedTaskNames.isNotEmpty) {
                    if (visit.finalSelectedTaskNames.isNotEmpty) {
                      await visit.visitTaskAddApi(context,clientId: widget.clientListResponse.client?.id.toString(),companyId:widget.clientListResponse.client?.companyId.toString(),visitId:widget.visitId);
                    }else{
                      showToast("Please select at list one task.");
                    }
      
                  }else{
                    showToast("Please select at list one task.");
                  }
      
      
                  // setState(() {});
                },
                height: 6.h,
                color: AppColors.Primary,
                child: Center(
                  child: Txt(
                    "Add Task",
                    fontSize: 2.t,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.white,
                  ),
                ),
              ),
              VGap(2.h),
            ],
          ),
        );
      }),
    );
  }
}

class _AboutFragment extends StatefulWidget {
  const _AboutFragment();

  @override
  State<_AboutFragment> createState() => _AboutFragmentState();
}

class _AboutFragmentState extends State<_AboutFragment> {
  TextEditingController? notectr;

  @override
  void initState() {
    notectr = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DemoProvider>(builder: (context, visit, _) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: ListView(
          children: [
            VGap(2.h),
            CustomTextField(
              ctr: notectr,
              hintText: "Add Note",
              lines: 5,
            ),
            VGap(2.h),
            CustomElevatedButton(
              onTap: () async {
                // if (notectr?.text != "") showToast("Note submit successfully");
                await visit.clientVisitsAddApi(context);
                notectr?.clear();
                setState(() {});
              },
              height: 5.h,
              color: AppColors.Primary,
              child: Center(
                child: Txt(
                  "Complete Visit",
                  fontSize: 2.t,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white,
                ),
              ),
            ),
            VGap(2.h),
          ],
        ),
      );
    });
  }
}
