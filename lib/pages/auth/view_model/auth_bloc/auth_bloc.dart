import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/locator.dart';
import '../../../../utils/shared_preferences.dart';
import '../../model/user_model.dart';
import '../../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

AuthRepository _authRepository = locator<AuthRepository>();

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final auth = await _authRepository.getAuth(
          email: event.username, password: event.password);
      if (auth is UserModel) {
        await SharedPreferencesHelper.setAccountToSharedPreferences(
          username: event.username,
          password: event.password,
        );

        emit(AuthSuccess());
      } else {
        emit(AuthFailure(error: auth ?? ""));
      }
    });

    on<AutoLoginEvent>((event, emit) async {
      emit(AuthLoading());

      final auth = await _authRepository.getAuth(
          email: event.username, password: event.password);
      if (auth is UserModel) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure(error: auth ?? ""));
      }
    });

    on<ClearAuthEvent>(
      (event, emit) {
        _authRepository.clear();
        emit(AuthInitial());
      },
    );
  }
}
