import 'package:flutter/material.dart';
import 'package:qr_code_reader/resources/strings.dart';
import 'package:qr_code_reader/resources/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCodeScreen extends StatefulWidget {
  const GenerateQRCodeScreen({Key? key}) : super(key: key);

  @override
  State<GenerateQRCodeScreen> createState() => _GenerateQRCodeScreenState();
}

class _GenerateQRCodeScreenState extends State<GenerateQRCodeScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBarWidget(),
      body: Center(
        child: SingleChildScrollView(
          padding: StaticValues.fullPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: controller.text,
                size: 200,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 40),
              TextFieldWidget(
                controller: controller,
                setState: () {
                  setState(() {
                  });
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback setState;
  const TextFieldWidget({Key? key, required this.controller, required this.setState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: StaticValues.horizontalPadding,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),
        decoration: InputDecoration(
          hintText: SystemStrings.hintText,
          hintStyle: const TextStyle(
            color: Colors.grey
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: StaticValues.circularBorderRadius,
            borderSide: const BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: StaticValues.circularBorderRadius,
              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.done, size: 30,),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: setState,
          )
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget with PreferredSizeWidget{
  const _AppBarWidget({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(ScreenTitles.generator),
    );
  }
}
