import 'package:bloc/bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qrcode_builder_state.dart';

class QrcodeBuilderCubit extends Cubit<QrcodeBuilderState> {
  QrcodeBuilderCubit() : super(QrcodeBuilderState(null, textResult: "scan a code"));

  void newCode(Barcode? barcode) {
    emit(QrcodeBuilderState( barcode, textResult: "Result: "));
  }
}
