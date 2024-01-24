import 'package:flutter/material.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model.dart';
import 'package:hrm_medical_world_app_two/data/repo_model/hrm_repo_model_impl.dart';
import 'package:hrm_medical_world_app_two/persistence/share_preference/share_preference.dart';
import 'package:hrm_medical_world_app_two/view/appointment_detail/screen/appointment_detail_screen.dart';
import 'package:hrm_medical_world_app_two/view/appointment_list/screen/appointment_list_screen.dart';
import 'package:hrm_medical_world_app_two/view/reset_password/screen/reset_password_screen.dart';
import 'package:hrm_medical_world_app_two/view/splash/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
