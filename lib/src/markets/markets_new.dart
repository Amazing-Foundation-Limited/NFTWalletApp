import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/enum/load.dart';
import 'package:kingloryapp/src/component/error_page.dart';
import 'package:kingloryapp/src/component/line_chart.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/markets_provider.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';

class MarketsWidget extends StatefulWidget {
  Map<String, dynamic> market_cap_percentage = {};
  Map<String, dynamic> total_volume = {};
  List<dynamic> coins = [];

  MarketsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MarketWidgetState();
}

class MarketWidgetState extends State<MarketsWidget>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController=ScrollController();
  //double market_cap_change_percentage_24h_usd = 0.0;
  //Load _load = Load.loading; //当前加载状态
  //String errorMessage = ""; //数据加载提示信息
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixel = _scrollController.position.pixels;
      MarketsProvider cp=Provider.of<MarketsProvider>(context,listen: false);
      if(pixel>1500){
        cp.setShowTop(true);
      }else{
        cp.setShowTop(false);
      }
      if(pixel>maxScroll-200){
        if (cp.coinsLastPage==false && (cp.load==Load.finish || cp.load==Load.error)) {
          cp.getCoinsPriceList_next();
          /*if(ProviderUtils.socketProFrend(context).onlineUserLoading==false){
            if(ProviderUtils.socketProFrend(context).onlineAllLoad==false){
              //可能未加载完,去加载
              ProviderUtils.socketProFrend(context).updateMoreOnlineUser();
            }
          }*/
        }
      }
    });
    //_getGlobal();
  }
/*
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
          _load=Load.finish;
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
*/
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

  Widget marketCapPercentage(MarketsProvider value) {
    if (value.load == Load.error) {
      if(value.coinslist.length!=0){
        return listWidget(value);
      }
      return ErrorPage1(
        message: value.errorMessage,
        reloadBack: value.getGlobal,
      );
    } else if (value.load == Load.loading) {
      if(value.coinslist.length!=0){
        return listWidget(value);
      }
      Color bgColor=Color(0xffe4e4e4);
      return LoadingPage2(
          ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil.getInstance().setWidth(30.0),
                    vertical: ScreenUtil.getInstance().setWidth(22.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: ScreenUtil.getInstance().setWidth(26.0),
                      width: ScreenUtil.getInstance().setWidth(34.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13.0)),
                        color: bgColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                          ScreenUtil.getInstance().setWidth(48.0)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(72.0))),
                          color: bgColor,
                        ),
                        height: ScreenUtil.getInstance().setWidth(72.0),
                        width: ScreenUtil.getInstance().setWidth(72.0),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: ScreenUtil.getInstance().setWidth(290.0),
                          height: ScreenUtil.getInstance().setWidth(30.0),
                          color: bgColor,
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                        Container(
                          width: ScreenUtil.getInstance().setWidth(170.0),
                          height: ScreenUtil.getInstance().setWidth(30.0),
                          color: bgColor,
                        )
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenUtil.getInstance().setWidth(120.0),
                            height: ScreenUtil.getInstance().setWidth(30.0),
                            color: bgColor,
                          ),
                          SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                          Container(
                            width: ScreenUtil.getInstance().setWidth(80.0),
                            height: ScreenUtil.getInstance().setWidth(30.0),
                            color: bgColor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )

      );
    } else if (value.load == Load.finish || value.load == Load.refresh || value.load == Load.nextPage) {
      return listWidget(value);
    }
    else {
      return Container();
    }
  }
  Widget listWidget(MarketsProvider value){
    return RefreshIndicator(
      onRefresh: () async {
        return Future.delayed(Duration(seconds: 3), () {
          if (value.load == Load.loading || value.load == Load.refresh|| value.load == Load.nextPage) {
            return;
          }
          // 延迟5s完成刷新
          value.getGlobal_refresh();
        });
      },
      backgroundColor: Theme.of(context).textTheme.headline2!.color,
      color: Theme.of(context).backgroundColor,
      displacement: ScreenUtil.getInstance().setWidth(72.0),
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.only(
          top: ScreenUtil.getInstance().setWidth(30.0),
          left: ScreenUtil.getInstance().setWidth(36.0),
          right: ScreenUtil.getInstance().setWidth(36.0),
          bottom: ScreenUtil.getInstance().setWidth(30.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).g_key_3,
              style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(28.0),
                color: Theme.of(context).textTheme.headline1!.color,
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: value.coinslist.length+1,
                // shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  if(index==value.coinslist.length){
                    String str=S.of(context).g_key_106;
                    bool showProgress=true;
                    if(value.coinsLastPage){
                      str=S.of(context).g_key_105;
                      showProgress=false;
                    }
                    if(value.load==Load.error){
                      str=S.of(context).g_key_5;
                      showProgress=false;
                    }
                    //是否是最后一条
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil.getInstance().setWidth(22.0)),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            str,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.headline1?.color,
                              fontSize: ScreenUtil.getInstance().setSp(28.0),
                            ),
                          ),
                          showProgress?Container(
                            width: ScreenUtil.getInstance().setSp(28.0),
                            height: ScreenUtil.getInstance().setSp(28.0),
                            child: CircularProgressIndicator(),
                          ):SizedBox(),
                        ],
                      ),

                    );
                  }else{
                    Map<String, dynamic> rowValue = value.coinslist[index];
                    double price_change_percentage_24h=(rowValue['price_change_percentage_24h']==null || rowValue['price_change_percentage_24h']=='')?0:rowValue['price_change_percentage_24h'];

                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil.getInstance().setWidth(22.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: ScreenUtil.getInstance().setWidth(202.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                numWidget(index),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil.getInstance().setWidth(48.0)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:"assets/img/list_default.png",
                                    //"assets/images/${rowValue['symbol']}.png",
                                    image: "${rowValue['image']}",
                                    height: ScreenUtil.getInstance().setWidth(72.0),
                                    width: ScreenUtil.getInstance().setWidth(72.0),
                                  ),
                                ),
                              ],
                            ),
                          ),


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                rowValue['name'],
                                style: TextStyle(
                                  fontSize:
                                  ScreenUtil.getInstance().setWidth(28.0),
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color,
                                  height: 1.3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                rowValue['symbol'],
                                style: TextStyle(
                                  fontSize:
                                  ScreenUtil.getInstance().setWidth(28.0),
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .color,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rowValue['current_price'].toString(),
                                  style: TextStyle(
                                    fontSize:
                                    ScreenUtil.getInstance().setWidth(28.0),
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color,
                                    height: 1.3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${price_change_percentage_24h > 0 ? "+" : ""}${price_change_percentage_24h}",
                                  style: TextStyle(
                                    fontSize:
                                    ScreenUtil.getInstance().setWidth(28.0),
                                    color:
                                    price_change_percentage_24h > 0
                                        ? Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .color
                                        : Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .color,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //获取序号
  numWidget(int index) {
    //默认亮色
    bool isLight = true;
    late Map<String, Color> colorMap;
    String numStr = "";
    if (Theme.of(context).brightness == Brightness.dark) {
      isLight = false;
    }
    if (isLight) {
      colorMap = {"bgColor": Color(0xffe4e4e4), 'textColor': Color(0xff222222)};
    } else {
      colorMap = {"bgColor": Color(0xffe4e4e4), 'textColor': Color(0xff222222)};
    }
    if (index == 0) {
      if (isLight) {
        colorMap = {
          "bgColor": Color(0xffe75160),
          'textColor': Color(0xffffffff)
        };
      } else {
        colorMap = {
          "bgColor": Color(0xffe75160),
          'textColor': Color(0xffffffff)
        };
      }
    } else if (index == 1) {
      if (isLight) {
        colorMap = {
          "bgColor": Color(0xfff67e54),
          'textColor': Color(0xffffffff)
        };
      } else {
        colorMap = {
          "bgColor": Color(0xfff67e54),
          'textColor': Color(0xffffffff)
        };
      }
    } else if (index == 2) {
      if (isLight) {
        colorMap = {
          "bgColor": Color(0xffffbc4e),
          'textColor': Color(0xffffffff)
        };
      } else {
        colorMap = {
          "bgColor": Color(0xffffbc4e),
          'textColor': Color(0xffffffff)
        };
      }
    }
    if (index + 1 < 10) {
      numStr = "0${(index + 1).toString()}";
    } else {
      numStr = (index + 1).toString();
    }

    return Container(
      height: ScreenUtil.getInstance().setWidth(26.0),
      //width: ScreenUtil.getInstance().setWidth(34.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(13.0))),
        color: colorMap['bgColor'],
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(8.0)),
      child: Text(
        numStr,
        style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(18.0),
          color: colorMap['textColor'],
        ),
      ),
    );
  }

  Widget marketChange(value) {
    String t = value.market_cap_change_percentage_24h_usd.toStringAsFixed(4);
    if (value.market_cap_change_percentage_24h_usd > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$t%",
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline4!.color,
                  fontSize: ScreenUtil.getInstance().setSp(60.0),
                  fontWeight: FontWeight.bold)),
        ],
      );
    } else if (value.market_cap_change_percentage_24h_usd == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$t%",
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                  fontSize: ScreenUtil.getInstance().setSp(60.0),
                  fontWeight: FontWeight.bold)),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$t%",
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline5!.color,
                  fontSize: ScreenUtil.getInstance().setSp(60.0),
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
            title: Text(S.of(context).g_key_0),
            actions: [
              InkWell(
                  onTap: () {
                    if (value.load == Load.loading || value.load == Load.refresh) {
                      return;
                    }
                    if (value.load == Load.finish) {
                      value.setLoadType(Load.refresh);
                      value.reload();
                      value.getGlobal_refresh();
                    } else {
                      value.getGlobal();
                    }
                  },
                  child: Container(
                    width: 66,
                    height: 40,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/img/shuaxin.png',
                      width: 20,
                      height: 20,
                    ),
                  )),
            ],
          ),
          body: Container(
            child: Column(
              children: [
                _topWidget_old(value),
                // const SizedBox(height: 10),
                Expanded(
                  // flex: 4,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: marketCapPercentage(value),
                      ),
                      Positioned.fill(
                        child: Visibility(
                          visible: value.load==Load.refresh,
                          child: LoadingPage1(),
                        ),
                      ),
                    ],
                  ),

                  // marketCapPercentage(context),
                ),
              ],
            ),
          ),
          floatingActionButton: Visibility(
            visible: value.showTop,
            child: Container(
              width: ScreenUtil.getInstance().setWidth(80.0),
              height: ScreenUtil.getInstance().setWidth(80.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: ScreenUtil.getInstance().setWidth(1.0),
                    color:Theme.of(context).textTheme.headline2!.color!,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(80.0)))
              ),
              child: IconButton(
                icon: Icon(Icons.vertical_align_top),
                onPressed: (){
                  _scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.bounceInOut);
                },
              ),
            ),
          ),
        );
      },
    );
  }
  _topWidget(MarketsProvider value){
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setWidth(36.0),
        left: ScreenUtil.getInstance().setWidth(36.0),
        right: ScreenUtil.getInstance().setWidth(36.0),
        bottom: ScreenUtil.getInstance().setWidth(30.0),
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: ScreenUtil.getInstance().setWidth(2.0),
            color: Theme.of(context).brightness==Brightness.light?Theme.of(context).primaryColor:Color(0xff4b4b4b),
          ),
          bottom: BorderSide(
            width: ScreenUtil.getInstance().setWidth(20.0),
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).g_key_1,
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(28.0),
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
              Container(
                width: ScreenUtil.getInstance().setWidth(90.0),
                height: ScreenUtil.getInstance().setWidth(40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                      ScreenUtil.getInstance().setWidth(40.0))),
                  color: Theme.of(context).textTheme.headline2!.color,
                ),
                child: Text(
                  S.of(context).g_key_2,
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(22.0),
                    color: Theme.of(context).textTheme.headline3!.color,
                  ),
                ),
              )
            ],
          ),
          marketChange(value),
          SizedBox(
            height: ScreenUtil.getInstance().setWidth(10.0),
          ),
          LineChart(value.market_cap_change_percentage_24h_usd,isLight: Theme.of(context).brightness==Brightness.light,),
        ],
      ),
    );
  }
  _topWidget_old(MarketsProvider value){
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: ScreenUtil.getInstance().setWidth(2.0),
            color: Theme.of(context).brightness==Brightness.light?Theme.of(context).primaryColor:Color(0xff4b4b4b),
          ),
          bottom: BorderSide(
            width: ScreenUtil.getInstance().setWidth(20.0),
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness==Brightness.light?Theme.of(context).primaryColor: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
        ),
        margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).g_key_1,
              style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(28.0),
                color: Theme.of(context).textTheme.headline1!.color,
              ),
            ),
            SizedBox(height:ScreenUtil.getInstance().setSp(20.0)),
            marketChange(value),
            SizedBox(height:ScreenUtil.getInstance().setSp(20.0)),
            Text('${S.of(context).g_key_2} ${S.of(context).g_key_125}',
              style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(28.0),
                color: Theme.of(context).textTheme.headline1!.color,
              ),
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
