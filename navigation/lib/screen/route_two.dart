import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';

import 'route_three.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(title: 'Route Two', children: [
      Text('argument ${arguments}'),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Pop'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/three', arguments: 999);
        },
        child: Text('Push Named'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/three');
        },
        child: Text('Replace'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => RouteThreeScreen()),
              (route) => route.settings.name == '/'); 
          // false 리턴 -> 삭제 true -> 삭제 안함
        },
        child: Text('pushRemvUntil'),
      ),
    ]);
  }
}
