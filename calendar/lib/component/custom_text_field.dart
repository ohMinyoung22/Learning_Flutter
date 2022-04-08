import 'package:calendar/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;

  const CustomTextField({required this.isTime, required this.label, Key? key})
      : super(key: key);

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
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField())
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      validator: ((String? value) {
        if (value == null || value.isEmpty) {
          return '값을 입력해주세요';
        }
        //null 에러 없음 / String 리턴 에러 o
        if (isTime) {
          int time = int.parse(value);

          if (time < 0) {
            return '0 이상의 숫자를 입력해주세요';
          }

          if (time > 24) {
            return '24 이하의 숫자를 입력해주세요';
          }
        } else {}
      }),
      expands: isTime ? false : true,
      maxLines: isTime ? 1 : null,
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true, //색깔 넣기용
        fillColor: Colors.grey[300],
      ),
      cursorColor: Colors.grey,
    );
  }
}
