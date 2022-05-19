import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/wallet/wallet_address_modify.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';

class WalletAddressList extends StatefulWidget{
  @override
  _WalletAddressListState createState()=>_WalletAddressListState();
}
class _WalletAddressListState extends State<WalletAddressList>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  modifyAddress(AddressDb adb,int index){
    final AddressDb addressDb=adb;
    Navigator.push(context,
      MaterialPageRoute(builder: (context)=>WalletAddressModify(addressDb: addressDb,isAdd: false,index: index,)),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<CoinsProvider>(
      builder: (context,value,child){
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(S.of(context).g_key_108),
            actions: [
              TextButton(
                onPressed: (){
                  value.setAddressListIsManage();
                },
                child: Text(
                  value.addressListIsManage?S.of(context).g_key_111:S.of(context).g_key_110,
                  style: TextStyle(
                  color: Theme.of(context).textTheme.headline2!.color,
                ),),
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      value.addressListIsManage
                          ? Expanded(
                          flex: 1,
                          child: Container(
                            //height: ScreenUtil.getInstance().setWidth(118.0*value.addressList.length+60.0),
                            margin: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(20.0),
                              horizontal: ScreenUtil.getInstance().setWidth(30.0),
                            ),
                            child:ListView.builder(
                              itemCount: value.addressList.length,
                              itemBuilder: (context,int index){
                                AddressDb addressdb=value.addressList[index];
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(10.0)),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardTheme.color,
                                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0)))
                                  ),
                                  padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0),),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          //Icon(Icons.lock_outline_rounded,size: ScreenUtil.getInstance().setWidth(44.0),),
                                          Image.asset('assets/img/wallet_menu4.png',width: ScreenUtil.getInstance().setWidth(44.0),),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(20.0)),
                                              child: Text(addressdb.addressName,style: TextStyle(
                                                color: Theme.of(context).textTheme.headline1!.color,
                                                fontSize: ScreenUtil.getInstance().setSp(28.0),),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              modifyAddress(addressdb,index);
                                            },
                                            child: Image.asset('assets/img/wallet_edit.png',
                                              width: ScreenUtil.getInstance().setWidth(44.0),),
                                          ),
                                        ],
                                      ),
                                      Divider(height: ScreenUtil.getInstance().setWidth(46.0),
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              value.changeDefaultAddress(index);
                                            },
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  addressdb.isDefault==1
                                                      ?Icon(
                                                    Icons.check_circle,size: ScreenUtil.getInstance().setWidth(38.0),
                                                    color: Theme.of(context).textTheme.headline2!.color,
                                                  )
                                                      :Container(
                                                    width:ScreenUtil.getInstance().setWidth(32.0),
                                                    height:ScreenUtil.getInstance().setWidth(32.0),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Theme.of(context).textTheme.headline6!.color!,width:ScreenUtil.getInstance().setWidth(1.0) ),
                                                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(28.0))),
                                                    ),
                                                  ),
                                                  SizedBox(width: ScreenUtil.getInstance().setWidth(28.0),),
                                                  Text(
                                                    S.of(context).g_key_109,
                                                    style: TextStyle(
                                                      color: Theme.of(context).textTheme.headline6!.color,
                                                      fontSize: ScreenUtil.getInstance().setSp(26.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible:addressdb.isDefault==0?true:false,
                                            child: InkWell(
                                              onTap: (){
                                                value.deleteAddress(index);
                                              },
                                              child: Container(
                                                child: Text(S.of(context).g_key_113,
                                                  style: TextStyle(
                                                    color: Theme.of(context).textTheme.headline6!.color,
                                                    fontSize: ScreenUtil.getInstance().setSp(26.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                );
                              },
                            ),
                          )
                      )
                          : Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(20.0),
                            horizontal: ScreenUtil.getInstance().setWidth(30.0),
                          ),
                          child: ListView.builder(
                            itemCount: value.addressList.length,
                            itemBuilder: (context,int index){
                              AddressDb addressdb=value.addressList[index];
                              BoxDecoration bd=BoxDecoration(
                                color: Theme.of(context).cardTheme.color,
                              );
                              if(value.addressList.length==1){
                                bd=BoxDecoration(
                                    color: Theme.of(context).cardTheme.color,
                                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0)))
                                );
                              }else if(index==0){
                                bd=BoxDecoration(
                                  color: Theme.of(context).cardTheme.color,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(ScreenUtil.getInstance().setWidth(16.0)),
                                    topRight: Radius.circular(ScreenUtil.getInstance().setWidth(16.0)),
                                  ),
                                );
                              }else if(index==value.addressList.length-1){
                                bd=BoxDecoration(
                                  color: Theme.of(context).cardTheme.color,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(ScreenUtil.getInstance().setWidth(16.0)),
                                    bottomRight: Radius.circular(ScreenUtil.getInstance().setWidth(16.0)),
                                  ),
                                );
                              }
                              if(addressdb.isDefault==1){
                                //是默认地址
                                return Container(
                                  decoration: bd,
                                  padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0),),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Image.asset('assets/img/wallet_menu4.png',width: ScreenUtil.getInstance().setWidth(44.0),),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(20.0)),
                                              child: Text(addressdb.addressName,style: TextStyle(
                                                color: Theme.of(context).textTheme.headline1!.color,
                                                fontSize: ScreenUtil.getInstance().setSp(28.0),),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              modifyAddress(addressdb,index);
                                            },
                                            child: Image.asset('assets/img/wallet_edit.png',
                                              width: ScreenUtil.getInstance().setWidth(44.0),),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: ScreenUtil.getInstance().setWidth(64.0),
                                          top: ScreenUtil.getInstance().setWidth(20.0),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(40.0))),
                                          border: Border.all(width: ScreenUtil.getInstance().setWidth(1.0),
                                            color: Theme.of(context).textTheme.headline2!.color!,
                                          ),
                                        ),
                                        //height: ScreenUtil.getInstance().setWidth(40.0),
                                        padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(6.0),
                                            horizontal: ScreenUtil.getInstance().setWidth(16.0)
                                        ),
                                        child: Text(
                                          S.of(context).g_key_109,
                                          style: TextStyle(
                                            color: Theme.of(context).textTheme.headline2!.color,
                                            fontSize: ScreenUtil.getInstance().setSp(26.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                );
                              }else{
                                return Container(
                                  decoration: bd,
                                  padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0),),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/img/wallet_menu4.png',width: ScreenUtil.getInstance().setWidth(44.0),),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(20.0)),
                                          child: Text(addressdb.addressName,style: TextStyle(
                                            color: Theme.of(context).textTheme.headline1!.color,
                                            fontSize: ScreenUtil.getInstance().setSp(28.0),),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          modifyAddress(addressdb,index);
                                        },
                                        child: Image.asset('assets/img/wallet_edit.png',
                                          width: ScreenUtil.getInstance().setWidth(44.0),),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                        width: double.infinity,
                        height: ScreenUtil.getInstance().setWidth(88.0),
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>WalletAddressModify()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                            shape:MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(88.0))),
                            )),
                          ),
                          child: Text(
                            S.of(context).g_key_112,
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(32.0),
                                color: Theme.of(context).textTheme.headline3!.color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Visibility(
                  visible: value.addressList_showLoading,
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    child: LoadingPage1(),
                  ),
                ),
              ),
            ],
          ),

        );
      },
    );
      
  }
}