import 'package:flutter/cupertino.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/data/models/requests/company_details_reqs/offline_data_fatch_req.dart';
import 'package:healthcare/core/data/models/requests/company_details_reqs/sync_visits_req.dart';
import 'package:healthcare/core/data/models/response/z_response/z_company_model.dart';
import 'package:healthcare/core/data/repos/home_repos/home_repo.dart';
import 'package:healthcare/core/helper/database/database_helper.dart';
import 'package:healthcare/core/network/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/error/exceptions.dart';
import '../../../core/data/models/requests/company_details_reqs/company_details_reqs.dart';
import '../../../core/data/models/requests/visits_reqs/clients_list_response.dart';
import '../../../core/utils/common_toast.dart';
import '../../../core/utils/devlog.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepo _homeRepo;
  final SharedPreferences _sp;
  final NetworkService _networkService;

  HomeProvider({required HomeRepo homerepo, required SharedPreferences sp, required NetworkService networkService})
      : _homeRepo = homerepo,
        _sp = sp,
        _networkService = networkService;

  List<ClientListResponse> get clientData => _clientData;
  List<ClientListResponse> _clientData = [];

  List<ClientListResponse> get finalClientData => _finalClientData;
  List<ClientListResponse> _finalClientData = [];

  TextEditingController get searchController => _searchController;
  final TextEditingController _searchController = TextEditingController();

  String get companyName => _companyName;
  String _companyName = "";

  /// Search

  filterClients(String query, List<ClientListResponse> clients) {
    _clientData = clients.where((client) {
      final lowerCaseQuery = query.toLowerCase();
      return client.client!.clientFirstName!.toLowerCase().contains(lowerCaseQuery) ||
          client.client!.clientMiddleInitial!.toLowerCase().contains(lowerCaseQuery) ||
          client.client!.clientLastName!.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    notifyListeners();
  }

  setCompanyName() {
    _companyName = _sp.getString(AppConsts.companyName)!;
    notifyListeners();
  }

  /// Company Client List Details Api
  ///

  Future<bool> companyDetailsApi({bool listen = true}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      if (isNetwork) {
        final companyId = _sp.getString(AppConsts.companyId);
        final req = ComanyDetailsReqs(companyId: companyId ?? "2");
        final res = await _homeRepo.companyDetails(req);
        //   isSuccess = res.company != null;
        _companyName = _sp.getString(AppConsts.companyName)!;
        _clientData = res;
        _finalClientData = res;
      } else {
        // await offlineFetchApi();
        setCompanyName();
        _clientData = offlineData?.clients ?? [];
        _finalClientData = offlineData?.clients ?? [];
        devlog("offline data for clients  : ${_clientData?.firstOrNull?.clientAddress?.first?.clientAddressLine1}");
        devlog("offline data for clients  : ${offlineData?.clients?.firstOrNull?.clientAddress?.first?.clientAddressLine1}");
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin: $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin kiykjdy: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }

    return isSuccess;
  }

  /// Single Company Details APi
  ///

  // Future<bool> companyApi({bool listen = true}) async {
  //   bool isSuccess = false;
  //   try {
  //     final isNetwork = await _networkService.isConnected;
  //     if (isNetwork) {
  //       final companyId = _sp.getString(AppConsts.companyId);
  //       final req = CompanyReqs(companyId: companyId ?? "2");
  //       final res = await _homeRepo.companyDetailsApi(req);
  //       //   isSuccess = res.company != null;
  //       print("Current Company Name ${res.name ?? ""}");
  //       //_companyName = res.name ?? "";
  //     } else {
  //       // showSnackbarError("No Internet Connection");
  //
  //       /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
  //     }
  //   } on ServerException catch (e) {
  //     devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin: $e");
  //     showSnackbar(e.message);
  //   } catch (e) {
  //     devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin: $e");
  //     showSnackbar("Something went wrong.!");
  //   } finally {
  //     if (listen) notifyListeners();
  //   }
  //
  //   return isSuccess;
  // }

  /// OFFLINE FETCH DATA API
  ///

  ZCompanyModel? offlineData;

  bool syncingOfflineData = false;

  Future<bool> offlineFetchApi({bool listen = true, bool getServices = true, bool getTaskLists = true, bool getClients = true, bool getVisitsOnlyFromClient = false}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      if (isNetwork) {
        bool isFetchedDataStored = await _sp.getBool("isFetchedDataStored") ?? false;
        final companyId = _sp.getString(AppConsts.companyId);

        syncingOfflineData = false;
        final notSyncedVisitList = await DatabaseHelper.instance.getVisitDataNotSynced();
        if(companyId == null){
          showToast("Company not found for sync offline data.!");
        } else {
          if(notSyncedVisitList.isEmpty) {
            devlog("no visits found that are not synced");
          } else {
            final req = SyncVisitsReq(companyId: companyId, visits: notSyncedVisitList);
            final res = await _homeRepo.syncVisitToServer(req);
            if (res) {
              // await DatabaseHelper.instance.deleteNotSyncedVisits();
            }
          }
        }
        if (!isFetchedDataStored) {
          await DatabaseHelper.instance.clearDatabase();
          // isFetchedDataStored = await _sp.getBool("isFetchedDataStored") ?? false;
          final req = OfflineDataFatchReq(companyId: companyId ?? "2", date: "-");
          syncingOfflineData = true;
          notifyListeners();
          final res = await _homeRepo.offlineDataFatchApi(req);
          syncingOfflineData = false;
          notifyListeners();
          if (res.company == null) return false;

          await DatabaseHelper.instance.storeFetchResponse(res.company!);
          _sp.setBool("isFetchedDataStored", true);
        }
      } else {
        final companyId = _sp.getString(AppConsts.companyId);
        final data = await DatabaseHelper.instance.getCompanyDataById(
          companyId ?? "2",
          getClients: getClients,
          getServices: getServices,
          getTaskLists: getTaskLists,
          getVisitsOnlyFromClient: getVisitsOnlyFromClient,
        );

        offlineData = data;

        devlog("CompanyData : ${data?.toJson()}");
        // devlog("CompanyData clients: ${data?.clients?.map((e) => e.toJson())}");
        // devlog("CompanyData clients visits : ${data?.clients?.map((e) => e.visits?.map((e) => e.toJson()))}");
        // devlog("CompanyData services: ${data?.services?.map((e) => e.toJson())}");
        // devlog("CompanyData taskLists: ${data?.taskLists?.map((e) => e.toJson())}");
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin: $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin ujlu: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }

    return isSuccess;
  }
}
