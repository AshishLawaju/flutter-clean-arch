import 'package:clean_coding/bloc/bloc/login_bloc.dart';
import 'package:clean_coding/main.dart';
import 'package:clean_coding/repository/auth/login_repository.dart';
import 'package:clean_coding/utils/enums.dart';
import 'package:clean_coding/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBlocs;
  final username = FocusNode();
  final password = FocusNode();

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();

    // _loginBlocs = LoginBloc(loginRepository: LoginRepository());
    _loginBlocs = LoginBloc(loginRepository: getIt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),

      body: BlocProvider(
        create: (context) => _loginBlocs,
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (current, previous) =>
              current.postApiStatus != previous.postApiStatus,
          listener: (context, state) {
            // TODO: implement listener

            if (state.postApiStatus == PostApiStatus.error) {
              FlushBarHelper.flushBarErrorMessage(
                state.error.toString(),
                context,
              );

              // ScaffoldMessenger.of(context)
              //   ..hideCurrentSnackBar()
              //   ..showSnackBar(SnackBar(content: Text(state.error.toString())));
            }

            if (state.postApiStatus == PostApiStatus.success) {
              FlushBarHelper.flushBarErrorMessage('Login Successful', context);
              // ScaffoldMessenger.of(context)
              //   ..hideCurrentSnackBar()
              //   ..showSnackBar(SnackBar(content: Text(state.error.toString())));
            }

            // if (state.postApiStatus == PostApiStatus.loading) {
            //   ScaffoldMessenger.of(context)
            //     ..hideCurrentSnackBar()
            //     ..showSnackBar(SnackBar(content: Text("submitting...")));
            // }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UsernameInputWidget(username: username),
                  SizedBox(height: 20),
                  PasswordInputWidget(password: password),
                  SizedBox(height: 20),
                  BlocBuilder<LoginBloc, LoginState>(
                    // CHANGE THIS: allow the button to react to status changes
                    buildWhen: (previous, current) =>
                        previous.postApiStatus != current.postApiStatus,
                    builder: (context, state) {
                      print(
                        "login button rerender - current status: ${state.postApiStatus}",
                      );
                      return ElevatedButton(
                        onPressed: state.postApiStatus == PostApiStatus.loading
                            ? null // Disable while loading to prevent ghost clicks
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  print("clicked");
                                  context.read<LoginBloc>().add(LoginButton());
                                }
                              },
                        child: state.postApiStatus == PostApiStatus.loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              )
                            : const Text("Login"),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
