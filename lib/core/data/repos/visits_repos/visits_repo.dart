import 'package:dio/dio.dart';
import 'package:healthcare/core/data/models/requests/profile_reqs/get_clients_details_req.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/client_visits_task_add_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/task_list_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/visit_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/visits_request.dart';
import 'package:healthcare/core/data/models/response/api_response/visit_data_response.dart';
import 'package:healthcare/core/data/models/response/clients_details_response.dart';
import 'package:healthcare/core/data/models/response/task_list_response.dart';

import '../../models/requests/visits_reqs/client_visits_add_request.dart';
import '../../models/requests/visits_reqs/complete_visit_req.dart';
import '../../models/requests/visits_reqs/service_list_request.dart';
import '../../models/requests/visits_reqs/start_visit_request.dart';
import '../../models/requests/visits_reqs/visits_status_request.dart';
import '../../models/response/api_response/client_details_response.dart';
import '../../models/response/api_response/client_visit_add_response.dart';
import '../../models/response/api_response/client_visit_task_add_response.dart';
import '../../models/response/api_response/service_list_reaponse.dart';
import '../../models/response/api_response/visit_status_response.dart';
import '../../models/response/base/api_response.dart';
import '../../models/response/client_visits_response.dart';

abstract interface class VisitsRepo {
  ///
  ///
  ///

  Future<ClientVisitsResponse> VisitsDetails(VisitsRequest _);
  Future<ClientVisitAddResponse> ClientVisitAdd(ClientVisitsAddRequest _);
  Future<ClientVisitTaskAddResponse> ClientVisitTaskAdd(ClientVisitsTaskAddRequest _);
  Future<ClientResponse> ClientDetails(GetClientsDetailsReq _);
  Future<TaskListsResponse> TaskList(TaskListRequest _);
  Future<VisitDataListResponse> VisitDetails(VisitRequest _);
  Future<ApiResponse> sentSignature(FormData? userData);
  Future<ApiResponse> sentAudio(FormData? userData);
  Future<VisitStatusResponse> VisitsStatus(VisitsStatusRequest _);
  Future<ServiceListReaponse> getService(ServiceListRequest _);
  Future<ClientVisitAddResponse> startVisit(StartVisitRequest _);
  Future<ClientVisitAddResponse> endVisit(CompleteVisitReq _);

}