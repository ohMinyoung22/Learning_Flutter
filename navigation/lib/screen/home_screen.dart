import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //true - pop 가능 
        //false - pop 불가능
        return false;
      },
      child: MainLayout(title: 'Home Screen', children: [
        ElevatedButton(
          onPressed: () async {
            final result = await Navigator.of(context)
                .push<int>(MaterialPageRoute(builder: (ctx) => RouteOneScreen()));
    
                print(result);
          },
          child: Text('Push'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .maybePop();
          },
          child: Text('maybePop'), //RouteStack에 더 이상 페이지 없을때 pop x
        )
      ]),
    );
  }
}
