import 'package:flutter/material.dart';
import 'package:online_ticketing/repositries/authentication/authentication_repositries.dart';
import 'package:online_ticketing/utils/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';




void main() async{
  final WidgetsBinding widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  // --Getx Local Storage
  await GetStorage.init();
  // Await Native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  // Initialize Firebase & authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  runApp(const App());
}

