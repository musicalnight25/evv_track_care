import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthcare/core/data/models/requests/profile_reqs/get_clients_details_req.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/client_visits_add_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/client_visits_task_add_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/start_visit_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/task_list_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/visits_request.dart';
import 'package:healthcare/core/data/models/response/api_response/client_visit_add_response.dart';
import 'package:healthcare/core/data/models/response/api_response/send_signature_response.dart';
import 'package:healthcare/core/data/repos/visits_repos/visits_repo.dart';
import 'package:healthcare/core/helper/database/database_helper.dart';
import 'package:healthcare/core/network/network_service.dart';
import 'package:healthcare/src/details/provider/patient_details_provider.dart';
import 'package:healthcare/src/home/providers/home_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/error/exceptions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/data/models/requests/visits_reqs/complete_visit_req.dart';
import '../../../core/data/models/requests/visits_reqs/service_list_request.dart';
import '../../../core/data/models/response/api_response/client_visit_task_add_response.dart';
import '../../../core/data/models/response/api_response/service_list_reaponse.dart';
import '../../../core/data/models/response/base/api_response.dart';
import '../../../core/data/models/response/client_visits_response.dart';
import '../../../core/data/models/response/task_list_response.dart';
import '../../../core/helper/formatter.dart';
import '../../../core/utils/common_toast.dart';
import '../../../core/utils/devlog.dart';

class DemoProvider extends ChangeNotifier {
  final VisitsRepo _visitsRepo;
  final SharedPreferences _sp;
  final NetworkService _networkService;

  DemoProvider({required VisitsRepo visitsRepo, required SharedPreferences sp, required NetworkService networkService})
      : _visitsRepo = visitsRepo,
        _sp = sp,
        _networkService = networkService;

  List<Visit> get visitData => _visitData;
  List<Visit> _visitData = [];

  List<Visit> get allvisitData => _allvisitData;
  List<Visit> _allvisitData = [];

  List<Visit> get visitDateData => _visitDateData;
  final List<Visit> _visitDateData = [];

  List<TaskList> get taskList => _taskList;
  List<TaskList> _taskList = [];

  List<String> get taskNames => _taskNames;
  List<String> _taskNames = [];

  List<String> get selectedTaskNames => _selectedTaskNames;
  List<String> _selectedTaskNames = [];

  List<String> get finalSelectedTaskNames => _finalSelectedTaskNames;
  final List<String> _finalSelectedTaskNames = [];

  DateTime get selectedDate => _selectedDate;
  DateTime _selectedDate = DateTime.now();

  List<Service> get serviceList => _serviceList;
  List<Service> _serviceList = [];

  ClientVisitTaskAddResponse? get visitTaskAddResponse => _visitTaskAddResponse;

  ClientVisitTaskAddResponse? _visitTaskAddResponse =
      ClientVisitTaskAddResponse(id: 0, companyId: 0, clientId: 0, userId: 0, visitId: 0, taskId: "", taskReading: "", taskRefused: 0, createdAt: "", updatedAt: "");

  ClientVisitAddResponse? get visitAddResponse => _visitAddResponse;
  ClientVisitAddResponse? _visitAddResponse;

  int get selectedIndex => _selectedIndex;
  int _selectedIndex = 0;


  String? get payerId => _payerId;
  String? _payerId = "";

  Service get selectedService => _selectedService;
  Service _selectedService = Service();

  /// Selected Service

  selectService(int index, Service select) async {
    _selectedIndex = index;
    _selectedService = select;
    notifyListeners();
  }

  /// Set Selected Date

  setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  /// Set Selected Task
  setSelectedTask(List<String> selectedTask) {
    _selectedTaskNames = selectedTask;
    for (var e in selectedTask) {
      _taskNames.remove(e);
    }
    print("Update List $_selectedTaskNames");
    notifyListeners();
  }

  /// Clear Data

  clearData() {
    _finalSelectedTaskNames.clear();
    _selectedTaskNames.clear();
    _taskNames.clear();
    _taskList.clear();
    notifyListeners();
  }

  Future<String> getCompanyId() async {
    return _sp.getString(AppConsts.companyId) ?? "";
  }


  /// Filter Data form Date

  Future<List<Visit>> filterVisitsByDate(List<Visit> visits, String date) async {
    return visits.where((visit) {
      // Extract the date part from ScheduleStartTime
      devlog("scheduleStartTime : ${visit.scheduleStartTime}");
      String scheduleDate = visit.scheduleStartTime.toString().split(' ')[0];
      print("Enter get Data Date Wise ${scheduleDate == date}");
      return scheduleDate == date;
    }).toList();
  }

  /// Get data date Wise

  getDataDateWise(String date) async {
    print("Enter get Data Date Wise 1 $date");
    // _visitData = _allvisitData;
    print("Enter get Data Date Wise 2 ${_visitData.length}");
    _visitData = await filterVisitsByDate(_allvisitData, date.toString().split(' ')[0]);
    print("Enter get Data Date Wise 3 ${_visitData.length}");
    notifyListeners();
  }

  Future<List<String>> removeAddedTask(BuildContext context) async {
    List<String> taskList = Provider.of<PatientDetailsProvider>(context, listen: false).getTask();

    return taskList;
  }

  /// Visit Details Api
  ///

  Future<bool> visitsApi(BuildContext context, {required String id, bool listen = true}) async {
    bool isSuccess = false;
    _visitData.clear();
    _allvisitData.clear();
    notifyListeners();
    try {
      final isNetwork = await _networkService.isConnected;
      if (isNetwork) {
        final req = VisitsRequest(clientId: int.parse(id));
        final res = await _visitsRepo.VisitsDetails(req);
        // isSuccess = res.first.companyId != null;
        _visitData = res.visits;
        _allvisitData = res.visits.reversed.toList();
      } else {
        devlog("client id : $id");
        _visitData = context.read<HomeProvider>().offlineData?.clients?.where((element) => element.id?.toString() == id.toString()).firstOrNull?.visits ?? [];
        _allvisitData = visitData.reversed.toList();
        devlog("visit data : ${_visitData.length}");
        devlog("_allvisitData data : ${_allvisitData.length}");
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin:1 $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin dfasdf: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }
    return isSuccess;
  }

  /// Visit Task Add Api
  ///

  Future<bool> visitTaskAddApi(BuildContext context, {bool listen = true, String? visitId, String? companyId, String? clientId}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      final employeeId = _sp.getString(AppConsts.employeeId);
      if (isNetwork) {
        _selectedTaskNames.forEach((name) async {
          final item = _taskList.firstWhere((item) => item.taskName == name); // _taskList.map((task) => task.name as String).toList();
          int? id = item.serviceId;

          print("Current Task id ${item.taskName}");

          final req = ClientVisitsTaskAddRequest(
              visitId: visitId ?? "2", companyId: companyId ?? "2", clientId: clientId ?? "2", employeeId: employeeId ?? "", taskId: id.toString(), taskReading: name ?? "", taskRefused: "0");
          final res = await _visitsRepo.ClientVisitTaskAdd(req);
          isSuccess = res.companyId != null;
          _visitTaskAddResponse = res;
          showToast("Task submit successfully");
        });

        _selectedTaskNames.clear();
        _selectedDate = DateTime.now();
        await Provider.of<PatientDetailsProvider>(context, listen: false).visitDetailsApi(visitId: visitId);

        //     _visitData = res;
      } else {
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin:2 $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin adfg rghsf: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }
    return isSuccess;
  }


  /// Client Details API

  Future<bool> clientDetailsApi(BuildContext context, {bool listen = true, String? companyId, String? clientId}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      final employeeId = _sp.getString(AppConsts.employeeId);
      if (isNetwork) {


        final req = GetClientsDetailsReq(companyId: companyId ?? "2", clientId: clientId ?? "2");
        final res = await _visitsRepo.ClientDetails(req);

        _payerId = res.client?.clientPayerInformations?.firstOrNull?.id.toString();

      } else {
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin:2 $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin adfg rghsf: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }
    return isSuccess;
  }

  /// Start Visit Api
  ///

  Future<bool> visitStartApi({bool listen = true, String? visitId, String? startTime}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      if (isNetwork) {
        final req = StartVisitRequest(visitId: visitId ?? "", ScheduleStartTime: startTime ?? "");
        final res = await _visitsRepo.startVisit(req);
        isSuccess = res.companyId != null;
      } else {
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin:2 $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin gjytsr: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }
    return isSuccess;
  }

  /// End Visit Api
  ///

  Future<bool> visitEndApi({bool listen = true, String? visitId, String? endTime}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      if (isNetwork) {
        final req = CompleteVisitReq(visitId: visitId ?? "", ScheduleEndTime: endTime ?? "");
        final res = await _visitsRepo.endVisit(req);
        isSuccess = res.companyId != null;
      } else {
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin:2 $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin fgfg shhgg: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }
    return isSuccess;
  }

  /// Client Visits Add Api

  Future<bool> clientVisitsAddApi(BuildContext context, {bool listen = true, String? taskReading, int? companyId,int? clientId, String? sequenceID, String? startTime, String? endTime}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      final currTime = Formatter.stringFromDateTime(DateTime.now(), format: "yyyy-MM-dd HH:mm");
      final employeeId = _sp.getString(AppConsts.employeeId);
      print("Current Time $currTime");
      final req = ClientVisitsAddRequest(
          clientId: clientId ?? 2,
          employeeId: int.tryParse(employeeId.toString()) ?? 1,
          payerId: num.tryParse(_payerId ?? "1") ?? 1,
          companyId: companyId ?? 2,
          visitOtherID: "23525",
          sequenceID: sequenceID ?? "2524524525",
          visitTimeZone: "US/Eastern",
          // scheduleStartTime: currTime ?? "",
          // scheduleEndTime: endTime ?? "",
          contingencyPlan: "None",
          reschedule: 1,
          adjInDateTime: currTime ?? "",
          adjOutDateTime: currTime ?? "",
          hoursToBill: "5",
          hoursToPay: "4",
          visitCancelledIndicator: 1,
          clientVerifiedTimes: 1,
          clientVerifiedService: 1,
          clientSignatureAvailable: 1,
          clientVoiceRecording: 1,
          service_id: _selectedService != null ? _selectedService.id : _serviceList.firstOrNull?.id,
          program_id: _selectedService != null
              ? _selectedService.pivot?.program_id
              : _serviceList.isNotEmpty
                  ? _serviceList.first.pivot?.program_id
                  : 0);
      if (isNetwork) {
        final res = await _visitsRepo.ClientVisitAdd(req);
        _visitAddResponse = res;
        showToast("Visits Add successfully");

        // await visitStartApi(visitId: res.id.toString(), startTime: startTime);

        //     _visitData = res;
      } else {
        await DatabaseHelper.instance.insertVisitData(req.toVisitModel());
      }
   //   await context.read<HomeProvider>().offlineFetchApi(getTaskLists: false, getServices: false, getVisitsOnlyFromClient: true);
      await visitsApi(context, id: clientId.toString() ?? "2");
      _selectedDate = DateTime.now();
      await getDataDateWise(currTime.toString());
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin:123 $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin fgsfgdfg: $e");
      showSnackbar("Something went wrong.!");
    // } finally {
    }
      if (listen) notifyListeners();
    return isSuccess;
  }

  ///  Task List Api
  ///

  Future<bool> taskListApi(BuildContext context, {bool listen = true, String? companyId, String? clientId}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      if (isNetwork) {
        final companyId = _sp.getString(AppConsts.companyId);
        final req = TaskListRequest(companyid: int.parse(companyId ?? "0"), clientId: int.parse(clientId ?? "0"));
        final res = await _visitsRepo.TaskList(req);
        isSuccess = res != null;
        _taskList = res.taskLists;

        _taskNames = _taskList.map((task) => task.taskName as String).toList();
        List<String> addedTask = await removeAddedTask(context);

        for (var e in addedTask) {
          _taskNames.remove(e);
        }
      } else {
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin:2 $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin 123 : $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }
    return isSuccess;
  }

  /// Service List Api

  /// Add Signature Api
  ///

  Future<bool> serviceListApi(BuildContext context, {bool listen = true}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      final companyId = _sp.getString(AppConsts.companyId);
      if (isNetwork) {
        final req = ServiceListRequest(companyId: int.parse(companyId!));
        final res = await _visitsRepo.getService(req);
        isSuccess = res != null;
        _serviceList = res.services ?? [];

      } else {
        _serviceList = context.read<HomeProvider>().offlineData?.services ?? [];
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
      devlog("SERVICE LIST : ${_serviceList}");
      if (serviceList.isNotEmpty) {
        await selectService(0, _serviceList.first);
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin:2 $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin fgsfdgfg: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }
    return isSuccess;
  }

  addSignatureApi(BuildContext context, String clientId, {bool listen = true, String? visitId, File? signature, String? endTime}) async {
    String? capturedImageName;
    String? capturedImageMimeType;
    String? capturedImageMime;
    String? capturedImageType;
    if (signature?.path != "") {
      capturedImageName = signature?.path.substring(signature.path.lastIndexOf("/") + 1, signature.path.length);

      capturedImageMimeType = mime(capturedImageName);
      capturedImageMime = capturedImageMimeType!.split('/')[0];
      capturedImageType = capturedImageMimeType.split('/')[1];
    }

    var userdata = FormData.fromMap({
      "visit_id": visitId,
      "signature_file": signature?.path != "" ? await MultipartFile.fromFile(signature!.path, filename: capturedImageName, contentType: MediaType(capturedImageMime!, capturedImageType!)) : null,
    });

    ApiResponse response = await _visitsRepo.sentSignature(userdata);
    SendSignatureResponse data = SendSignatureResponse.fromJson(response.response?.data);

    // showToast("${data.signatureFile}");
    showToast("Signature uploaded");
    await Provider.of<PatientDetailsProvider>(context, listen: false).visitStatusApi(context, clientId, visitId: visitId, endDate: endTime);
    }

  /// send Audio File

  sentAudioFileApi({bool listen = true, String? visitId, File? audioFile}) async {
    String? capturedImageName;
    String? capturedImageMimeType;
    String? capturedImageMime;
    String? capturedImageType;
    if (audioFile?.path != "") {
      capturedImageName = audioFile?.path.substring(audioFile.path.lastIndexOf("/") + 1, audioFile.path.length);

      capturedImageMimeType = mime(capturedImageName);
      capturedImageMime = capturedImageMimeType!.split('/')[0];
      capturedImageType = capturedImageMimeType.split('/')[1];
    }

    var userdata = FormData.fromMap({
      "visit_id": visitId,
      "audio_file": audioFile?.path != "" ? await MultipartFile.fromFile(audioFile!.path, filename: capturedImageName, contentType: MediaType(capturedImageMime!, capturedImageType!)) : null,
    });

    ApiResponse response = await _visitsRepo.sentAudio(userdata);
    SendSignatureResponse data = SendSignatureResponse.fromJson(response.response?.data);

    showToast("Audio uploaded");
    }
}
