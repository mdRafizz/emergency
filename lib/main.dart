import 'package:emergency/app_route.dart';
import 'package:emergency/data/model/contact_model.dart';
import 'package:emergency/utils/constants.dart';
import 'package:emergency/views/home/home_main.dart';
import 'package:emergency/views/login/login_main.dart';
import 'package:emergency/views/signup/signup_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// hive initializing ////
  await Hive.initFlutter();

  /// user attachment ///
  Hive.registerAdapter(ContactModelAdapter());
  await Hive.openBox<ContactModel>('contactModel');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 825),
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            theme: ThemeData(
              fontFamily: 'rubik',
              // scaffoldBackgroundColor: AppConstants.kBkDark,
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffe8dcbe),),
              useMaterial3: true,
            ),
            getPages: AppRoutes.getPages(),
            initialRoute: user != null ? AppRoutes.home : AppRoutes.login,
          );
        });
  }
}
