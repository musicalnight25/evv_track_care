import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as getx;
import 'package:healthcare/config/data/dio/dio_client.dart';
import 'package:healthcare/core/common/widgets/custom_elevated_button.dart';
import 'package:healthcare/core/constants/color_constants.dart';
import 'package:healthcare/core/data/models/requests/profile_reqs/get_clients_details_req.dart';

import 'package:healthcare/core/data/models/requests/visits_reqs/client_visits_task_add_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/complete_visit_req.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/service_list_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/start_visit_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/task_list_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/visit_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/visits_request.dart';
import 'package:healthcare/core/data/models/response/api_response/client_details_response.dart';
import 'package:healthcare/core/data/models/response/api_response/client_visit_task_add_response.dart';
import 'package:healthcare/core/data/models/response/api_response/service_list_reaponse.dart';
import 'package:healthcare/core/data/models/response/api_response/visit_data_response.dart';
import 'package:healthcare/core/data/models/response/api_response/visit_status_response.dart';
import 'package:healthcare/core/data/models/response/client_visits_response.dart';
import 'package:healthcare/core/data/models/response/task_list_response.dart';
import 'package:healthcare/core/data/repos/visits_repos/visits_repo.dart';
import 'package:healthcare/core/helper/remote_config_helper.dart';
import 'package:healthcare/core/utils/text.dart';
import '../../../../config/data/dio/content_types.dart';
import '../../../../config/error/exceptions.dart';
import '../../../constants/api_constants.dart';
import '../../../helper/api_error_handler.dart';
import '../../models/requests/visits_reqs/client_visits_add_request.dart';
import '../../models/requests/visits_reqs/visits_status_request.dart';
import '../../models/response/api_response/client_visit_add_response.dart';
import '../../models/response/base/api_response.dart';

class VisitsRepoImpl implements VisitsRepo {
  final DioClient _dioClient;

  VisitsRepoImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<ClientVisitsResponse?> VisitsDetails(VisitsRequest req) async {
    try {
      final res = await _dioClient.post(
        Apis.clientsVisitsSearch,
        data: req.toJson(),
        contentType: CType.json,
      );

      // Casting the response data to List<VisitDataResponse>
      if (res.data != null) {
        final ClientVisitsResponse modelResponse = ClientVisitsResponse.fromJson(res.data); //(res.data as List).map((e) => ClientVisitsResponse.fromJson(e as Map<String, dynamic>)).toList();
        return modelResponse;
      } else {
        throw const ServerException("Invalid data format.");
      }
    } on ServerException catch (e) {
      // Re-throwing ServerException with its original message
      throw ServerException(e.message);
    } catch (e,st) {
      // Generic error handling with logging
      print("Error: $e---$st");
      throw const ServerException("Something went wrong.");
    }
  }

  @override
  Future<ClientVisitAddResponse> ClientVisitAdd(ClientVisitsAddRequest req) async {
    try {
      final res = await _dioClient.post(
        Apis.clientVisitsadd,
        data: req.toJson(),
        contentType: CType.json,
      );

      // Casting the response data to List<VisitDataResponse>
      //if (res.data != null && res.data is List) {
      final ClientVisitAddResponse modelResponse = ClientVisitAddResponse.fromJson(res.data ?? {});
      //  final List<ClientVisitAddResponse> modelResponse = (res.data as List).map((e) => ClientVisitAddResponse.fromJson(e as Map<String, dynamic>)).toList();
      return modelResponse;
      // } else {
      throw const ServerException("Invalid data format.");
      // }
    } on ServerException catch (e) {
      // Re-throwing ServerException with its original message
      throw ServerException(e.message);
    } catch (e,st) {
      // Generic error handling with logging
      print("Error: $e--$st");
      throw const ServerException("Something went wrong.");
    }
  }

  @override
  Future<ClientVisitTaskAddResponse> ClientVisitTaskAdd(ClientVisitsTaskAddRequest req) async {
    try {
      final res = await _dioClient.post(
        Apis.clientVisitTaskAdd,
        data: req.toJson(),
        contentType: CType.json,
      );

      // Casting the response data to List<VisitDataResponse>

      final ClientVisitTaskAddResponse modelResponse = ClientVisitTaskAddResponse.fromJson(res.data ?? {});
      return modelResponse;
    } on ServerException catch (e) {
      // Re-throwing ServerException with its original message
      throw ServerException(e.message);
    } catch (e) {
      // Generic error handling with logging
      print("Error: $e");
      throw const ServerException("Something went wrong.");
    }
  }

  @override
  Future<TaskListsResponse> TaskList(TaskListRequest req) async {
    try {
      final res = await _dioClient.post(
        Apis.taskList,
        data: req.toJson(),
        contentType: CType.json,
      );
      log('res0---->: ${res.data['services'].length}');
      // Casting the response data to List<VisitDataResponse>

      final TaskListsResponse modelResponse = TaskListsResponse.fromJson(res.data ?? {});
      return modelResponse;
    } on ServerException catch (e) {
      // Re-throwing ServerException with its original message
      throw ServerException(e.message);
    } catch (e) {
      // Generic error handling with logging
      print("Error: $e");
      throw const ServerException("Something went wrong.");
    }
  }

  @override
  Future<VisitDataListResponse> VisitDetails(VisitRequest req) async {
    try {
      final res = await _dioClient.post(
        Apis.clientVisit,
        data: req.toJson(),
        contentType: CType.json,
      );

      // Casting the response data to List<VisitDataResponse>

      final VisitDataListResponse modelResponse = VisitDataListResponse.fromJson(res.data ?? {});
      return modelResponse;
    } on ServerException catch (e) {
      // Re-throwing ServerException with its original message
      throw ServerException(e.message);
    } catch (e) {
      // Generic error handling with logging
      print("Error: $e");
      throw const ServerException("Something went wrong.");
    }
  }

  /// NOT Working
  @override
  Future<ApiResponse> sentSignature(FormData? userData) async {
    try {
      final response = await _dioClient.post(Apis.sendSignature, data: userData);
      print("Edit user response $response");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sentAudio(FormData? userData) async {
    try {
      final response = await _dioClient.post(Apis.sendAudio, data: userData);
      print("Edit user response $response");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<VisitStatusResponse> VisitsStatus(VisitsStatusRequest req) async{
    try {
      final res = await _dioClient.post(
        Apis.visitsStatus,
        data: req.toJson(),
        contentType: CType.json,
      );
      // Casting the response data to List<VisitDataResponse>
      final VisitStatusResponse modelResponse = VisitStatusResponse.fromJson(res.data ?? {});
      return modelResponse;
    } on ServerException catch (e) {
      // Re-throwing ServerException with its original message
      throw ServerException(e.message);
    } catch (e) {
      // Generic error handling with logging
      print("Error: $e");
      throw const ServerException("Something went wrong.");
    }
  }

  @override
  Future<ServiceListReaponse> getService(ServiceListRequest req) async{
    try {
      final res = await _dioClient.post(
        Apis.services,
        data: req.toJson(),
        contentType: CType.json,
      );
      // Casting the response data to List<VisitDataResponse>
      final ServiceListReaponse modelResponse = ServiceListReaponse.fromJson(res.data ?? {});
      return modelResponse;
    } on ServerException catch (e) {
      // Re-throwing ServerException with its original message
      throw ServerException(e.message);
    } catch (e) {
      // Generic error handling with logging
      print("Error: $e");
      throw const ServerException("Something went wrong.");
    }
  }

  @override
  Future<ClientVisitAddResponse?> startVisit(StartVisitRequest req)  async{
    try {
      final res = await _dioClient.post(
        Apis.startVisit,
        data: req.toJson(),
        contentType: CType.json,
      );

      // Casting the response data to List<VisitDataResponse>
      //if (res.data != null && res.data is List) {
      ClientVisitAddResponse? modelResponse;
      log('res.data: ${res.data}');
      if(res.statusCode == 403){
         await showDialog(barrierDismissible: false,context: getx.Get.context!, builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.white,
                      borderRadius: BorderRadius.circular(14)
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min,children: [
                    Center(child: Icon(Icons.not_listed_location_outlined,color: AppColors.red,size: 50,)),
                    SizedBox(height: 10,),
                    Txt(
                      "You're too far from the client location",
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      textColor: AppColors.black,
                      fontSize: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(color: AppColors.grey.withValues(alpha: 0.2),),
                    ),
                    RichText(textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: "HurmeGeometricSans1",
                        ),
                        children: [
                          TextSpan(text: 'To start this visit, you must be within '),
                          TextSpan(
                            text: '${RemoteConfigService.instance.nearMeDistance} m',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              fontSize: 16,
                              fontFamily: "HurmeGeometricSans1",
                            ),
                          ),
                          TextSpan(text: ' of the client’s address.'),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Txt(
                      "Current distance: ${res.data['distance'] ?? ''} m",
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      textColor: AppColors.black,
                      fontSize: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Divider(color: AppColors.grey.withValues(alpha: 0.2),),
                    ),
                    CustomElevatedButton(
                        height: 45,
                        alignment: Alignment.center,
                        onTap: () async {
                          Navigator.pop(getx.Get.context!);
                        },
                        child:  const Txt("Check again",
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white,
                          fontSize: 14,
                        )
                    ),
                    SizedBox(height: 10,),
                    CustomElevatedButton(
                        height: 45,color: Colors.transparent,
                        alignment: Alignment.center,
                        onTap: () async {
                          String? selectedReason;
                          showDialog(context: context, builder: (context) {
                            return StatefulBuilder(builder: (context, setStates) {
                              return Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(color: AppColors.white,
                                          borderRadius: BorderRadius.circular(14)
                                      ),
                                      child: Column(mainAxisSize: MainAxisSize.min,children: [
                                        Center(child: Icon(Icons.error_outline,color: AppColors.appOrange,size: 50,)),
                                        SizedBox(height: 10,),
                                        Txt(
                                          "Bypass location validation",
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center,
                                          textColor: AppColors.black,
                                          fontSize: 16,
                                        ),
                                        SizedBox(height: 10,),
                                        Txt(
                                          "Use this only if the client is being seen at a different approved location.",
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center,
                                          textColor: AppColors.black,
                                          fontSize: 14,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Divider(color: AppColors.grey.withValues(alpha: 0.2),),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Txt(
                                              "Reason for bypass",
                                              fontWeight: FontWeight.bold,
                                              textAlign: TextAlign.center,
                                              textColor: AppColors.black,
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6,),

                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: "client_location",
                                                  groupValue: selectedReason,
                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 🔥 removes extra height
                                                  visualDensity: VisualDensity.compact,
                                                  activeColor: AppColors.Primary,
                                                  onChanged: (value) {
                                                    setStates(() {
                                                      selectedReason = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(width: 6),
                                                Txt("Client at different location"),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: "gps_issue",
                                                  groupValue: selectedReason,
                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                  visualDensity: VisualDensity.compact,
                                                  activeColor: AppColors.Primary,
                                                  onChanged: (value) {
                                                    setStates(() {
                                                      selectedReason = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(width: 6),
                                                Txt("GPS issue"),
                                              ],
                                            ),
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Divider(color: AppColors.grey.withValues(alpha: 0.2),),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomElevatedButton(
                                                  height: 45,color: Colors.grey.withValues(alpha: 0.2),
                                                  alignment: Alignment.center,
                                                  border: ButtonBorder(width: 1, color: Colors.grey,),
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  child:  const Txt("Cancel",
                                                    fontWeight: FontWeight.bold,
                                                    textColor: AppColors.black,
                                                    fontSize: 14,
                                                  )
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Expanded(
                                              child: CustomElevatedButton(
                                                  height: 45,
                                                  alignment: Alignment.center,
                                                  onTap: () async {
                                                    if(selectedReason == null){
                                                      Fluttertoast.showToast(msg: "Please select a reason");
                                                      return;
                                                    }
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    req.reason = selectedReason == "client_location" ? "Client at different location" : "GPS issue";
                                                   await startVisit(req);
                                                    // Navigator.of(getx.Get.context!).pop();
                                                  },
                                                  child:  const Txt("Submit and start",
                                                    fontWeight: FontWeight.w600,
                                                    textColor: Colors.white,
                                                    fontSize: 14,
                                                  )
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],),
                                    ),
                                    Positioned(top: 10,right: 10,child: GestureDetector(onTap: () {
                                      Navigator.pop(context);
                                    },child: Icon(Icons.close,size: 25,color: AppColors.black,)))
                                  ],
                                ),
                              );
                            },);
                          },);
                        },
                        child:  const Txt("Bypass",
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.Primary,
                          fontSize: 14,
                        )
                    ),
                  ],),
                ),
                Positioned(top: 10,right: 10,child: GestureDetector(onTap: () {
                  Navigator.pop(getx.Get.context!);
                },child: Icon(Icons.close,size: 25,color: AppColors.black,)))
              ],
            ),
          );
        },);
         // modelResponse = ClientVisitAddResponse.fromJson(res.data ?? {});
         return null;
      }else{
        modelResponse = ClientVisitAddResponse.fromJson(res.data ?? {});
        //  final List<ClientVisitAddResponse> modelResponse = (res.data as List).map((e) => ClientVisitAddResponse.fromJson(e as Map<String, dynamic>)).toList();
        return modelResponse;
      }

      // } else {
      throw const ServerException("Invalid data format.");
      // }
    } on ServerException catch (e) {
      // Re-throwing ServerException with its original message
      throw ServerException(e.message);
    } catch (e) {
      // Generic error handling with logging
      print("Error: $e");
      throw const ServerException("Something went wrong.");
    }
  }

  @override
  Future<ClientVisitAddResponse> endVisit(CompleteVisitReq req)  async{
    try {
      final res = await _dioClient.post(
        Apis.completeVisit,
        data: req.toJson(),
        contentType: CType.json,
      );

      // Casting the response data to List<VisitDataResponse>
      //if (res.data != null && res.data is List) {

      final ClientVisitAddResponse modelResponse = ClientVisitAddResponse.fromJson(res.data ?? {});
      //  final List<ClientVisitAddResponse> modelResponse = (res.data as List).map((e) => ClientVisitAddResponse.fromJson(e as Map<String, dynamic>)).toList();
      return modelResponse;
      // } else {
      throw const ServerException("Invalid data format.");
      // }
    } on ServerException catch (e) {
      // Re-throwing ServerException with its original message
      throw ServerException(e.message);
    } catch (e) {
      // Generic error handling with logging
      print("Error: $e");
      throw const ServerException("Something went wrong.");
    }
  }

  @override
  Future<ClientResponse> ClientDetails(GetClientsDetailsReq req) async {
    try {
      final res = await _dioClient.post(
        Apis.clientDetails,
        data: req.toJson(),
        contentType: CType.json,
      );

      log('res: $res');
      // Casting the response data to List<VisitDataResponse>
      //if (res.data != null && res.data is List) {
      final ClientResponse modelResponse = ClientResponse.fromJson(res.data ?? {});
      //  final List<ClientVisitAddResponse> modelResponse = (res.data as List).map((e) => ClientVisitAddResponse.fromJson(e as Map<String, dynamic>)).toList();
      return modelResponse;
      // } else {
      throw const ServerException("Invalid data format.");
      // }
    }
    on ServerException catch (e) {
      // Re-throwing ServerException with its original message
      throw ServerException(e.message);
    }
    catch (e,st) {
      // Generic error handling with logging
      print("Error: $e---$st",);
      throw const ServerException("Something went wrong.");
    }
  }
}
