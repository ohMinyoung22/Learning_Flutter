import 'package:calendar/component/calendar.dart';
import 'package:calendar/component/schedule_card.dart';
import 'package:calendar/component/today_banner.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Calendar(
            onDaySelected: onDaySelected,
            selectedDay: selectedDay,
            focusedDay: focusedDay,
          ),
          SizedBox(
            height: 8.0,
          ),
          TodayBanner(scheduleCount: 3, selectedDay: selectedDay),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ScheduleCard(color: Colors.red, content: 'example', endTime: 8, startTime: 13),
          )
        ]),
      ),
    );
  }

  onDaySelected(sel, foc) {
    setState(() {
      selectedDay = sel;
      focusedDay = foc;
    });
  }
}
