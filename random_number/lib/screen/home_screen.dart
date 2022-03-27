import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number/constant/color.dart';
import 'package:random_number/screen/settings_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int maxNumber = 1000;
  List<int> randomNumbers = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(callBack: onSetting),
              _Body(randomNumbers: randomNumbers),
              _Footer(
                callBack: onCreateButtonPressed,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSetting() async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (context) {
          return SettingsScreen(maxNumber: maxNumber,);
        },
      ),
    );

    if(result != null){
      setState(() {
        maxNumber = result;
      });
    }
  }

  void onCreateButtonPressed() {
    final rand = Random();

    final List<int> newNumbers = [];

    while (newNumbers.length < 3) {
      int randomNumber = rand.nextInt(maxNumber);

      if (newNumbers.contains(randomNumber)) continue;

      newNumbers.add(randomNumber);
    }

    setState(() {
      randomNumbers = newNumbers;
    });
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback callBack;

  const _TopBar({
    required this.callBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '랜덤 숫자 생성기',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: callBack,
          icon: const Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({Key? key, required this.randomNumbers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map(
              (x) => Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16),
                child: Row(
                  children: x.value
                      .toString()
                      .split('')
                      .map((y) => Text(y.toString()))
                      .toList(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback callBack;

  const _Footer({Key? key, required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: RED_COLOR),
        onPressed: callBack,
        child: Text('생성하기!'),
      ),
    );
  }
}
