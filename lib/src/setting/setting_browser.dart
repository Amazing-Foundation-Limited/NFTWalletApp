import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kingloryapp/generated/l10n.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  WebviewScaffold(
        //要打开的网址
        url: "http://8.140.156.9:4000",
        useWideViewPort: true,
        displayZoomControls: true,
        withOverviewMode: true,
        appBar: AppBar(
          title: Text(S.of(context).g_key_86),
        ),
      ),
    );
  }
}