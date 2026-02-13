part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final PostApiStatus postApiStatus;
  final String error;

  const LoginState({
    this.username = "",
    this.password = "",
    this.error = "",

    this.postApiStatus = PostApiStatus.initial,
  });

  LoginState copyWith({
    String? username,
    String? password,
    String? error,
    PostApiStatus? postApiStatus,
  }) {
    return LoginState(
      username: username ?? this.username,

      password: password ?? this.password,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [username, password, postApiStatus,error];
}

final class LoginInitial extends LoginState {
  // const LoginInitial() : super(); // This triggers the default "" values
}
