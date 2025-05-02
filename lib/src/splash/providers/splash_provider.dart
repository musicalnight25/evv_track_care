import 'package:healthcare/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  final SharedPreferences _sp;

  SplashProvider({required SharedPreferences sp}) : _sp = sp;

  ///
  ///
  ///

  /// LOGIN BASED ON STORED TOKEN
  ///

  Future<bool> isTokenAvailable() async {
    final String token = _sp.getString(AppConsts.token) ?? "";
    return token.isNotEmpty && token.trim() != "";
  }


  Future<bool> isCompanySelected() async {
    final String comppID = _sp.getString(AppConsts.companyId) ?? "";
    return comppID.isNotEmpty && comppID.trim() != "";
  }
}
