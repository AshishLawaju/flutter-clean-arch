import 'package:bloc/bloc.dart';
import 'package:clean_coding/models/user/user_model.dart';
import 'package:clean_coding/repository/auth/login_repository.dart';
import 'package:clean_coding/services/session_manager/session_controller.dart';
import 'package:clean_coding/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // LoginRepository loginRepository = LoginRepository();
  LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    // LoginBloc() : super(LoginInitial()) {
    // on<LoginEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<UsernameChanged>(_onUsernameChanged);
    // on<Usernamefoused>();
    on<PasswordChanged>(_onPasswordChanged);

    // on<Passwordfocused>();

    on<LoginButton>(_loginButton);
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _loginButton(LoginButton event, Emitter<LoginState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading, error: ''));

    final Map<String, String> data = {
      "email": state.username.trim(),
      "password": state.password.trim(),
    };

    try {
      final UserModel response = await loginRepository.loginApi(data);

      // Null-safe access with fallback
      final accessToken = response.accessToken ?? '';
      final refreshToken = response.refreshToken ?? '';

      if (accessToken.isEmpty || refreshToken.isEmpty) {
        throw Exception('Invalid tokens received from server');
      }

      await SessionController().saveuserInPreference(response);
      await SessionController().getUserFromPreference();

      print("Login success! AccessToken: $accessToken");



      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.success,
          error: 'Login Successful',
        ),
      );
    } catch (e) {
      final safeError = e.toString(); // e is never null in catch block

      emit(
        state.copyWith(postApiStatus: PostApiStatus.error, error: safeError),
      );

      print("Login error: $safeError");
    }
  }
}
