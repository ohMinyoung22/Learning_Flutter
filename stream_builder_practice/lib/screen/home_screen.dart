import 'dart:math';

import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16);

    return Scaffold(
      body: StreamBuilder(
        stream: streamNumbers(),
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'StreamBuilder',
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

  Stream<int> streamNumbers() async* {
    for(int i = 0; i < 10; i++){
      await Future.delayed(Duration(seconds: 1));

      yield i;
    }
  }
}