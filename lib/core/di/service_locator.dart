import 'package:get_it/get_it.dart';
import 'package:my_app/core/config/environment_config.dart';
import 'package:my_app/core/network/api_client.dart';
import 'package:my_app/features/authentication/data/repositories/firebase_auth_repository.dart';
import 'package:my_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:my_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:my_app/features/camera/data/repositories/camera_repository_impl.dart';
import 'package:my_app/features/camera/domain/repositories/camera_repository.dart';
import 'package:my_app/features/camera/presentation/cubit/camera_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator({EnvironmentConfig? environmentConfig}) async {
  // Register environment config if provided
  if (environmentConfig != null) {
    getIt.registerSingleton<EnvironmentConfig>(environmentConfig);
  }

  // Core services
  getIt.registerLazySingleton(ApiClient.new);
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    FirebaseAuthRepository.new,
  );
  getIt.registerLazySingleton<CameraRepository>(CameraRepositoryImpl.new);

  // Cubits
  getIt.registerFactory(
    () => AuthCubit(getIt<AuthRepository>()),
  );
  getIt.registerFactory(() => CameraCubit(getIt<CameraRepository>()));

  // Future registrations for other features
  // getIt.registerLazySingleton<StorageRepository>(() => StorageRepositoryImpl());
  // getIt.registerLazySingleton<ImageProcessingRepository>(
  //   () => ImageProcessingRepositoryImpl(),
  // );
  // getIt.registerFactory(() => ImageUploadCubit(getIt()));
  // getIt.registerFactory(() => ImageMarkingCubit(getIt()));
  // getIt.registerFactory(() => ImageProcessingCubit(getIt()));
}
