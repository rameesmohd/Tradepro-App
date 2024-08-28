import 'package:flutter/material.dart';

class OnBoardContent extends StatelessWidget {
  const OnBoardContent(
      {super.key, required this.centreWidget, required this.description});
  final Widget centreWidget;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: centreWidget),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            description,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 36,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
