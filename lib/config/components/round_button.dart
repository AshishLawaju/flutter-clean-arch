import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {

 final String title ;
 final VoidCallback onPress;
  const RoundButton({super.key ,required this.title ,required this.onPress});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: widget.onPress, child: Text(widget.title));
  }
}