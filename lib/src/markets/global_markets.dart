import 'package:flutter/material.dart';

class GlobalMarketsScreen extends StatefulWidget {
  double change_percentage = 0.0;
  Map<String, dynamic> market_cap_percentage;
  GlobalMarketsScreen({Key? key, required this.change_percentage, required this.market_cap_percentage}) : super(key: key);

  @override
  GlobalMarketsScreenState createState() => GlobalMarketsScreenState();

}

class GlobalMarketsScreenState extends State<GlobalMarketsScreen> {

  Widget trending(BuildContext context) {
    String t = widget.change_percentage.toStringAsFixed(4);
    if (widget.change_percentage < 0) {
      return  Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 20.0,
        spacing: 10.0,
      children: [
        Text.rich(
          TextSpan(
            style: const TextStyle(
                fontSize: 40,
                color: Colors.red
            ),
            children: [
              const WidgetSpan(
                child: Icon(Icons.trending_down_sharp,size: 45, color: Colors.red),
              ),
              TextSpan(
                text: '$t',
              )
            ],
          ),
        ),
    ],);
    } else if (widget.change_percentage > 0) {
      return  Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 20.0,
        spacing: 10.0,
        children: [
          Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 40,
                color: Colors.green
              ),
              children: [
                const WidgetSpan(
                  child: Icon(Icons.trending_up_sharp,size: 45, color: Colors.green),
                ),
                TextSpan(
                  text: '$t',
                )
              ],
            ),
          ),
        ],);
    } else {
      return Text("加载中...");
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: Wrap(
         spacing: 40,
         alignment: WrapAlignment.center,
         children: [
           const Text("全球行情",style: TextStyle(
               fontSize: 20, fontWeight: FontWeight.bold)),
           Container(
             margin: const EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0),
             width: double.infinity,
             child: Container(
                 margin: const EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0),
                 child: trending(context)
                ),
             ),
         ],
       ),
     ),
   );
  }

}