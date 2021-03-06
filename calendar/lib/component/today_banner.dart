import 'package:calendar/constant/colors.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int scheduleCount;

  const TodayBanner(
      {required this.scheduleCount, required this.selectedDay, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0,),
      color: PRIMARY_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일', style: textStyle,),
          Text('${scheduleCount}개', style: textStyle,)
        ],
      ),
    );
  }
}
