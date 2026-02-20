import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:talent_crm_app/features/home/presentation/home_binding.dart';
import 'package:talent_crm_app/features/home/presentation/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: HomeBinding(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("IntraPeople"),
          ),
          body: const HomePage(),
        ));
  }
}
