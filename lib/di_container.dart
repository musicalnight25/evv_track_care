
import 'package:healthcare/core/data/repos/auth_repos/auth_repo.dart';
import 'package:healthcare/core/data/repos/auth_repos/auth_repo_impl.dart';
import 'package:healthcare/core/data/repos/home_repos/home_repo.dart';
import 'package:healthcare/core/data/repos/home_repos/home_repo_impl.dart';
import 'package:healthcare/core/data/repos/visits_repos/visits_repo.dart';
import 'package:healthcare/core/data/repos/visits_repos/visits_repo_impl.dart';
import 'package:healthcare/core/helper/database/sqflite_client.dart';
import 'package:healthcare/src/auth/providers/auth_provider.dart';
import 'package:healthcare/src/demo/providers/visit_provider.dart';
import 'package:healthcare/src/details/provider/patient_details_provider.dart';
import 'package:healthcare/src/home/providers/home_provider.dart';
import 'package:healthcare/src/splash/providers/splash_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/data/dio/dio_client.dart';
import 'config/data/dio/logging_intercepter.dart';
import 'core/constants/api_constants.dart';
import 'core/network/network_service.dart';
part 'di_container.main.dart';