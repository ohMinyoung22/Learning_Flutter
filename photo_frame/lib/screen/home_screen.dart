import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
        int currentPage = controller.page!.toInt();

        int nextPage = currentPage + 1;
        if (nextPage > 4) {
          nextPage = 0;
        }

        controller.animateToPage(nextPage,
            duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5]
            .map((e) => Image(
                  image: AssetImage('asset/img/image_${e}.jpeg'),
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
    );
  }
}
