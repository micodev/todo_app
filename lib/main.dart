import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/service/isar_service.dart';

import 'constant/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.putAsync(() async => IsarService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Todo Isar',
      getPages: AppRouter.routes,
      initialRoute: AppRouter.homeRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
