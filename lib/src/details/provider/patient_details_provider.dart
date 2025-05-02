import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/visit_request.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/visits_status_request.dart';
import 'package:healthcare/core/data/models/response/api_response/visit_data_response.dart';
import 'package:healthcare/core/data/repos/visits_repos/visits_repo.dart';
import 'package:healthcare/core/network/network_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/error/exceptions.dart';
import '../../../core/helper/formatter.dart';
import '../../../core/utils/common_toast.dart';
import '../../../core/utils/devlog.dart';
import '../../demo/providers/visit_provider.dart';
import '../../demo/screens/thanks_screen.dart';

class PatientDetailsProvider extends ChangeNotifier {
  final VisitsRepo _visitsRepo;
  final SharedPreferences _sp;
  final NetworkService _networkService;

  PatientDetailsProvider({required VisitsRepo visitsRepo, required SharedPreferences sp, required NetworkService networkService})
      : _visitsRepo = visitsRepo,
        _sp = sp,
        _networkService = networkService;

  List<Task> _taskData = [];
  List<Task> get taskData => _taskData;

  List<String> _addedTask = [];
  List<String> get addedTask => _addedTask;

  Service? _service ;
  Service? get service => _service;

  DateTime? _startTime ;
  DateTime? get startTime => _startTime;

  DateTime? _endTime ;
  DateTime? get endTime => _endTime;


  bool _statusData = false;
  bool get statusData => _statusData;

  clearData(bool status) {
    _statusData = status;
    _taskData.clear();

    notifyListeners();
  }

  List<String> getTask(){
    _addedTask = _taskData.map((task) => task.taskReading as String).toList();
    return _addedTask;
  }

  /// Visit Details Api
  ///

  Future<bool> visitDetailsApi({bool listen = true,String? visitId}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      if (isNetwork) {

        final companyId = _sp.getString(AppConsts.companyId);
        final req = VisitRequest(visitId:visitId ?? "2");
        final res = await _visitsRepo.VisitDetails(req);
           isSuccess = res.visit != null;
        _taskData = res.tasks ?? [];
        _service = res.services ;
        if(res.visit!.scheduleStartTime!=null) {
          _startTime = res.visit?.scheduleStartTime;

        }else{
          _startTime = null;

        }

        if(res.visit!.scheduleEndTime!=null) {
          _endTime = res.visit?.scheduleEndTime;

        }else{

          _endTime = null;
        }


      } else {
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin: $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin ahfahr: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }


    return isSuccess;
  }

  /// Visit Status Api
  ///

  Future<bool> visitStatusApi(BuildContext context,String clientId,{bool listen = true,String? visitId,required String? endDate}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      if (isNetwork) {

        final companyId = _sp.getString(AppConsts.companyId);
        final req = VisitsStatusRequest(visitId:visitId ?? "2",status: "completed");
        final res = await _visitsRepo.VisitsStatus(req);
        isSuccess = res.status != null;
        if (res.status == "completed") {
          _statusData = true;
        }

        //await Provider.of<DemoProvider>(context, listen: false).visitEndApi(visitId: visitId,endTime: endDate);
        await Provider.of<DemoProvider>(context, listen: false).visitsApi(context, id: clientId.toString());
        final currTime = Formatter.stringFromDateTime(DateTime.now(), format: "yyyy-MM-dd");
        await Provider.of<DemoProvider>(context, listen: false).getDataDateWise(currTime.toString());

        await context.pushNamed(const ThanksRoute());

      } else {
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin: $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin sgrty: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }
    return isSuccess;
  }
}
