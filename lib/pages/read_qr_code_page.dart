import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_reader/pages/qr_code_scan_result_page.dart';
import 'package:qr_code_reader/resources/theme.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
class ReadQRCodeScreen extends StatefulWidget {
  const ReadQRCodeScreen({Key? key}) : super(key: key);
  @override
  State<ReadQRCodeScreen> createState() => _ReadQRCodeScreenState();
}

class _ReadQRCodeScreenState extends State<ReadQRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: QRCodeView(context: context)
    );
  }
}

class QRCodeView extends StatefulWidget {
  final BuildContext context;
  const QRCodeView({Key? key, required this.context}) : super(key: key);

  @override
  State<QRCodeView> createState() => _QRCodeViewState();
}

class _QRCodeViewState extends State<QRCodeView> {
  QRViewController? controller;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return
      Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: _qrKey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Theme.of(context).colorScheme.secondary,
              cutOutSize: MediaQuery.of(context).size.width*0.8,
              borderWidth: 10,
              borderLength: 20,
              borderRadius: 10
            ),
          ),
          Positioned(child: TopButtonsWidget(controller: controller), top: 10,)
        ],
      );
    }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      Get.to(ResultPage(result: barcode.code!));
    });
  }
}

class TopButtonsWidget extends StatefulWidget {
  final QRViewController? controller;
  const TopButtonsWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<TopButtonsWidget> createState() => _TopButtonsWidgetState();
}

class _TopButtonsWidgetState extends State<TopButtonsWidget> {
  bool isFlashOn = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: StaticValues.horizontalPadding,
      decoration: BoxDecoration(
        borderRadius: StaticValues.circularBorderRadius,
        color: StaticValues.greyedWhite
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              isFlashOn ? Icons.flash_off : Icons.flash_on,
            ),
            onPressed: () async {
              await widget.controller!.toggleFlash();
              isFlashOn = !isFlashOn;
              setState(() {
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.switch_camera
            ),
            onPressed:() async {
              await widget.controller!.flipCamera();
              setState(() {
              });
            },
          )
        ],
      ),
    );
  }
}
