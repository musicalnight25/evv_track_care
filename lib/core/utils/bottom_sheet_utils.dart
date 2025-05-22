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
                      const Txt(
                        "Task List",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                      VGap(0.1.h),
                      const Txt(
                        "Select your tasks",
                        fontSize: 16,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w400,
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
                separatorBuilder: (context, index) => const SizedBox(height: 12,),
                itemBuilder: (context, index) {
                  final currentItem = widget.nameList[index];
                  final isDisabled = selectedTask.contains(currentItem);
                  return visit.taskDataTemp != null && visit.taskDataTemp!.taskName == widget.nameList[index]
                      ? const SizedBox()
                      : GestureDetector(onTap: () {
                    selectName(index, widget.nameList[index]);
                    selectedTask.clear();
                    selectedTask.add(widget.nameList[index]);
                    log("Selected task ${widget.nameList[index]}");
                  },
                    child: Container(
                      height: 82,
                      decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w),
                        child: Row(
                          children: [
                            Container(
                                width: 49,
                                height: 49,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  color: AppColors.theme,
                                ),),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                              child: Txt(
                                widget.nameList[index] ?? "",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                                maxLines: 2,
                                overFlow: TextOverflow.ellipsis,
                              ),
                            ),
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
                          ],
                        ),
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
            VGap(1.6.h),
            CustomElevatedButton(
              height: 54,
              onTap: () async {
              /*
                if (selectedTask.isNotEmpty) {
                 await visit.visitTaskAddApi(context, clientId: widget.clientId, companyId: widget.companyId.toString(), visitId: widget.visitId);

                } else {
                  showToast("Please select at list one task.");
                }*/

                visit.selectTempTask(selectedTaskName);
                await visit.setSelectedTask(selectedTask);
                if(selectedIndex != -1){
                  // await visit.visitTaskAddApi(context,
                  //     clientId: widget.clientId,
                  //     companyId: widget.companyId.toString(),
                  //     visitId: widget.visitId);
                }else {
                  showToast("Please select at list one task.");
                }
                context.pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt(
                    "Done",
                    fontSize: 16,
                    textColor: AppColors.white,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            VGap(2.h),
          ],
        ),
      );
    });
  }
}
