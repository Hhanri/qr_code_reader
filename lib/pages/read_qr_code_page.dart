import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_reader/cubit/qrcode_builder_cubit.dart';
import 'package:qr_code_reader/format/extensions.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadQRCodeScreen extends StatefulWidget {
  const ReadQRCodeScreen({Key? key}) : super(key: key);
  @override
  State<ReadQRCodeScreen> createState() => _ReadQRCodeScreenState();
}

class _ReadQRCodeScreenState extends State<ReadQRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            alignment:Alignment.center,
            children: <Widget>[
              BlocBuilder<QrcodeBuilderCubit, QrcodeBuilderState>(
                builder: (context, state) {
                  return const Positioned(child: BuildResult());
                },
              )
            ],
          )
        )
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
  Barcode? barcode;
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
    return QRViewWidget(qrKey: _qrKey, onQRViewCreated: onQRViewCreated);
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.scannedDataStream.listen((barcode) {
        BlocProvider.of<QrcodeBuilderCubit>(context).newCode(barcode);
        if (barcode.code!.isURL()) {
          launch(barcode.code!);
        }
      });
    });
  }
}

class QRViewWidget extends StatelessWidget {
  final GlobalKey qrKey;
  final void Function(QRViewController) onQRViewCreated;
  const QRViewWidget({Key? key, required this.qrKey, required this.onQRViewCreated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width*0.8,
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 10
      ),
    );
  }
}

class BuildResult extends StatelessWidget {
  const BuildResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrcodeBuilderCubit, QrcodeBuilderState>(
      builder: (context, state) {
        Barcode? barcode = state.barcode;
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white24
          ),
          child: Text(
            barcode != null ? "Result: ${barcode.code}" : "Scan a code",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
