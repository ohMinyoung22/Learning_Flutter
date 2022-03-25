import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController? controller;
  final String homeURL = 'https://github.com/ohMinyoung22';
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            if(controller == null){
              return;
            } else{
              controller!.loadUrl(homeURL);
            }
          }, icon: Icon(Icons.check))
        ],
        centerTitle: true,
        title: Text('My Github'),
        backgroundColor: Colors.amber,
      ),
      body: WebView(
        onWebViewCreated: (WebViewController controller) {
          this.controller = controller;
        },
        initialUrl: homeURL,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
