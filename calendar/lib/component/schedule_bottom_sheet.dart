import 'package:calendar/component/custom_text_field.dart';
import 'package:calendar/constant/colors.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height / 2 + bottomInset,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _Time(),
            SizedBox(height: 16),
            _Content(),
            SizedBox(height: 16),
            _ColorPicker(),
            SizedBox(height: 16),
            _SaveButton(),
          ]),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: (() {}),
            style: ElevatedButton.styleFrom(primary: PRIMARY_COLOR),
            child: Text('저장'),
          ),
        )
      ],
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.indigo,
        Colors.purple,
      ].map((e) => renderColor(e)).toList(),
    );
  }
}

Widget renderColor(Color color) {
  return Container(
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    width: 32,
    height: 32,
  );
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: '내용',
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          label: '시작 시간',
        )),
        SizedBox(width: 16),
        Expanded(
            child: CustomTextField(
          label: '마감 시간',
        )),
      ],
    );
  }
}
