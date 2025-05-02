import 'package:healthcare/core/data/models/requests/auth_reqs/agency_req.dart';

import '../../models/requests/auth_reqs/login_req.dart';
import '../../models/response/agency_response.dart';
import '../../models/response/login_response.dart';

abstract interface class AuthRepo {
  Future<UserResponse> userLogin(LoginReq _);
  Future<EmployeeResponse> getAgency(AgencyReq _);
}