import 'package:calendar/component/custom_text_field.dart';
import 'package:calendar/constant/colors.dart';
import 'package:calendar/model/category_color.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/widgets.dart' as wd;
import 'package:calendar/datebase/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {

  final DateTime selectedDate;

  const ScheduleBottomSheet({required this.selectedDate, Key? key})
      : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

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
                child: wd.Column(
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
                            if (snapshot.hasData &&
                                selectedColorId == null &&
                                snapshot.data!.isEmpty) {
                              selectedColorId = snapshot.data![0].id;
                            }

                            return _ColorPicker(
                              colorIdSetter: (id) {
                                setState(() {
                                  selectedColorId = id;
                                });
                              },
                              selectedColorId: selectedColorId,
                              colors: snapshot.hasData ? snapshot.data! : [],
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

  void onSavePressed() async {
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      //Form 아래의 모든 TextField의 Validate() 실행
      //모든 Validator() null 반환 -> validate true 반환

      formKey.currentState!.save();

      final key = await GetIt.I<LocalDatabase>().createSchedule(
        SchedulesCompanion(
          date: Value(widget.selectedDate),
          startTime: Value(startTime!),
          content: Value(content!),
          endTime: Value(endTime!),
          colorId: Value(selectedColorId!),
        ),
      );

      Navigator.of(context).pop();
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

typedef ColorIdSetter = void Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int? selectedColorId;
  final ColorIdSetter colorIdSetter;

  const _ColorPicker(
      {required this.colorIdSetter,
      required this.selectedColorId,
      required this.colors,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: colors
          .map(
            (e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(
                e,
                selectedColorId == e.id,
              ),
            ),
          )
          .toList(),
    );
  }
}

Widget renderColor(CategoryColor color, bool isSelected) {
  return Container(
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.black, width: 4) : null,
        color: Color(int.parse('FF${color.hexCode}', radix: 16))),
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
