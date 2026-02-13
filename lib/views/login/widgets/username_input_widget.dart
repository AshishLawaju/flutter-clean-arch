import 'package:clean_coding/bloc/login/login_bloc.dart';
import 'package:clean_coding/utils/validataions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameInputWidget extends StatelessWidget {
  var username = FocusNode();
  UsernameInputWidget({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (current, previous) => current.username != previous.username,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.name,
          focusNode: username,
          decoration: const InputDecoration(
            hintText: 'Username',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(UsernameChanged(username: value));
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Empty username';
            }

            if (!Validations.emailValidator(value)) {
              return 'Email is not correct';
            }
            return null;
          },
          onFieldSubmitted: (value) {},
        );
      },
    );
  }
}
