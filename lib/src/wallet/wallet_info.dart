import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/enum/load.dart';
import 'package:kingloryapp/src/component/error_page.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/component/wallet_widget/top_background.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/src/wallet/wallet_portfolio_screen_kgc.dart';
import 'package:kingloryapp/util/get_test_size.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:kingloryapp/src/wallet/wallet_portfolio_screen.dart';
import 'dart:ui' as ui;

class WalletMainScreen extends StatefulWidget {
  const WalletMainScreen({Key? key}) : super(key: key);

  @override
  WalletMainScreenState createState() => WalletMainScreenState();
}

class WalletMainScreenState extends State<WalletMainScreen> {
  TextEditingController _totalTextEditingController=TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinsProvider>(
      builder: (context,value,child){
        return newWidget(value);
      },
    );
  }

  newWidget(CoinsProvider value){
    _totalTextEditingController.text=value.totalBalance;
    bool isLight=Theme.of(context).brightness==Brightness.light;
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil.getInstance().setWidth(320.0),
            child: Stack(
              children: [
                Positioned.fill(
                  child: TopBackground(isLight: isLight,),
                ),
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(30.0)),
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(56.0)),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
                    ),
                    child: Column(
                      children: [
                        Text(S.of(context).g_key_29,
                          style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setWidth(32.0),
                            color: Theme.of(context).textTheme.headline6!.color,
                            height: 1.5,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: getMatchWidget(
                                "\$${value.totalBalance}",
                                ScreenUtil.getInstance().setWidth(750.0-60.0),
                                TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(60.0),
                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                ), ScreenUtil.getInstance().setSp(60.0), ScreenUtil.getInstance().setSp(30.0)
                            ),
                          ),
                        ),

                        /*Text("\$ ${value.totalBalance}",
                          style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(60.0),
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),)*/

                        /*Text(
                          "\$ ${value.priceRate}",
                          style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(32.0),
                            color: Theme.of(context).textTheme.bodyText2!.color,
                            height: 1.5,
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: listWidget(value),
          ),
        ],
      ),
    );
  }

  Widget listWidget(CoinsProvider value) {
    if (value.load == Load.error) {
      return ErrorPage1(
        message: value.errorMessage,
        reloadBack: value.getCoinInfo,
      );
    } else if (value.load == Load.loading) {
      Color bgColor=Color(0xffe4e4e4);
      return LoadingPage2(
          ListView.builder(
              itemCount: 10,
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 0.0,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setWidth(40.0),
                      bottom: ScreenUtil.getInstance().setWidth(40.0),
                      right: ScreenUtil.getInstance().setWidth(40.0),
                      left: ScreenUtil.getInstance().setWidth(40.0),
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(16.0), )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(30.0),),
                          child: Container(
                            height: ScreenUtil.getInstance().setWidth(66.0),
                            width: ScreenUtil.getInstance().setWidth(66.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(66.0)),
                              color: bgColor,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: ScreenUtil.getInstance().setWidth(290.0),
                                    height: ScreenUtil.getInstance().setWidth(30.0),
                                    color: bgColor,
                                  ),
                                  Container(
                                    width: ScreenUtil.getInstance().setWidth(150.0),
                                    height: ScreenUtil.getInstance().setWidth(30.0),
                                    color: bgColor,
                                  )
                                ],
                              ),
                              SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                              //SizedBox(height: ScreenUtil.getInstance().setWidth(16.0),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: ScreenUtil.getInstance().setWidth(100.0),
                                    height: ScreenUtil.getInstance().setWidth(30.0),
                                    color: bgColor,
                                  ),
                                  Container(
                                    width: ScreenUtil.getInstance().setWidth(80.0),
                                    height: ScreenUtil.getInstance().setWidth(30.0),
                                    color: bgColor,
                                  )
                                ],
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                );
              })
      );
    } else if (value.load == Load.finish) {
      final address = context.watch<WalletsProviderDefault>().addressInfo();
      Map<String, dynamic> coins = json.decode(address['coins']);
      final abc = context.watch<WalletsProviderDefault>().coins();
      return RefreshIndicator(
        onRefresh: () async {
          return Future.delayed(Duration(seconds: 3), () {
            // 延迟5s完成刷新
            value.getCoinInfo(isRefresh: true);
          });
        },
        backgroundColor: Theme.of(context).textTheme.headline2!.color,
        color: Theme.of(context).backgroundColor,
        displacement: ScreenUtil.getInstance().setWidth(72.0),
        child: Container(
          //color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.only(
            top: ScreenUtil.getInstance().setWidth(15.0),
            left: ScreenUtil.getInstance().setWidth(30.0),
            right: ScreenUtil.getInstance().setWidth(30.0),
            bottom: ScreenUtil.getInstance().setWidth(15.0),
          ),
          child:
          ListView.builder(
            itemCount: value.coinModels.length,
            // shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              CoinModel cm=value.coinModels[index];
              bool isERC20=false;
              isERC20=cm.coin['isERC20'];
              if (cm.coin['lockup']) {
                return PortfolioKgcScreen(cm);
              } else {
                return PortfolioScreen(cm);
              }
            },
          ),
              /*
          ListView.builder(
            itemCount: coins.length,
            // shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              String key = abc.keys.elementAt(index);
              var coinPrice;
              double coinChangePer = 0.0;
              bool isERC20=false;
              isERC20=coins[key]['isERC20'];
              if (value.coinslist.isNotEmpty) {
                for (var element in value.coinslist) {
                  //String name = key.toLowerCase();
                  String name=coins[key]['name_m'];
                  if (name == "mtk") {
                    name = "eos";
                  }
                  if (element['symbol'] == name) {
                    coinPrice = element['current_price'];
                    coinChangePer =
                    element['price_change_percentage_24h'];
                  }
                }
              }
              if (coins[key]['lockup']) {
                return PortfolioKgcScreen(
                  coins[key],
                    coinPrice ??= 0.0,
                    coinChangePer,
                  mainLabel: coins[key]['changeIndex'],
                );
              } else {
                return PortfolioScreen(coins[key],
                    coinPrice ??= 0.0, coinChangePer,
                  mainLabel: coins[key]['changeIndex'],
                );
              }
            },
          ),
          */
        ),

      );
    } else {
      return Container();
    }
  }
}
