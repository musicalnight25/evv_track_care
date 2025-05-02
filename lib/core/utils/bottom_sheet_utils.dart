import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/core/utils/gap.dart';
import 'package:healthcare/core/utils/size_config.dart';
import 'package:healthcare/core/utils/text.dart';
import 'package:provider/provider.dart';

import '../../src/demo/providers/visit_provider.dart';
import '../common/widgets/custom_elevated_button.dart';
import '../constants/color_constants.dart';
import 'common_toast.dart';

class BottomSheetUtils {
  static Future<void> showTaskListSheet(BuildContext ct, List<String> nameList,String clientId,String companyId,String visitId) async {
    showModalBottomSheet(
      context: ct,
      backgroundColor: AppColors.white,
      // scrollControlDisabledMaxHeightRatio: 0.8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (BuildContext ct) {
        return TaskListSheet(
          nameList: nameList,
          clientId: clientId,
          companyId: companyId,
          visitId: visitId,
        );
      },
    );
  }
}

class TaskListSheet extends StatefulWidget {
  const TaskListSheet({super.key, required this.nameList,required this.clientId,required this.companyId,required this.visitId});

  final List<String> nameList;
  final String clientId;
  final String companyId;
  final String visitId;

  @override
  State<TaskListSheet> createState() => _TaskListSheetState();
}

class _TaskListSheetState extends State<TaskListSheet> {
  List<String> selectedTask = [];
  // List<int> selectedIndex = [];
  int selectedIndex = -1;
  String selectedTaskName = "";

  selectName(int index, String select) async {
    selectedIndex = index;
    selectedTaskName = select;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<DemoProvider>(builder: (context, visit, _) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VGap(1.5.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        "Task List",
                        fontSize: 2.2.t,
                        fontWeight: FontWeight.w600,
                      ),
                      VGap(0.1.h),
                      Txt(
                        "Select your tasks",
                        fontSize: 1.6.t,
                        textColor: AppColors.grey,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.clear,
                    color: AppColors.black,
                    size: 4.r,
                  ),
                ),
              ],
            ),
            VGap(2.h),
            Expanded(
              child: ListView.separated(
                itemCount: widget.nameList.length,
                separatorBuilder: (context, index) => const Divider(
                  thickness: 0.5,
                  height: 0,
                  color: AppColors.grey,
                ),
                itemBuilder: (context, index) {
                  final currentItem = widget.nameList[index];
                  final isDisabled = selectedTask.contains(currentItem);
                  return GestureDetector(onTap: () {
                    selectName(index, widget.nameList[index]);
                    selectedTask.clear();
                    selectedTask.add(widget.nameList[index]);
                    log("Selected task ${widget.nameList[index]}");
                  },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
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
                              child: index == selectedIndex
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
                              widget.nameList[index] ?? "",
                              fontSize: 2.2.t,
                              fontWeight: FontWeight.w400,
                              textColor: Colors.black,
                              maxLines: 2,
                              overFlow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                   /* CheckboxListTile(
                    onChanged: (e) {
                      if (selectedTask.contains(widget.nameList[index])) {
                        selectedTask.remove(widget.nameList[index]);
                      } else {
                        selectedTask.add(widget.nameList[index]);
                      }
                      print("Selected task $selectedTask");
                      setState(() {});
                    },
                    value: selectedTask.contains(widget.nameList[index]),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Txt(widget.nameList[index], fontSize: 2.t),
                    ),
                  );*/
                },
              ),
            ),
            VGap(1.h),
            CustomElevatedButton(
              onTap: () async {
              /*
                if (selectedTask.isNotEmpty) {
                 await visit.visitTaskAddApi(context, clientId: widget.clientId, companyId: widget.companyId.toString(), visitId: widget.visitId);

                } else {
                  showToast("Please select at list one task.");
                }*/


                await visit.setSelectedTask(selectedTask);
                if(selectedIndex != -1){
                  await visit.visitTaskAddApi(context,
                      clientId: widget.clientId,
                      companyId: widget.companyId.toString(),
                      visitId: widget.visitId);
                }else {
                  showToast("Please select at list one task.");
                }
                context.pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Txt(
                      "Done",
                      fontSize: 1.8.t,
                      textColor: AppColors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            VGap(1.5.h),
          ],
        ),
      );
    });
  }
}
