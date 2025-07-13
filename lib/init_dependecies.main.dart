part of 'init_dependencies.dart';
final GetIt serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerFactory(() => Hive.box(name: 'blogs'));

  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerFactory<InternetConnectionChecker>(
    () => InternetConnectionCheckerImpl(serviceLocator()),
  );
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSources>(
    () => AuthRemoteDataSourcesImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

  serviceLocator.registerFactory(() => UserSignIn(serviceLocator()));

  serviceLocator.registerFactory(() => UserSignOut(serviceLocator()));


  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
      userSignout: serviceLocator()
    ),
  );
}

void _initBlog() {
  serviceLocator
    //data->remote data source
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(serviceLocator()),
    )
    //domain->repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    //domain-> usecase
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    //presentation ->bloc
    ..registerLazySingleton(
      () =>
          BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()),
    );
}
