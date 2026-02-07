import 'package:flutter/material.dart';

class InternetExceptionWidget extends StatelessWidget {

  final VoidCallback onPress;
  const InternetExceptionWidget({super.key ,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * .15),
          Icon(Icons.cloud_off, color: Colors.red, size: 50),
          Text(
            'We are unable to  show results. \n Please check your data \n connection.',

            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.displayMedium!.copyWith(fontSize: 20),
          ),

          ElevatedButton(onPressed: onPress , child: Text("RETRY"))
        ],
      ),
    );
  }
}
