import 'package:healthcare/core/data/models/requests/company_details_reqs/company_reqs.dart';
import 'package:healthcare/core/data/models/requests/visits_reqs/company_details_response.dart';
import 'package:healthcare/core/data/models/response/z_response/fetch_response.dart';
import 'package:healthcare/core/data/models/response/z_response/z_visit_model.dart';

import '../../models/requests/company_details_reqs/company_details_reqs.dart';
import '../../models/requests/company_details_reqs/offline_data_fatch_req.dart';
import '../../models/requests/company_details_reqs/sync_visits_req.dart';
import '../../models/requests/visits_reqs/clients_list_response.dart';
import '../../models/response/local_database/offline_data_fetch_response.dart';

abstract interface class HomeRepo {
  ///
  ///
  ///

  Future<List<ClientListResponse>> companyDetails(ComanyDetailsReqs _);
  Future<CompanyDetailsRes> companyDetailsApi(CompanyReqs _);
  Future<ZFetchResponse> offlineDataFatchApi(OfflineDataFatchReq _);
  Future<bool> syncVisitToServer(SyncVisitsReq _);

}