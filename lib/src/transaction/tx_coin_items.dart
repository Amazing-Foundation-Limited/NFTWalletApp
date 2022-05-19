
import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/enum/load.dart';
import 'package:kingloryapp/src/component/error_page.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/http/network_api.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/src/transaction/tx_item_info.dart';
import 'package:kingloryapp/src/transaction/tx_list_item.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';

class TxCoinItems extends StatefulWidget {
  final String name;
  const TxCoinItems({Key? key, required this.name}) : super(key: key);

  @override
  TxCoinItemsState createState() => TxCoinItemsState();
}

class TxCoinItemsState extends State<TxCoinItems> {
  List<dynamic> items = [];
  Load _load = Load.loading; //当前加载状态
  String _errorMessage = ""; //数据加载提示信息

  //bool showLoading=true;
  //int loadError=0;//0没有报错，1报错，2数据列表为空
  //String errorStr='';
  @override
  void initState() {
    super.initState();
    _initCoinInfo(Load.loading);
  }

  _initCoinInfo(Load lType) async {
    setState(() {
      _load=lType;
    });
    var r;
    if (widget.name == "MTK_E") {
      final pro = Provider.of<WalletsProviderDefault>(context, listen: false).mtk_eCoin();
      final address = await pro!.address;
      r = await Api.internalTxList(address.toString());
    } else if (widget.name == "MTK") {
      final pro = Provider.of<WalletsProviderDefault>(context, listen: false).mtkCoin();
      final address = await pro!.address;
      r = await Api.transactionListFromMtk(address.toString());

    } else if (widget.name == "BNB") {
      final pro = Provider.of<WalletsProviderDefault>(context, listen: false).bscCoin();
      final address = await pro!.address;
      r = await Api.accountList(address.toString());

    } else if (widget.name == "ETH") {
      final pro = Provider.of<WalletsProviderDefault>(context, listen: false).ethCoin();
      final address = await pro!.address;
      r = await Api.accountListFromEth(address.toString());
    }else if (widget.name == "BNB_E") {
      final pro = Provider.of<WalletsProviderDefault>(context, listen: false).bnb_eCoin();
      final address = await pro!.address;
      r = await Api.transactionListFromMtk_contract(address.toString());

    } else if (widget.name == "ETH_E") {
      final pro = Provider.of<WalletsProviderDefault>(context, listen: false).eth_eCoin();
      final address = await pro!.address;
      r = await Api.transactionListFromMtk_contract(address.toString());
    }else{
      setState(() {
        _load=Load.error;
        _errorMessage=S.of(context).g_key_5;
      });
      return;
    }
    if(r['error']){
      setState(() {
        _load=Load.error;
        _errorMessage=S.of(context).g_key_5;
      });
    }else{
      if (r['data']['message'] == 'OK') {
        final result = r['data']['result'].toList();
        if(result.length==0){
          setState(() {
            items = result;
            _load=Load.finish;
            _errorMessage=S.of(context).g_key_132;
          });
        }else{
          setState(() {
            items = result;
            _load=Load.finish;
            _errorMessage="";
          });
        }

      }else{
        setState(() {
          _load=Load.error;
          _errorMessage=r['data']['message'];
        });
      }
    }
  }

  _onSelect(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TxItemInfo(detail: items[index],);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(S.of(context).g_key_74),
      ),
      body: listWidget(),

    );
  }
  listWidget(){
    if(_load==Load.error){
      return Container(
        height: double.infinity,
        child: ErrorPage1(
          message: _errorMessage,
          reloadBack: (){
            _initCoinInfo(Load.loading);
          },
        ),
      );
    }
    if(_load==Load.loading){
      Color bgColor=Color(0xffe4e4e4);
      return LoadingPage2(ListView.builder(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
        itemCount: 8,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
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
                          Container(
                            height: ScreenUtil.getInstance().setWidth(30.0),
                            width: ScreenUtil.getInstance().setWidth(30.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(30.0))),
                              color: bgColor,
                            ),
                          ),
                          SizedBox(width: ScreenUtil.getInstance().setWidth(10.0),),
                          Container(
                            color: bgColor,
                            height: ScreenUtil.getInstance().setWidth(30.0),
                            width: ScreenUtil.getInstance().setWidth(300.0),
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
                                Container(
                                  color: bgColor,
                                  height: ScreenUtil.getInstance().setWidth(20.0),
                                  width: ScreenUtil.getInstance().setWidth(200.0),
                                ),
                                SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                                Container(
                                  color: bgColor,
                                  height: ScreenUtil.getInstance().setWidth(20.0),
                                  width: ScreenUtil.getInstance().setWidth(250.0),
                                ),
                                SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                                Container(
                                  color: bgColor,
                                  height: ScreenUtil.getInstance().setWidth(20.0),
                                  width: ScreenUtil.getInstance().setWidth(200.0),
                                ),
                                SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                                Container(
                                  color: bgColor,
                                  height: ScreenUtil.getInstance().setWidth(20.0),
                                  width: ScreenUtil.getInstance().setWidth(250.0),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(56.0))),
                              color: bgColor,
                            ),

                            height: ScreenUtil.getInstance().setWidth(56.0),
                            width: ScreenUtil.getInstance().setWidth(56.0),
                          ),
                        ],
                      ),
                    ],
                  ))
          );
        },
      ));
    }else if(_load==Load.finish || _load==Load.refresh)
    return RefreshIndicator(
      onRefresh: ()async{
        return Future.delayed(Duration(seconds: 3), () {
          if (_load == Load.loading || _load == Load.refresh|| _load == Load.nextPage) {
            return;
          }
          // 延迟5s完成刷新
          _initCoinInfo(Load.refresh);
        });
      },
      backgroundColor: Theme.of(context).textTheme.headline2!.color,
      color: Theme.of(context).backgroundColor,
      displacement: ScreenUtil.getInstance().setWidth(72.0),
      child: ListView.builder(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
        itemCount: items.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return InkWell(
            child: TransactionItem(
              details: item, name: widget.name,
            ),
            onTap: () => _onSelect(index),
          );
        },
      ),
    );
  }
}


