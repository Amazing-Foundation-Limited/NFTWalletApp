import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class CCSelectCoins extends StatefulWidget{
  late Map<String,dynamic> coin;
  AddressDb addressDb;
  late dynamic callBack;
  int type;
  CCSelectCoins(this.addressDb,this.coin,this.callBack,{this.type=0});
  @override
  _CCSelectCoinsState createState()=>_CCSelectCoinsState();
}

class _CCSelectCoinsState extends State<CCSelectCoins>{
  late List<String> keyList;
  Map<String,dynamic> addressDb={};
  @override
  void initState() {
    // TODO: implement initState

    if(widget.type==0){
      String coinsStr=jsonEncode(widget.addressDb.coins);
      addressDb.addAll(jsonDecode(coinsStr));
      keyList=addressDb.keys.toList();
      /*Map<String,dynamic> coins;
    coins=GetCoins(widget.addressId-1);
    keyList=coins.keys.toList();
    List<String> coinKeys=widget.coin.keys.toList();
    String coinsStr=jsonEncode(coins);
    addressDb.addAll(jsonDecode(coinsStr));
    */
      List<String> coinKeys=widget.coin.keys.toList();
      if(coinKeys.length!=0){
        for(int i=0;i<keyList.length;i++){
          Map<String,dynamic> c=addressDb[keyList[i]];
          if(keyList[i]==coinKeys[0]){
            c['isSelect']=true;
          }else{
            c['isSelect']=false;
          }
        }
      }else{
        for(int i=0;i<keyList.length;i++){
          Map<String,dynamic> c=addressDb[keyList[i]];
          c['isSelect']=false;
        }
      }
    }else{
      Map<String,dynamic> coins;
      coins=GetCoins(0);
      coins.remove('MTK');

      keyList=coins.keys.toList();
      List<String> coinKeys=widget.coin.keys.toList();
      String coinsStr=jsonEncode(coins);
      addressDb.addAll(jsonDecode(coinsStr));

      if(coinKeys.length!=0){
        for(int i=0;i<keyList.length;i++){
          Map<String,dynamic> c=addressDb[keyList[i]];
          if(keyList[i]==coinKeys[0]){
            c['isSelect']=true;
          }else{
            c['isSelect']=false;
          }
        }
      }else{
        for(int i=0;i<keyList.length;i++){
          Map<String,dynamic> c=addressDb[keyList[i]];
          c['isSelect']=false;
        }
      }
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil.getInstance().setWidth(648.0),
      height: ScreenUtil.getInstance().setWidth(800.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
      ),
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(44.0)),
      child:Column(
        children: [
          Text(S.of(context).g_key_117,style: TextStyle(
            color: Theme.of(context).brightness==Brightness?Theme.of(context).textTheme.bodyText1!.color:Theme.of(context).textTheme.headline1!.color,
            fontSize: ScreenUtil.getInstance().setSp(32.0),
          ),),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil.getInstance().setWidth(40.0),
                //bottom: ScreenUtil.getInstance().setWidth(36.0),
              ),
              child: ListView.builder(
                itemCount: addressDb.length,
                itemBuilder: (context,int index){
                  Map<String,dynamic> coin=addressDb[keyList[index]];
                  String name=coin['name_m'];//keyList[index];
                  //bool isERC20=name=="KGC";
                  return InkWell(
                    onTap: (){
                      Map<String,dynamic> c={};
                      c[coin['name_k']]=coin;
                      widget.callBack(true, c);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        //top: ScreenUtil.getInstance().setWidth(40.0),
                        bottom: ScreenUtil.getInstance().setWidth(30.0),
                        right: ScreenUtil.getInstance().setWidth(30.0),
                        //left: ScreenUtil.getInstance().setWidth(40.0),
                      ),
                      margin: EdgeInsets.only(
                        bottom: ScreenUtil.getInstance().setWidth(30.0),
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(16.0),),
                        //border: Border.all(width: ScreenUtil.getInstance().setWidth(1.0),color: Theme.of(context).textTheme.headline2!.color!)
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: ScreenUtil.getInstance().setWidth(40.0),
                              top: ScreenUtil.getInstance().setWidth(40.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(30.0),),
                                  child: Image.asset("assets/images/${name.toLowerCase()}.png",
                                    height: ScreenUtil.getInstance().setWidth(66.0),
                                    width: ScreenUtil.getInstance().setWidth(66.0),),
                                ),

                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(name, style: TextStyle(
                                          fontSize: ScreenUtil.getInstance().setSp(28.0),
                                          color: Theme.of(context).textTheme.headline1!.color,
                                          fontWeight: FontWeight.bold),),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Visibility(
                                              visible: coin['isERC20'],
                                              child: Container(
                                                margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(10.0)),
                                                alignment: Alignment.center,
                                                //padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(42.0)),
                                                decoration: BoxDecoration(
                                                    //color: Theme.of(context).textTheme.headline2!.color,
                                                    border:Border.all(
                                                      color: Theme.of(context).textTheme.headline2!.color!,
                                                      width: ScreenUtil.getInstance().setWidth(1.0),
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0)),)
                                                ),
                                                child: Text('ERC20',style: TextStyle(
                                                  color: Theme.of(context).textTheme.headline2!.color,
                                                  fontSize: ScreenUtil.getInstance().setSp(18.0),
                                                ),),
                                                height: ScreenUtil.getInstance().setWidth(34.0),
                                                width: ScreenUtil.getInstance().setWidth(90.0),
                                              ),
                                            ),
                                            Visibility(
                                              visible: coin['changeIndex']!='',
                                              child: Container(
                                                margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(10.0)),
                                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(20.0)),
                                                alignment: Alignment.center,
                                                //padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(42.0)),
                                                decoration: BoxDecoration(
                                                  //color: Theme.of(context).textTheme.headline2!.color,
                                                    border:Border.all(
                                                      color: Theme.of(context).textTheme.headline2!.color!,
                                                      width: ScreenUtil.getInstance().setWidth(1.0),
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0)),)
                                                ),
                                                child: Text(coin['changeIndex'],style: TextStyle(
                                                  color: Theme.of(context).textTheme.headline2!.color,
                                                  fontSize: ScreenUtil.getInstance().setSp(18.0),
                                                ),),
                                                height: ScreenUtil.getInstance().setWidth(34.0),
                                                //width: ScreenUtil.getInstance().setWidth(50.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      coin['isSelect']?
                                      Icon(Icons.check_circle,
                                        color: Theme.of(context).textTheme.headline2!.color,
                                        size: ScreenUtil.getInstance().setWidth(40.0),
                                      ):Container(
                                        width:ScreenUtil.getInstance().setWidth(34.0),
                                        height:ScreenUtil.getInstance().setWidth(34.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Theme.of(context).textTheme.headline6!.color!,width:ScreenUtil.getInstance().setWidth(1.0) ),
                                          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(28.0))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}