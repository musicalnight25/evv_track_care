import 'package:dio/dio.dart';
import 'package:healthcare/config/data/dio/dio_client.dart';
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
  Future<ClientVisitsResponse> VisitsDetails(VisitsRequest req) async {
    try {
      final res = await _dioClient.post(
        Apis.clientVisits,
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
    } catch (e) {
      // Generic error handling with logging
      print("Error: $e");
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
    } catch (e) {
      // Generic error handling with logging
      print("Error: $e");
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
  Future<ClientVisitAddResponse> startVisit(StartVisitRequest req)  async{
    try {
      final res = await _dioClient.post(
        Apis.startVisit,
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

      // Casting the response data to List<VisitDataResponse>
      //if (res.data != null && res.data is List) {
      final ClientResponse modelResponse = ClientResponse.fromJson(res.data ?? {});
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
}
