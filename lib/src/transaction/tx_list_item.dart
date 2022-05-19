
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/http/network_api.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';

class TransactionItem extends StatefulWidget {
  final String name;
  final Map<String, dynamic> details;
  final oCcy = NumberFormat("#,##0.0####", "en_US");

  TransactionItem({Key? key, required this.name, required this.details}) : super(key: key);
  @override
  TransactionItemState createState() => TransactionItemState();
}

class TransactionItemState extends State<TransactionItem> {
  String time = "";

  // Map<String, dynamic> details = {};
  @override
  void initState() {
    super.initState();
    final timeStamp = int.parse(widget.details['timeStamp']);
    time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toString();
  }

  @override
  Widget build(BuildContext context) {
    final from = widget.details['from'];
    String to = widget.details['to'];
    if (to.isEmpty) {
      to = "0x000000000000000";
    }

    final sValue = widget.details['value'];
    final value = widget.oCcy.format(toEther(sValue));
    return Card(
      elevation: 0,
      child: Padding(
          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.watch_later,color: Theme.of(context).textTheme.headline2!.color,
                    size: ScreenUtil.getInstance().setWidth(35.0),
                  ),
                  SizedBox(width: ScreenUtil.getInstance().setWidth(10.0),),
                  Text(time,
                      style:
                      TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(26.0),
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                  ),
                ],
              ),
              Divider(height: ScreenUtil.getInstance().setWidth(30.0),
                indent: 0,
                endIndent: 0,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).g_key_75,style:TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(26.0),
                            color: Theme.of(context).textTheme.headline1!.color),
                        ),
                        Text(from.substring(0, 8),
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(26.0),
                                color: Theme.of(context).textTheme.headline1!.color)),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                        Text(S.of(context).g_key_38,style:TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(26.0),
                            color: Theme.of(context).textTheme.headline1!.color),
                        ),
                        Text(to.substring(0,8),
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(26.0),
                                color: Theme.of(context).textTheme.headline1!.color),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: ScreenUtil.getInstance().setWidth(200.0),
                    child: Text("$value",
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline2!.color
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(40.0)),
                    width: ScreenUtil.getInstance().setWidth(56.0),
                    height: ScreenUtil.getInstance().setWidth(56.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(56.0))),
                      border: Border.all(
                        color: Color(0xffe67c3b),
                        width: ScreenUtil.getInstance().setWidth(2.0),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: ScreenUtil.getInstance().setWidth(30.0),
                      color: Color(0xffe67c3b),
                    ),
                  ),
                ],
              ),
            ],
          ))
    );

  }
  _oldWidget(){
    final from = widget.details['from'];
    String to = widget.details['to'];
    if (to.isEmpty) {
      to = "0x000000000000000";
    }
    final sValue = widget.details['value'];
    final value = widget.oCcy.format(toEther(sValue));
    return Padding(
        padding: EdgeInsets.only(
          right: ScreenUtil.getInstance().setWidth(18.0),
          left: ScreenUtil.getInstance().setWidth(18.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(time,
                style:
                TextStyle(fontSize: ScreenUtil.getInstance().setSp(24.0),
                    fontWeight: FontWeight.normal)),
            SizedBox(height: ScreenUtil.getInstance().setWidth(27.0),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: const Icon(Icons.compare_arrows_sharp),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Text("${S.of(context).g_key_75} ${from.substring(0, 8)}",
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(24.0),
                              fontWeight: FontWeight.normal)),
                      Text("${S.of(context).g_key_38} ${to.substring(0,8)}",
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(24.0),
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Center(
                        child: Text("$value",
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(24.0),
                                fontWeight: FontWeight.normal)))),
                Expanded(child: Icon(Icons.arrow_forward_ios_sharp))
              ],
            ),
            Divider(
              height: ScreenUtil.getInstance().setWidth(36.0),
              indent: 0,
              endIndent: 0,
            ),
          ],
        ));
  }
}
