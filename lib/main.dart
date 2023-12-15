
import 'package:daldart/home/presentation/controller/home_controller.dart';
import 'package:daldart/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DalDart Task',
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(() => HomeController(), permanent: true);
      }),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      getPages: appPages,
      initialRoute: '/',
    );
  }
}
