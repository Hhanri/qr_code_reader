import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qrcode_builder_state.dart';

class QrcodeBuilderCubit extends Cubit<QrcodeBuilderState> {
  QrcodeBuilderCubit() : super(QrcodeBuilderInitial());
}
