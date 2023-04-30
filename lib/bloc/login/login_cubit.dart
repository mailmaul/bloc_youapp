import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<bool> {
  LoginCubit({this.init = true}) : super(init);

  bool init;

  void change() => emit(init = !state);
}
