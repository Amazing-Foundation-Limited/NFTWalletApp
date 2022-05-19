

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class TxItemInfo extends StatelessWidget {
  Map<String, dynamic> detail;

  TxItemInfo({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeStamp = int.parse(detail['timeStamp']);
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toString();
    String to = detail['to'];
    if (to.isEmpty) {
      to = "0x00000000000000000000000000000000";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).g_key_74),
      ),
      body: Container(
          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
          child: ListView.builder(
              itemCount: detail.length,
              itemBuilder: (BuildContext context, int index) {
                var key = detail.keys.elementAt(index);
                var value = detail[key];
                String labelStr=_getKeyLabel(context,key);
                if(labelStr==""){
                  labelStr=key;
                }
                if (key == 'to') {
                  value = to;
                }
                else if (key == 'timeStamp') {
                  value = time;
                }

                return Padding(
                  padding:  EdgeInsets.only(
                    bottom: ScreenUtil.getInstance().setWidth(36.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(labelStr, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline2!.color)
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setWidth(20.0),),
                      Text(value.toString(), style: TextStyle(
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
                );
              }
          )
      ),
    );
  }

  _getKeyLabel(context,String keyStr){
    String returnStr="";
    switch(keyStr){
      case "blockNumber":
        returnStr=S.of(context).g_key_t_1;
        break;
      case "timeStamp":
        returnStr=S.of(context).g_key_t_2;
        break;
      case "hash":
        returnStr=S.of(context).g_key_t_3;
        break;
      case "nonce":
        returnStr=S.of(context).g_key_t_4;
        break;
      case "blockHash":
        returnStr=S.of(context).g_key_t_5;
        break;
      case "from":
        returnStr=S.of(context).g_key_t_6;
        break;
      case "contractAddress":
        returnStr=S.of(context).g_key_t_7;
        break;
      case "to":
        returnStr=S.of(context).g_key_t_8;
        break;
      case "value":
        returnStr=S.of(context).g_key_t_9;
        break;
      case "tokenName":
        returnStr=S.of(context).g_key_t_10;
        break;
      case "tokenSymbol":
        returnStr=S.of(context).g_key_t_11;
        break;
      case "tokenDecimal":
        returnStr=S.of(context).g_key_t_12;
        break;
      case "transactionIndex":
        returnStr=S.of(context).g_key_t_13;
        break;
      case "gas":
        returnStr=S.of(context).g_key_t_14;
        break;
      case "gasPrice":
        returnStr=S.of(context).g_key_t_15;
        break;
      case "gasUsed":
        returnStr=S.of(context).g_key_t_16;
        break;
      case "cumulativeGasUsed":
        returnStr=S.of(context).g_key_t_17;
        break;
      case "input":
        returnStr=S.of(context).g_key_t_18;
        break;
      case "confirmations":
        returnStr=S.of(context).g_key_t_19;
        break;
    }
    return returnStr;
  }
}