import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/config/routes/app_router/route_params.dart';
import 'package:healthcare/config/routes/routes.dart';
import 'package:healthcare/core/constants/app_constants.dart';
import 'package:healthcare/core/data/models/requests/auth_reqs/agency_req.dart';
import 'package:healthcare/core/data/models/requests/auth_reqs/login_req.dart';
import 'package:healthcare/core/data/repos/auth_repos/auth_repo.dart';
import 'package:healthcare/core/network/network_checker_widget.dart';
import 'package:healthcare/core/network/network_service.dart';
import 'package:healthcare/src/home/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/error/exceptions.dart';
import '../../../core/data/models/response/agency_response.dart';
import '../../../core/utils/common_toast.dart';
import '../../../core/utils/devlog.dart';
import '../../home/providers/home_provider.dart';
import '../../splash/providers/splash_provider.dart';
import '../screens/login_screen.dart';
import '../screens/select_agency_screen.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo _authRepo;
  final SharedPreferences _sp;
  final NetworkService _networkService;

  AuthProvider({required AuthRepo authRepo, required SharedPreferences sp, required NetworkService networkService})
      : _authRepo = authRepo,
        _sp = sp,
        _networkService = networkService;

  ///
  ///
  ///

  List<Company> _companies = [];

  List<Company> get companies => _companies;


  int? selectedIndex;


  storeToken(){
    _sp.setString(AppConsts.token, "TOKEN_AVAILABLE");
  }

  String? getImageBaseUrl(){
    return _sp.getString(AppConsts.imgBaseUrl);
  }

  /// Selected index

  void notify() => notifyListeners();

  /// Set Company Id

  setCompanyId(BuildContext context,String companyName,String companyId) async{
    _sp.setString(AppConsts.companyId,companyId.toString());
    _sp.setString(AppConsts.companyName,companyName.toString());

    await Provider.of<HomeProvider>(context, listen: false).setCompanyName();
  }

  /// LOGIN FOR USER
  ///

  Future<bool> userLogin(BuildContext context,{required String email, required String password, bool listen = true}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      if (isNetwork) {
        final req = LoginReq(email: email, password: password);
        final res = await _authRepo.userLogin(req);
        isSuccess = res.companyId != null;
        await _sp.setString(AppConsts.employeeId, res.id.toString());
        print("get base Url ${res.baseUrl.toString()}");
        await _sp.setString(AppConsts.imgBaseUrl, res.baseUrl.toString());
        await storeToken();
        // await  skipScreen(context);
        //await getAgency();
      } else {
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin auth login: $e");
      showSnackbar("Please check your email or password");
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin: $e");
      showSnackbar("Please check your email or password");
    } finally {
      if (listen) notifyListeners();
    }
    return isSuccess;
  }

  Future<void> logout(BuildContext context) async {
    // Clear shared preferences
    await _sp.clear();

    context.pushNamedAndRemoveUntil(LoginRoute(), (route) => false);
  }

  skipScreen(BuildContext context) async{
    final isToken = await context.read<SplashProvider>().isTokenAvailable();
    // isToken
    //     ?_companies.length == 1 ? context.pushNamedAndRemoveUntil(HomeRoute(), (route) => false): context.pushNamedAndRemoveUntil(SelectAgencyRoute(), (route) => false)
    //     :  context.pushNamedAndRemoveUntil(LoginRoute(), (route) => false);

    if (isToken) {
      if (context.isConnected) {
        await Provider.of<AuthProvider>(context, listen: false).getAgency();
        if (_companies.length == 1) {
          await context.pushNamedAndRemoveUntil(const HomeRoute(), (route) => false);
        } else {
          await context.pushNamedAndRemoveUntil(const SelectAgencyRoute(), (route) => false);
        }
      } else {
        final isCompanySelected = await context.read<SplashProvider>().isCompanySelected();
        if (isCompanySelected) {
          await context.pushNamedAndRemoveUntil(const HomeRoute(), (route) => false);
        } else {
          await context.pushNamedAndRemoveUntil(CustomRoute(routename: Routes.demo2, page: NoInternetWdget(), transition: TransitionType.fade), (route) => false);
        }
      }
    } else {
      await context.pushNamedAndRemoveUntil(LoginRoute(), (route) => false);
    }
  }

  /// get Agency Api
  ///

  Future<bool> getAgency({bool listen = true}) async {
    bool isSuccess = false;
    try {
      final isNetwork = await _networkService.isConnected;
      if (isNetwork) {
        final employeeId = _sp.getString(AppConsts.employeeId);
        final req = AgencyReq(employeeId: int.parse(employeeId!));
        final res = await _authRepo.getAgency(req);
        isSuccess = res != null;
        _companies = res.companies;

        if (_companies.length == 1) {
          await _sp.setString(AppConsts.companyId, _companies.firstOrNull!.id.toString());
          await _sp.setString(AppConsts.companyName, _companies.firstOrNull!.name.toString());
        }

        // _sp.setString(AppConsts.companyId,res.companyId.toString());
        // storeToken();
      } else {
        // showSnackbarError("No Internet Connection");

        /// OR YOU CAN PERFORM OFFLINE ACTION SUCH AS OFFLINE DATA BASE
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVERE_EXCEPTION -> adminLogin: $e");
      showSnackbar(e.message);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> adminLogin dfdf: $e");
      showSnackbar("Something went wrong.!");
    } finally {
      if (listen) notifyListeners();
    }

    return isSuccess;
  }

}
