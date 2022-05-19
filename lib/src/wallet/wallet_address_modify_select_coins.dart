import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class WalletAddressModifySelectCoins extends StatefulWidget{
  late AddressDb addressDb;
  late dynamic callBack;
  late int pathId;
  WalletAddressModifySelectCoins(this.addressDb,this.callBack,{this.pathId=0});
  @override
  _WalletAddressModifySelectCoinsState createState()=>_WalletAddressModifySelectCoinsState();
}

class _WalletAddressModifySelectCoinsState extends State<WalletAddressModifySelectCoins>{
  late List<String> keyList;
  Map<String,dynamic> addressDb={};
  @override
  void initState() {
    // TODO: implement initState

    Map<String,dynamic> coins;
    if(widget.pathId==0){
      coins=GetCoins(widget.addressDb.id-1);
    }else{
      coins=GetCoins(widget.pathId);
    }
    keyList=coins.keys.toList();
    late List<String> addressKeyList=widget.addressDb.coins.keys.toList();
    String coinsStr=jsonEncode(coins);
    addressDb.addAll(jsonDecode(coinsStr));
    //addressDb.addAll(coins);
    for(int i=0;i<addressKeyList.length;i++){
      Map<String,dynamic> coin=addressDb[addressKeyList[i]];
      coin['isSelect']=true;
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
                  bool isERC20=name=="KGC";

                  return InkWell(
                    onTap: (){
                      if(coin['canEdit']==false){
                        return;
                      }
                      if(coin["isSelect"]){
                        coin["isSelect"]=false;
                      }else{
                        coin["isSelect"]=true;
                      }
                      setState(() {

                      });
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child:TextButton(
                  onPressed: (){
                    widget.callBack(false,null);
                  },
                  style: ButtonStyle(
                    backgroundColor:  MaterialStateProperty.all(
                        Theme.of(context).brightness==Brightness.light?Colors.transparent:
                        Theme.of(context).textTheme.headline1!.color
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                          color: Theme.of(context).textTheme.headline2!.color!,
                          width: ScreenUtil.getInstance().setSp(1.0)),
                    ),
                    shape:MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(66.0))),
                    )),
                  ),
                  child: Text(
                    S.of(context).g_key_79,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(26.0),
                        color: Theme.of(context).textTheme.headline2!.color
                    ),
                  ),
                ),
              ),
              SizedBox(width: ScreenUtil.getInstance().setWidth(20.0)),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: (){
                    Map<String,dynamic> coins={};
                    for(int i=0;i<keyList.length;i++){
                      Map<String,dynamic> coin=addressDb[keyList[i]];
                      if(coin["isSelect"]){
                        coins[keyList[i]]=coin;
                      }
                    }
                    widget.callBack(true,coins);
                  },
                  style: ButtonStyle(
                    backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                    shape:MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(66.0))),
                    )),
                  ),
                  child: Text(
                    S.of(context).g_key_78,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(26.0),
                        color: Theme.of(context).textTheme.headline3!.color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}