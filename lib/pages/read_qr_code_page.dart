import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_reader/pages/qr_code_scan_result_page.dart';
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
    return Center(
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