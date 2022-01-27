import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_reader/controllers/home_screen_binding.dart';
import 'package:qr_code_reader/pages/home_page.dart';
import 'package:qr_code_reader/resources/strings.dart';
import 'package:qr_code_reader/resources/theme.dart';

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
      theme: theme,
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

