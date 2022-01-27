import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_reader/controllers/home_screen_controller.dart';
import 'package:qr_code_reader/pages/generate_qr_code_page.dart';
import 'package:qr_code_reader/pages/read_qr_code_page.dart';
import 'package:qr_code_reader/resources/strings.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<String> appBarTitles = [
    ScreenTitles.reader,
    ScreenTitles.generator
  ];
  final List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.camera
      ),
      label: ScreenTitles.reader
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.create
      ),
      label: ScreenTitles.generator
    )
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return HomeScreenScaffoldWidget(
          controller: controller,
          bottomNavItems: bottomNavItems
        );
      },
    );
  }
}

class HomeScreenScaffoldWidget extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomNavItems;
  final HomeScreenController controller;
  const HomeScreenScaffoldWidget({Key? key, required this.controller, required this.bottomNavItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: const [
          ReadQRCodeScreen(),
          GenerateQRCodeScreen()
        ],
        index: controller.tabIndex,
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        controller: controller,
        bottomNavBarItems: bottomNavItems ,
      ),
    );
  }
}



class BottomNavigationBarWidget extends StatelessWidget {
  final HomeScreenController controller;
  final List<BottomNavigationBarItem> bottomNavBarItems;
  const BottomNavigationBarWidget({
    Key? key,
    required this.controller,
    required this.bottomNavBarItems
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: controller.changeTabIndex,
      currentIndex: controller.tabIndex,
      type: BottomNavigationBarType.fixed,
      items: bottomNavBarItems,
    );
  }
}
