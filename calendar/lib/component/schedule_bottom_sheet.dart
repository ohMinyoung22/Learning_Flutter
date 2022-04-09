import 'package:calendar/component/custom_text_field.dart';
import 'package:calendar/constant/colors.dart';
import 'package:calendar/model/category_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar/datebase/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

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
                      _Time(
                        onStartSaved: (String? value) {
                          startTime = int.parse(value!);
                        },
                        onEndSaved: (String? value) {
                          endTime = int.parse(value!);
                        },
                      ),
                      SizedBox(height: 16),
                      _Content(
                        onSaved: (String? value) {
                          content = value!;
                        },
                      ),
                      SizedBox(height: 16),
                      FutureBuilder<List<CategoryColor>>(
                          future: GetIt.I<LocalDatabase>().getCategoryColors(),
                          builder: (context, snapshot) {
                            return _ColorPicker(
                              colors: snapshot.hasData
                                  ? snapshot.data!
                                      .map((e) =>
                                          Color(int.parse('FF${e.hexCode}', radix: 16)))
                                      .toList()
                                  : [],
                            );
                          }),
                      SizedBox(height: 16),
                      _SaveButton(
                        onPressed: onSavePressed,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      //Form 아래의 모든 TextField의 Validate() 실행
      //모든 Validator() null 반환 -> validate true 반환

      formKey.currentState!.save();
    } else {
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
  final List<Color> colors;

  const _ColorPicker({required this.colors, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: colors.map((e) => renderColor(e)).toList(),
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
  final FormFieldSetter<String> onSaved;

  const _Content({
    required this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        onSaved: onSaved,
        label: '내용',
        isTime: false,
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;

  const _Time({
    required this.onStartSaved,
    required this.onEndSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          onSaved: onStartSaved,
          label: '시작 시간',
          isTime: true,
        )),
        SizedBox(width: 16),
        Expanded(
            child: CustomTextField(
          onSaved: onEndSaved,
          label: '마감 시간',
          isTime: true,
        )),
      ],
    );
  }
}
