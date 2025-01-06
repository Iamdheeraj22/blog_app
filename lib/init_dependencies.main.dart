part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  _initProfile();
  final supabaseClient = await Supabase.initialize(
      url: AppSecrets.supaBaseUrl,
      anonKey: AppSecrets.supaBaseAnonKey,
      debug: true);

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(
    () => supabaseClient.client,
  );

  serviceLocator.registerLazySingleton(
    () => UserHiveBox(Hive.box(name: 'user')),
  );
  serviceLocator.registerLazySingleton(
    () => BlogHiveBoxModel(Hive.box(name: 'blogs')),
  );

  serviceLocator.registerFactory(
    () => InternetConnection(),
  );

  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  serviceLocator.registerLazySingleton(
    () => AppThemeCubit(),
  );

  serviceLocator.registerFactory<InternetConnectionChecker>(
    () => InternetConnectionCheckerImpl(
      connection: serviceLocator(),
    ),
  );
}

///This method initializes the auth dependencies
void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      dataSource: serviceLocator(),
      internetCheck: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignIn(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CurrentUser(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

///This method initializes the blog dependencies
void _initBlog() {
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<BlogLocalDataSource>(
    () => BlogLocalDataSourceImpl(
      blogsBox: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      internetConnectionChecker: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UploadBlog(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetBlogs(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      uploadBlog: serviceLocator(),
      getBlogs: serviceLocator(),
    ),
  );
}

///This method initializes the profile dependencies
void _initProfile() {
  serviceLocator.registerFactory<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      client: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<ProfileRepository>(
    () => ProfileRepositoryImpl(
      dataSource: serviceLocator(),
      internetCheck: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLogout(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ProfileBloc(
      userLogout: serviceLocator(),
    ),
  );
}
