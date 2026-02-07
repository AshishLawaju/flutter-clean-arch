import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final username =FocusNode();
  final password = FocusNode();


final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Login"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            UsernameInputWidget(username: username),
              SizedBox(height: 20,),
                TextFormField(
                keyboardType: TextInputType.text,
                focusNode: password,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password', border: OutlineInputBorder()),
                onChanged: (value){},
                validator: (value){
                  if(value!.isEmpty){
                    return 'Empty password';
                  }
                  return null;
                },
                onFieldSubmitted: (value){},
              ),
              SizedBox(height: 20,),
ElevatedButton(onPressed: (){
  if(_formKey.currentState!.validate()){
    print("valid");
  }
}, child: Text("Login"))
            ],
          )),
      ),
    );
  }
}