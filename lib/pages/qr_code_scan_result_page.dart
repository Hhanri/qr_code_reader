import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatelessWidget {
  final String result;
  const ResultPage({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const AppBarWidget(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(result, maxLines: 4, overflow: TextOverflow.ellipsis),
              Visibility(
                child: GoToButtonWidget(url: result),
                visible: result.isURL ? true : false,
              )
            ],
          )
      ),
    );
  }
}

class GoToButtonWidget extends StatelessWidget {
  final String url;
  const GoToButtonWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          launch(url);
        },
        child: const Text("Go To Page")
    );
  }
}

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text("Result"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      )
    );
  }
}

