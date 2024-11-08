import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/utilities/dependency_binding/init_dependencies.dart';
import 'package:test_project/utilities/routes/route_generator.dart';
import 'package:test_project/utilities/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: InitBinding(),
      initialRoute: Routes.home,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
