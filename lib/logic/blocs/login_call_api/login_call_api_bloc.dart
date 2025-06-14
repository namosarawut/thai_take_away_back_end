import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thai_take_away_back_end/data/model/login_response.dart';
import 'package:thai_take_away_back_end/data/model/user_model.dart';
import 'package:thai_take_away_back_end/repositores/auth_repository.dart';
import 'package:thai_take_away_back_end/data/local_storage_helper.dart';

part 'login_call_api_event.dart';
part 'login_call_api_state.dart';

class LoginCallApiBloc
    extends Bloc<LoginCallApiEvent, LoginCallApiState> {
  final AuthRepository repository;

  LoginCallApiBloc(this.repository)
      : super(LoginCallApiInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginCallApiLoading());
      try {
        final resp = await repository.loginEmployee(
          employeeID: event.employeeID,
        );

        // เก็บ token และ user ลง local storage
        await LocalStorageHelper.saveToken(resp.accessToken);
        await LocalStorageHelper.saveUser(resp.employeeData);

        emit(LoginCallApiSuccess(
          user: resp.employeeData,
          role: resp.role,
        ));
      } catch (e) {
        emit(LoginCallApiFailure(e.toString()));
      }
    });
  }
}

