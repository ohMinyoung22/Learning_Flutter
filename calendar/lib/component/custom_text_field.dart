import 'package:calendar/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  const CustomTextField({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w600,
            )),
        TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true, //색깔 넣기용
            fillColor: Colors.grey[300],
          ),
          cursorColor: Colors.grey,
        ),
      ],
    );
  }
}
