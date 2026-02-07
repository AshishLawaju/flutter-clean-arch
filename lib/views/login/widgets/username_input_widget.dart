

import 'package:flutter/material.dart';

class UsernameInputWidget extends StatelessWidget {
  var  username = FocusNode();
   UsernameInputWidget({super.key , required this.username});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
                keyboardType: TextInputType.name,
                focusNode: username,
                decoration: const InputDecoration(hintText: 'Username', border: OutlineInputBorder()),
                onChanged: (value){},
                validator: (value){
                  if(value!.isEmpty){
                    return 'Empty username';
                  }
                  return null;
                },
                onFieldSubmitted: (value){},
              );
  }
}