import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/app/app.dart';
import 'package:my_app/bootstrap.dart';
import 'package:my_app/core/config/environment_config.dart';
import 'package:my_app/core/di/service_locator.dart';
import 'package:my_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize with staging configuration
  const config = EnvironmentConfig.staging;

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setup service locator with environment config
  await setupServiceLocator(environmentConfig: config);

  await bootstrap(() => const App(environmentConfig: config));
}
