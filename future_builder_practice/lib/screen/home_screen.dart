import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16);

    return Scaffold(
      body: FutureBuilder(
        future: getNumber(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'FutureBuilder',
                style: textStyle.copyWith(fontSize: 20),
              ),
              Text('conState: ${snapshot.connectionState}'),
              Text('Data: ${snapshot.data}'),
              Text('Error: ${snapshot.error}'),
              ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('setState'))
            ],
          );
        },
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random();

    //throw Exception('에러 발생'); -> Error 반환

    return random.nextInt(100);
  }
}
