import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_reader/resources/strings.dart';
import 'package:qr_code_reader/utils/app_config.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatelessWidget {
  final String result;
  const ResultPage({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const AppBarWidget(),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(result, maxLines: 4, overflow: TextOverflow.ellipsis),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CopyResultButtonWidget(),
                    Visibility(
                      child: GoToButtonWidget(url: result),
                      visible: result.isURL ? true : false,
                      maintainSize: false,
                    ),
                  ],
                ),
              ],
            ),
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
    return SizedBox(
      width: AppConfig.widthScreen(context)*0.3,
      child: ElevatedButton(
          onPressed: (){
            launch(url);
          },
          child:FittedBox (child: Row(
            children: const [
               Text(SystemStrings.goToPage),
            ],
          ))
      ),
    );
  }
}

class CopyResultButtonWidget extends StatelessWidget {
  const CopyResultButtonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConfig.widthScreen(context)*0.3,
      child: ElevatedButton(
        onPressed: (){
        },
        child: const Text(SystemStrings.copy)
      ),
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
      title: const Text(SystemStrings.result),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      )
    );
  }
}

