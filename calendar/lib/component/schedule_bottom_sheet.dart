import 'package:calendar/component/custom_text_field.dart';
import 'package:calendar/constant/colors.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 16),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Time(),
                      SizedBox(height: 16),
                      _Content(),
                      SizedBox(height: 16),
                      _ColorPicker(),
                      SizedBox(height: 16),
                      _SaveButton(onPressed: onSavePressed,),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    if(formKey.currentState == null){
      return;
    }

    if(formKey.currentState!.validate()){
      //Form 아래의 모든 TextField의 Validate() 실행
      //모든 Validator() null 반환 -> validate true 반환

    } else{
      //에러 O
    }
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
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
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
      ),
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
          isTime: true,
        )),
        SizedBox(width: 16),
        Expanded(
            child: CustomTextField(
          label: '마감 시간',
          isTime: true,
        )),
      ],
    );
  }
}
