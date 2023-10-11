import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kurd_store/firebase_options.dart';
import 'package:kurd_store/src/admin/provider/admin_auth_provider.dart';
import 'package:kurd_store/src/providers/app_provider.dart';
import 'package:kurd_store/src/providers/auth_provider.dart';
import 'package:kurd_store/src/screens/my_app/my_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => AdminAuthProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
  await 0.delay();

  Provider.of<AuthProvider>(Get.context!, listen: false).user;
}
