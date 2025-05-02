import 'package:healthcare/config/data/dio/content_types.dart';
import 'package:healthcare/config/data/dio/dio_client.dart';
import 'package:healthcare/core/data/models/requests/auth_reqs/agency_req.dart';
import 'package:healthcare/core/data/models/requests/auth_reqs/login_req.dart';
import 'package:healthcare/core/data/models/response/agency_response.dart';
import 'package:healthcare/core/data/models/response/login_response.dart';
import 'package:healthcare/core/data/repos/auth_repos/auth_repo.dart';
import 'package:healthcare/core/utils/devlog.dart';

import '../../../../config/error/exceptions.dart';
import '../../../constants/api_constants.dart';

class AuthRepoImpl implements AuthRepo {
  final DioClient _dioClient;

  AuthRepoImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<UserResponse> userLogin(LoginReq req) async {
    try {

      final res = await _dioClient.post(Apis.login, data: req.toJson(), contentType: CType.json);
      /// CHANGE RESPONSE MODEL ACCOURDING YOUR RESPONSE
      final modelRes = UserResponse.fromJson(res.data ?? {});
      return modelRes;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      devlogError("error in repo : $e");
      throw const ServerException("Something went wrong.!");
    }
  }

  @override
  Future<EmployeeResponse> getAgency(AgencyReq req) async {
    try {

      final res = await _dioClient.post(Apis.listProvider, data: req.toJson(), contentType: CType.json);
      /// CHANGE RESPONSE MODEL ACCOURDING YOUR RESPONSE
      final modelRes = EmployeeResponse.fromJson(res.data ?? {});
      return modelRes;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw const ServerException("Something went wrong.!");
    }
  }


}
