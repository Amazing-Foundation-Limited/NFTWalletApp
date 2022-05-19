

import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/main.dart';
import 'package:kingloryapp/src/state/cc_transaction_provider.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:intl/intl.dart';
//跨链转账详情
class CrossChainTransactionInfo extends StatefulWidget{
  TransactionData1 transactionData1;
  CrossChainTransactionInfo(this.transactionData1);
  @override
  _CrossChainTransactionInfoState createState()=>_CrossChainTransactionInfoState();
}
class _CrossChainTransactionInfoState extends State<CrossChainTransactionInfo>{
  final oCcy = NumberFormat("#,##0.0####", "en_US");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String time='';
    if(widget.transactionData1.time!=null || widget.transactionData1.time!=''){
      int timeStamp=int.parse(widget.transactionData1.time)*1000;
      time=DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(timeStamp));
    }
    final value = oCcy.format(widget.transactionData1.value);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:Text(S.of(context).g_key_144),
      ),
      body: Container(
          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(
                    bottom: ScreenUtil.getInstance().setWidth(36.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(S.of(context).g_key_138, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline2!.color)
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setWidth(20.0),),
                      Text(widget.transactionData1.coinName, style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline1!.color
                      ),),
                      Divider(
                        height: ScreenUtil.getInstance().setWidth(30.0) ,
                        color: Theme.of(context).textTheme.headline2!.color,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(
                    bottom: ScreenUtil.getInstance().setWidth(36.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(S.of(context).g_key_75, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline2!.color)
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setWidth(20.0),),
                      Text(widget.transactionData1.from, style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline1!.color
                      ),),
                      Divider(
                        height: ScreenUtil.getInstance().setWidth(30.0) ,
                        color: Theme.of(context).textTheme.headline2!.color,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(
                    bottom: ScreenUtil.getInstance().setWidth(36.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(S.of(context).g_key_38, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline2!.color)
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setWidth(20.0),),
                      Text(widget.transactionData1.receive==null?"":widget.transactionData1.receive, style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline1!.color
                      ),),
                      Divider(
                        height: ScreenUtil.getInstance().setWidth(30.0) ,
                        color: Theme.of(context).textTheme.headline2!.color,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(
                    bottom: ScreenUtil.getInstance().setWidth(36.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(S.of(context).g_key_45, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline2!.color)
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setWidth(20.0),),
                      Text(value, style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline1!.color
                      ),),
                      Divider(
                        height: ScreenUtil.getInstance().setWidth(30.0) ,
                        color: Theme.of(context).textTheme.headline2!.color,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(
                    bottom: ScreenUtil.getInstance().setWidth(36.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(S.of(context).g_key_145, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline2!.color)
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setWidth(20.0),),
                      Text(widget.transactionData1.state, style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline1!.color
                      ),),
                      Divider(
                        height: ScreenUtil.getInstance().setWidth(30.0) ,
                        color: Theme.of(context).textTheme.headline2!.color,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(
                    bottom: ScreenUtil.getInstance().setWidth(36.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(S.of(context).g_key_t_2, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline2!.color)
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setWidth(20.0),),
                      Text(time, style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline1!.color
                      ),),
                      Divider(
                        height: ScreenUtil.getInstance().setWidth(30.0) ,
                        color: Theme.of(context).textTheme.headline2!.color,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}