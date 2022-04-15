import 'package:calendar/component/calendar.dart';
import 'package:calendar/component/schedule_bottom_sheet.dart';
import 'package:calendar/component/schedule_card.dart';
import 'package:calendar/component/today_banner.dart';
import 'package:calendar/constant/colors.dart';
import 'package:calendar/datebase/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
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
          _ScheduleList(
            selectedDay: selectedDay,
          )
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
  final DateTime selectedDay;

  const _ScheduleList({
    required this.selectedDay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: StreamBuilder<List<Schedule>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDay),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('스케쥴이 없습니다'),
                  );
                }

                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, idx) {
                      final schedule = snapshot.data![idx];

                      return ScheduleCard(
                          color: Colors.red,
                          content: schedule.content,
                          endTime: schedule.endTime,
                          startTime: schedule.startTime);
                    });
              })),
    );
  }
}
