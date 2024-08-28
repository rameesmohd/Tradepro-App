import 'package:flutter/material.dart';

class OnBoardLanguageRadio extends StatelessWidget {
  const OnBoardLanguageRadio({
    super.key,
    required this.title,
    required this.opacity,
  });
  final String title;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: 140,
        height: 38,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(11)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
                fillColor:
                    WidgetStateColor.resolveWith((states) => Colors.green),
                value: 'English',
                groupValue: title,
                onChanged: (va) {}),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
