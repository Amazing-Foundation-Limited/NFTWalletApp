import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/enum/load.dart';
import 'package:kingloryapp/src/component/error_page.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/http/network_api.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/markets_provider.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:kingloryapp/util/toast_utils.dart';
import 'package:provider/provider.dart';

class MarketsWidget extends StatefulWidget {
  Map<String, dynamic> market_cap_percentage = {};
  Map<String, dynamic> total_volume = {};
  List<dynamic> coins = [];

  MarketsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MarketWidgetState();
}

class MarketWidgetState extends State<MarketsWidget> with AutomaticKeepAliveClientMixin{
  double market_cap_change_percentage_24h_usd = 0.0;
  Load _load = Load.loading; //当前加载状态
  String errorMessage = ""; //数据加载提示信息
  @override
  void initState() {
    super.initState();
    _getGlobal();
  }

  _getGlobal() async {
    setState(() {
      _load = Load.loading;
    });
    bool error = false;
    var conis = await Api.markets();
    var list;
    if (conis['error']) {
      error = true;
      errorMessage = conis['data'];
    } else {
      list = await Api.coinsPriceList();
      if (list['error']) {
        error = true;
        errorMessage = list['data'];
      }
    }
    if (this.mounted) {
      setState(() {
        _load = error ? Load.error : Load.finish;
        if (error == false) {
          setGlobal(conis['data']['data']);
          setCoins(list['data']);
        }
      });
    }
  }

  _getGlobal_refresh() async {
    bool error = false;
    var conis = await Api.markets();
    var list;
    if (conis['error']) {
      error = true;
      errorMessage = conis['data'];
    } else {
      list = await Api.coinsPriceList();
      if (list['error']) {
        error = true;
        errorMessage = list['data'];
      }
    }
    if (this.mounted) {
      setState(() {
        if (error == false) {
          setGlobal(conis['data']['data']);
          setCoins(list['data']);
        } else {
          ToastUtils.show(errorMessage);
        }
      });
    }
  }

  void setGlobal(Map<String, dynamic> global) {
    market_cap_change_percentage_24h_usd =
        global['market_cap_change_percentage_24h_usd'];
    widget.total_volume = global['total_volume'];
    widget.market_cap_percentage = global['market_cap_percentage'];
  }

  void setCoins(List<dynamic> coins) {
    widget.coins = coins;
  }

  Widget subText(BuildContext context, double value, dynamic price) {
    String text = value.toStringAsFixed(2);
    if (value > 0) {
      return ListTile(
          title: Text(
            "\$ $price",
            style: TextStyle(
              color: Colors.green,
              fontSize: ScreenUtil.getInstance().setWidth(28.0),
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.upgrade,
                size: ScreenUtil.getInstance().setWidth(32.0),
                color: Colors.green,
              ),
              Text(
                "$text %",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: ScreenUtil.getInstance().setWidth(24.0),
                ),
              )
            ],
          ));
    } else {
      return ListTile(
          title: Text(
            "\$ $price",
            style: TextStyle(
              color: Colors.red,
              fontSize: ScreenUtil.getInstance().setWidth(28.0),
            ),
          ),
          subtitle: Row(
            children: [
              Icon(Icons.vertical_align_bottom,
                  size: ScreenUtil.getInstance().setWidth(32.0),
                  color: Colors.red),
              Text(
                "$text %",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: ScreenUtil.getInstance().setWidth(24.0),
                ),
              ),
            ],
          ));
    }
  }

  Widget marketCapPercentage(value) {
    if (value.load == Load.error) {
      return ErrorPage1(
        message: errorMessage,
        reloadBack: value.getGlobal,
      );
    } else if (value.load == Load.loading) {
      return LoadingPage1();
    } else if (value.load == Load.finish) {
      return RefreshIndicator(
        onRefresh: () async {
          return Future.delayed(Duration(seconds: 3), () {
            // 延迟5s完成刷新
            value.getGlobal_refresh();
          });
        },
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.3),
        color: Theme.of(context).backgroundColor,
        displacement: ScreenUtil.getInstance().setWidth(72.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Divider(
            height: ScreenUtil.getInstance().setWidth(36.0),
            color: Colors.red,
          ),
          Text(
            S.of(context).g_key_3,
            style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(32.0),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setWidth(18.0),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.coins.length,
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> value = widget.coins[index];
                return Column(
                  children: <Widget>[
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ListTile(
                            leading: FadeInImage.assetNetwork(
                              placeholder:
                                  "assets/images/${value['symbol']}.png",
                              image: "${value['image']}",
                              height: ScreenUtil.getInstance().setWidth(63.0),
                              width: ScreenUtil.getInstance().setWidth(63.0),
                            ),
                            title: Text(
                              value['name'],
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: ScreenUtil.getInstance().setSp(28.0),
                              ),
                            ),
                            //fontSize: 20, fontWeight: FontWeight.bold,
                            subtitle: Text(
                              value['symbol'],
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: ScreenUtil.getInstance().setSp(24.0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: subText(
                              context,
                              value['price_change_percentage_24h'],
                              value['current_price']),
                        ),
                      ],
                    ),
                    Divider(
                      height: ScreenUtil.getInstance().setWidth(1.8),
                    ),
                  ],
                );
              },
            ),
          ),
        ]),
      );
    } else {
      return Container();
    }
  }

  Widget marketChange(value) {
    String t = value.market_cap_change_percentage_24h_usd.toStringAsFixed(4);
    if (value.market_cap_change_percentage_24h_usd > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_upward_sharp,
              size: ScreenUtil.getInstance().setWidth(80.0),
              color: Colors.green),
          Text("$t%",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: ScreenUtil.getInstance().setSp(72.0),
                  fontWeight: FontWeight.bold)),
        ],
      );
    } else if (value.market_cap_change_percentage_24h_usd == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_right_alt_sharp,
              size: ScreenUtil.getInstance().setWidth(80.0),
              color: Colors.white70),
          Text("$t%",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: ScreenUtil.getInstance().setSp(72.0),
                  fontWeight: FontWeight.bold)),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_downward_sharp,
              size: ScreenUtil.getInstance().setWidth(80.0), color: Colors.red),
          Text("$t%",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: ScreenUtil.getInstance().setSp(72.0),
                  fontWeight: FontWeight.bold)),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketsProvider>(
      builder: (context,value,child){
        return Scaffold(
          appBar: AppBar(
            //backgroundColor: Theme.of(context).backgroundColor,
            title: Text(S.of(context).g_key_0),
            actions: [
              IconButton(
                onPressed: (){
                  if(value.load==Load.loading){
                    return;
                  }
                  if(value.load==Load.finish){
                    value.getGlobal_refresh();
                  }else{
                    value.getGlobal();
                  }
                },
                icon: Icon(Icons.wifi_protected_setup_outlined,),
              ),
            ],
          ),
          // backgroundColor: Colors.blue,
          body: Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil.getInstance().setWidth(18.0),
              left: ScreenUtil.getInstance().setWidth(18.0),
              right: ScreenUtil.getInstance().setWidth(18.0),
            ),
            child: Column(
              children: [
                //const SizedBox(height: 10),
                Container(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil.getInstance().setWidth(36.0),
                      horizontal: ScreenUtil.getInstance().setWidth(18.0),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil.getInstance().setWidth(36.0)),
                      ),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Column(children: [
                      Text(
                        S.of(context).g_key_1,
                        style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(32.0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setWidth(36.0)),
                      marketChange(value),
                      SizedBox(height: ScreenUtil.getInstance().setWidth(18.0)),
                      Text(S.of(context).g_key_2,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil.getInstance().setSp(30.0),
                              fontWeight: FontWeight.w300)),
                    ])),
                // const SizedBox(height: 10),
                Expanded(
                  // flex: 4,
                  child: marketCapPercentage(value),
                  // marketCapPercentage(context),
                ),
              ],
            ),
          ),
        );
      },
    );
    String t = market_cap_change_percentage_24h_usd.toStringAsFixed(4);
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).backgroundColor,
        title: Text(S.of(context).g_key_0),
        actions: [
          IconButton(
            onPressed: (){
              if(_load==Load.loading){
                return;
              }
              if(_load==Load.finish){
                _getGlobal_refresh();
              }else{
                _getGlobal();
              }
            },
            icon: Icon(Icons.wifi_protected_setup_outlined,),
          ),
        ],
      ),
      // backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.only(
          top: ScreenUtil.getInstance().setWidth(18.0),
          left: ScreenUtil.getInstance().setWidth(18.0),
          right: ScreenUtil.getInstance().setWidth(18.0),
        ),
        child: Column(
          children: [
            //const SizedBox(height: 10),
            Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil.getInstance().setWidth(36.0),
                  horizontal: ScreenUtil.getInstance().setWidth(18.0),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil.getInstance().setWidth(36.0)),
                  ),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Column(children: [
                  Text(
                    S.of(context).g_key_1,
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(32.0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: ScreenUtil.getInstance().setWidth(36.0)),
                  marketChange(context),
                  SizedBox(height: ScreenUtil.getInstance().setWidth(18.0)),
                  Text(S.of(context).g_key_2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil.getInstance().setSp(30.0),
                          fontWeight: FontWeight.w300)),
                ])),
            // const SizedBox(height: 10),
            Expanded(
              // flex: 4,
              child: marketCapPercentage(context),
              // marketCapPercentage(context),
            ),
          ],
        ),
      ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
