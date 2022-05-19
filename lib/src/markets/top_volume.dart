import 'package:flutter/material.dart';

class TopVolumeMarketsScreen extends StatefulWidget {
  const TopVolumeMarketsScreen({Key? key}) : super(key: key);

  @override
  TopVolumeMarketsScreenState createState() => TopVolumeMarketsScreenState();

}

class TopVolumeMarketsScreenState extends State<TopVolumeMarketsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:  Text("Top Volume", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    );
  }



}