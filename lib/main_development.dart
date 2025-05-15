import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/app/app.dart';
import 'package:my_app/bootstrap.dart';
import 'package:my_app/core/di/service_locator.dart';
import 'package:my_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupServiceLocator();
  await bootstrap(() => const App());
}
