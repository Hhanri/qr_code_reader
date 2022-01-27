import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_reader/controllers/home_screen_binding.dart';
import 'package:qr_code_reader/pages/home_page.dart';
import 'package:qr_code_reader/resources/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: SystemStrings.appTitle,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(
          name: "/",
          page: () => HomeScreen(),
          binding: HomeScreenBinding()
        )
      ],
    );
  }
}

