import 'package:get_it/get_it.dart';
import 'package:my_app/features/authentication/data/repositories/firebase_auth_repository.dart';
import 'package:my_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:my_app/features/authentication/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    FirebaseAuthRepository.new,
  );

  // Cubits
  getIt.registerFactory(
    () => AuthCubit(getIt<AuthRepository>()),
  );

  // Future registrations for other features
  // getIt.registerLazySingleton<StorageRepository>(() => StorageRepositoryImpl());
  // getIt.registerLazySingleton<ImageProcessingRepository>(
  //   () => ImageProcessingRepositoryImpl(),
  // );
  // getIt.registerFactory(() => ImageUploadCubit(getIt()));
  // getIt.registerFactory(() => ImageMarkingCubit(getIt()));
  // getIt.registerFactory(() => ImageProcessingCubit(getIt()));
}
