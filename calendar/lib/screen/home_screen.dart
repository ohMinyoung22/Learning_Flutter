import 'package:calendar/component/calendar.dart';
import 'package:calendar/component/schedule_bottom_sheet.dart';
import 'package:calendar/component/schedule_card.dart';
import 'package:calendar/component/today_banner.dart';
import 'package:calendar/constant/colors.dart';
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
      floatingActionButton: renderFloatingActionButton(),
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
          _ScheduleList()
        ]),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet( 
          isScrollControlled: true,
            context: context,
            builder: (ctx) {
              return ScheduleBottomSheet(selectedDate: selectedDay);
            });
      },
      child: Icon(Icons.add),
      backgroundColor: PRIMARY_COLOR,
    );
  }

  onDaySelected(sel, foc) {
    setState(() {
      selectedDay = sel;
      focusedDay = sel;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (ctx, idx) {
                return ScheduleCard(
                    color: Colors.red,
                    content: 'example',
                    endTime: 8,
                    startTime: 13);
              })),
    );
  }
}
