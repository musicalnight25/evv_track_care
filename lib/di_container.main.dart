part of 'di_container.dart';

class Di {

  static final sl = GetIt.instance;

  static Future<void> init() async {
    /// CORE
    ///
    final sharedPreferences = await SharedPreferences.getInstance();
    sl
      ..registerLazySingleton<Dio>(() => Dio())
      ..registerLazySingleton<LoggingInterceptor>(() => LoggingInterceptor())
      ..registerLazySingleton<DioClient>(() => DioClient(Apis.url, dio: sl(), loggingInterceptor: sl(), sharedPreferences: sl()))
      ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
      ..registerLazySingleton<SqfliteClient>(() => SqfliteClient())
      ..registerLazySingleton<NetworkService>(() => NetworkService()..startConnectionStreaming()); // DONT FORGET TO ADD SEMICOLUN AT THE LAST LINE
    // ..registerLazySingleton<HiveClient>(() => HiveClient()..initHive());

    /// REPOS
    ///
    sl
      ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(dioClient: sl()))
      ..registerLazySingleton<HomeRepo>(() => HomeRepoImpl(dioClient: sl()))
      ..registerLazySingleton<VisitsRepo>(() => VisitsRepoImpl(dioClient: sl())); // DONT FORGET TO ADD SEMICOLUN AT THE LAST LINE

    /// PROVIDERS
    ///
    sl
      ..registerFactory<SplashProvider>(() => SplashProvider(sp: sl()))
      ..registerFactory<AuthProvider>(() => AuthProvider(authRepo: sl(), sp: sl(), networkService: sl()))
      ..registerFactory<HomeProvider>(() => HomeProvider(homerepo: sl(),sp: sl(), networkService: sl()))
      ..registerFactory<DemoProvider>(() => DemoProvider(visitsRepo: sl(), sp: sl(), networkService: sl()))
      ..registerFactory<PatientDetailsProvider>(() => PatientDetailsProvider(visitsRepo: sl(), sp: sl(), networkService: sl())); // DONT FORGET TO ADD SEMICOLUN AT THE LAST LINE

    /// EXTERNAL
    ///
    // Hive.init((await getApplicationDocumentsDirectory()).path);
  }

}