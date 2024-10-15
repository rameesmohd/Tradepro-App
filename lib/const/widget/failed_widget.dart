import 'package:flutter/material.dart';

class ScreenLoadingFailedWidget extends StatelessWidget {
  const ScreenLoadingFailedWidget({super.key, required this.errorText});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 332,
          height: 332,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/connection-lost.png'))),
        ),
        const SizedBox(height: 25),
        Text(errorText, style: const TextStyle())
      ],
    );
  }
}
