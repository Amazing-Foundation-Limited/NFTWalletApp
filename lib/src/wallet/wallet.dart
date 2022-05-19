import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/wallet_widget/check_password.dart';
import 'package:kingloryapp/src/cross_chain_transaction/cc_transaction_send.dart';
import 'package:kingloryapp/src/setting/setting_info_mnemonic.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/src/wallet/wallet_address_list.dart';
import 'package:kingloryapp/src/wallet/wallet_gen.dart';
import 'package:kingloryapp/src/wallet/wallet_info.dart';
import 'package:kingloryapp/src/wallet/wallet_name_modify.dart';
import 'package:kingloryapp/util/get_test_size.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({Key? key}) : super(key: key);

  @override
  WalletWidgetState createState() => WalletWidgetState();

}

class WalletWidgetState extends State<WalletWidget> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Consumer<WalletsProviderDefault>(
      builder: (context,defaultWallets,child){
        Map<String,dynamic> ws=defaultWallets.wallet();
        if (ws.isEmpty) {
          //创建
          return Scaffold(
            // backgroundColor: Colors.blue,
              appBar: AppBar(
                title: Text(S.of(context).g_key_6),
              ),
              body: WalletGen()
          );
        } else {
          //已有
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).brightness==Brightness.light?Theme.of(context).textTheme.headline2!.color:Theme.of(context).backgroundColor,
              titleTextStyle: TextStyle(
                color: Theme.of(context).textTheme.headline3!.color,
              ),
              leading:Builder(builder: (context){
                return InkWell(
                    onTap: (){
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      width: 66,
                      height: 40,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/img/liebiao.png',
                        width: 20,
                        height: 20,
                      ),
                    )
                );
              },
              ),

              title: Text("${S.of(context).g_key_28}( ${ws['name']})"),
              /*actions: [
                InkWell(
                    onTap: (){

                    },
                    child: Container(
                      width: 66,
                      height: 40,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/img/gongju.png',
                        width: 20,
                        height: 20,
                      ),
                    )

                ),
              ],*/
            ),
            body: WalletMainScreen(),
            drawer:Consumer<CoinsProvider>(
              builder: (context,value,child){
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: Text(S.of(context).g_key_6),
                  ),
                  body: Container(
                    width: double.infinity,
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                    child: Column(
                      children: [
                        Card(
                          elevation: 0,
                          child: Container(
                            margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                            child: Column(
                              children: [
                                Text(ws['name'],style: TextStyle(
                                  color: Theme.of(context).textTheme.headline1!.color,
                                  fontSize: ScreenUtil.getInstance().setSp(32.0),),
                                ),
                                Divider(
                                  height: ScreenUtil.getInstance().setWidth(30.0),
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                Column(
                                  children: [
                                    getMatchWidget(
                                        "\$${value.totalBalance}",
                                        ScreenUtil.getInstance().setWidth(750.0-140.0),
                                        TextStyle(
                                          fontSize: ScreenUtil.getInstance().setSp(40.0),
                                          color: Theme.of(context).textTheme.bodyText1!.color,
                                          height: 1.5,
                                        ), ScreenUtil.getInstance().setSp(40.0), ScreenUtil.getInstance().setSp(30.0)
                                    ),
                                    /*Text("\$ ${value.totalBalance}",
                                        style: TextStyle(
                                          fontSize: ScreenUtil.getInstance().setSp(40.0),
                                          color: Theme.of(context).textTheme.bodyText1!.color,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                        ),
                                    ),*/
                                    Text(S.of(context).g_key_29,
                                      style: TextStyle(
                                        fontSize: ScreenUtil.getInstance().setWidth(32.0),
                                        color: Theme.of(context).textTheme.headline6!.color,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: InkWell(
                            onTap: (){
                              CheckPassword(context, 1);
                            },
                            child: Container(
                              margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset('assets/img/wallet_menu2.png',
                                    width: ScreenUtil.getInstance().setWidth(44.0),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(20.0)),
                                      child: Text(S.of(context).g_key_98,style: TextStyle(
                                        color: Theme.of(context).textTheme.headline1!.color,
                                        fontSize: ScreenUtil.getInstance().setSp(32.0),),
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp,
                                    size: ScreenUtil.getInstance().setWidth(30.0),
                                    color: Theme.of(context).textTheme.headline6!.color,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ),
                        Card(
                          elevation: 0,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>WalletNameModify()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset('assets/img/wallet_menu1.png',
                                    width: ScreenUtil.getInstance().setWidth(44.0),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(20.0)),
                                      child: Text(S.of(context).g_key_107,style: TextStyle(
                                        color: Theme.of(context).textTheme.headline1!.color,
                                        fontSize: ScreenUtil.getInstance().setSp(32.0),),
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp,
                                    size: ScreenUtil.getInstance().setWidth(30.0),
                                    color: Theme.of(context).textTheme.headline6!.color,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Consumer<WalletsProviderDefault>(
                          builder: (context,wValue,child){
                            final Map<String,dynamic> addressDb=wValue.addressInfo();
                            return Card(
                              elevation: 0,
                              child: Container(
                                  margin: EdgeInsets.only(
                                    left:ScreenUtil.getInstance().setWidth(30.0),
                                    right:ScreenUtil.getInstance().setWidth(30.0),
                                    bottom: ScreenUtil.getInstance().setWidth(30.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context,
                                            MaterialPageRoute(builder: (context)=>WalletAddressList()),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical:ScreenUtil.getInstance().setWidth(30.0)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.asset('assets/img/wallet_menu4.png',
                                                width: ScreenUtil.getInstance().setWidth(44.0),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(20.0)),
                                                  child: Text(S.of(context).g_key_108,style: TextStyle(
                                                    color: Theme.of(context).textTheme.headline1!.color,
                                                    fontSize: ScreenUtil.getInstance().setSp(32.0),),
                                                  ),
                                                ),
                                              ),
                                              Icon(Icons.arrow_forward_ios_sharp,
                                                size: ScreenUtil.getInstance().setWidth(30.0),
                                                color: Theme.of(context).textTheme.headline6!.color,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),


                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: ScreenUtil.getInstance().setWidth(64.0),
                                          right: ScreenUtil.getInstance().setWidth(64.0),
                                        ),
                                        child: Text(addressDb['addressName'],style: TextStyle(
                                            color: Theme.of(context).textTheme.headline6!.color
                                        ),),
                                      ),
                                      /*
                                    InkWell(
                                      onTap: (){

                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil.getInstance().setWidth(64.0),
                                          vertical: ScreenUtil.getInstance().setWidth(10.0)
                                        ),
                                        child: Text(addressDb['mnemonic'],style: TextStyle(
                                            color: Theme.of(context).textTheme.headline6!.color
                                        ),),
                                      ),
                                    ),*/

                                      Divider(
                                        height: ScreenUtil.getInstance().setWidth(30.0),
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(),
                                          ),
                                          Container(
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
                                    ],
                                  )

                              ),
                            );
                          },
                        ),
                        Card(
                          elevation: 0,
                          child: InkWell(
                            onTap: (){
                              CheckPassword(context, 0);
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              //SettingMnemonic(mnemonic: Provider.of<WalletsProviderDefault>(context).wallet()['mnemonic'])));
                            },
                            child: Container(
                              margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset('assets/img/wallet_menu3.png',
                                    width: ScreenUtil.getInstance().setWidth(44.0),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(20.0)),
                                      child: Text(S.of(context).g_key_97,style: TextStyle(
                                        color: Theme.of(context).textTheme.headline1!.color,
                                        fontSize: ScreenUtil.getInstance().setSp(32.0),),
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp,
                                    size: ScreenUtil.getInstance().setWidth(30.0),
                                    color: Theme.of(context).textTheme.headline6!.color,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CCTransactionSend()));
              },
              child: Container(
                child: Icon(
                  Icons.add,size: ScreenUtil.getInstance().setWidth(60.0),
                  color: Theme.of(context).textTheme.headline2!.color,
                ),
              ),
            ),

            // const Center(
            //   child: Text("Wallet", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            // )
          );
        }
      },
    );

  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}