import 'package:healthcare/config/data/dio/dio_client.dart';
import 'package:healthcare/core/data/models/requests/company_details_reqs/company_details_reqs.dart';
import 'package:healthcare/core/data/models/requests/company_details_reqs/company_reqs.dart';
import 'package:healthcare/core/data/models/requests/company_details_reqs/offline_data_fatch_req.dart';
import 'package:healthcare/core/data/models/requests/company_details_reqs/sync_visits_req.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/company_details_response.dart';
import 'package:healthcare/core/data/models/response/z_response/fetch_response.dart';
import 'package:healthcare/core/data/models/response/z_response/z_visit_model.dart';
import 'package:healthcare/core/data/repos/home_repos/home_repo.dart';

import '../../../../config/data/dio/content_types.dart';
import '../../../../config/error/exceptions.dart';
import '../../../constants/api_constants.dart';
import '../../models/requests/visits_reqs/clients_list_response.dart';

class HomeRepoImpl implements HomeRepo {
  final DioClient _dioClient;

  HomeRepoImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<List<ClientListResponse>> companyDetails(ComanyDetailsReqs req) async {
    try {
      final res = await _dioClient.post(Apis.clients, data: req.toJson(), contentType: CType.json);

// Casting the response data to List<VisitDataResponse>
      if (res.data != null && res.data is List?) {
        final List<ClientListResponse> modelResponse = (res.data as List?)?.map((e) => ClientListResponse.fromJson(e ?? {})).toList() ?? [];
        return modelResponse;
      } else {
        throw const ServerException("Invalid data format.");
      }
      // final modelRes = ClientListResponse.fromJson(res.data ?? {});
      // return modelRes;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      print("Error : $e");
      throw const ServerException("Something went wrong.!");
    }
  }

  @override
  Future<CompanyDetailsRes> companyDetailsApi(CompanyReqs req) async {
    try {
      final res = await _dioClient.post(Apis.companyDetails, data: req.toJson(), contentType: CType.json);

// Casting the response data to List<VisitDataResponse>
      if (res.data != null && res.data is List?) {
        final CompanyDetailsRes modelResponse = res.data;
        return modelResponse;
      } else {
        throw const ServerException("Invalid data format.");
      }
      // final modelRes = ClientListResponse.fromJson(res.data ?? {});
      // return modelRes;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      print("Error : $e");
      throw const ServerException("Something went wrong.!");
    }
  }

  @override
  Future<ZFetchResponse> offlineDataFatchApi(OfflineDataFatchReq req) async {
    try {
      final res = await _dioClient.post(Apis.offline_fetch, data: req.toJson(), contentType: CType.json);
      if (res.data != null && res.data is Map) {
        return ZFetchResponse.fromJson(res.data);
      }
      throw ServerException("Invalid Data Format");
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      print("Error in api dfdfdf: $e");
      throw const ServerException("Something went wrong.!");
    }
  }

  @override
  Future<bool> syncVisitToServer(SyncVisitsReq req) async {
    try {
      final res = await _dioClient.post(Apis.sync_offline, data: req.toJson(), contentType: CType.json);
      if (res.data != null && res.data is Map) {
        return true;
      }
      throw ServerException("Invalid Data Format");
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      print("Error in api dfdfdf: $e");
      throw const ServerException("Something went wrong.!");
    }
  }
}
