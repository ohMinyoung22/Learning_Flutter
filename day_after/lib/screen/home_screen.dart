import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TopPart(
                selectedDate: selectedDate, callback: onPressed,
              ),
              _BottomPart()
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: CupertinoDatePicker(
                initialDateTime: selectedDate,
                maximumDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                ),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              color: Colors.white,
              height: 200,
            ),
          );
        },
        barrierDismissible: true);
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image(
        image: AssetImage('asset/images/pikachu.png'),
      ),
    );
  }
}

class _TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback callback;

  _TopPart({required this.selectedDate, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Text(
          'Pikachu & I',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'SpaceMono',
            fontSize: 60,
          ),
        ),
        Column(children: [
          const Text(
            '우리 처음 만난 날',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'SpaceMono',
              fontSize: 30,
            ),
          ),
          Text(
            '${selectedDate.year}. ${selectedDate.month}. ${selectedDate.day}',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'SpaceMono',
              fontSize: 20,
            ),
          ),
        ]),
        IconButton(
          iconSize: 40,
          onPressed: callback,
          icon: Icon(
            Icons.favorite,
            color: Colors.pink[300],
          ),
        ),
        Text(
          'D+${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).difference(selectedDate).inDays + 1}',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'SpaceMono',
            fontWeight: FontWeight.w700,
            fontSize: 50,
          ),
        ),
      ]),
    );
  }
}
