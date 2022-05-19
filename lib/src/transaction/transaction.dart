import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/src/transaction/cross_chain_transaction_list.dart';
import 'package:kingloryapp/src/transaction/tx_coin_items.dart';
import 'package:kingloryapp/src/transaction/tx_list_item.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:kingloryapp/util/toast_utils.dart';
import 'package:provider/provider.dart';

class TransactionWidget extends StatefulWidget {
  TransactionWidget({Key? key}) : super(key: key);

  @override
  TransactionWidgetState createState() => TransactionWidgetState();
}

class TransactionWidgetState extends State<TransactionWidget> {
  List<String> infoList = [];
  @override
  void initState() {
    super.initState();
    // _subTx();
  }

  // _subTx() async {
  //   final r =
  //   await Api.accountList('0x6238ca068866e3d7009ca3bedd3d3142dde19e66');
  //   // print(r);
  //   final c = await Api.internalTxList(
  //       '0x6238ca068866e3d7009ca3bedd3d3142dde19e66');
  //   print(c);
  //   if (r['message'] == 'OK') {
  //     final result = r['result'].toList();
  //     // print(result);
  //     setState(() {
  //       items = result;
  //     });
  //     // print(result);
  //   }
  // }

  _onSelect(String key) {
    //final ws = Provider.of<WalletsProviderDefault>(context, listen: false).wallet();
    //if (ws.isNotEmpty) {
      /*EthProvider? eth= Provider.of<WalletsProviderDefault>(context, listen: false).coinByName(item['name']);
      if(eth==null){
        ToastUtils.show(S.of(context).g_key_137);
        return;
      }*/
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return TxCoinItems(name: key);
      }));
    //}else{
    //  ToastUtils.show(S.of(context).g_key_124);
    //}

  }
  //跨链转账
  _onSelect_cross() {
    //final ws = Provider.of<WalletsProviderDefault>(context, listen: false).wallet();
    //if (ws.isNotEmpty) {
    /*EthProvider? eth= Provider.of<WalletsProviderDefault>(context, listen: false).coinByName(item['name']);
      if(eth==null){
        ToastUtils.show(S.of(context).g_key_137);
        return;
      }*/
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CrossChainTransactionList();
    }));
    //}else{
    //  ToastUtils.show(S.of(context).g_key_124);
    //}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).g_key_32),
        ),
        body: Consumer<WalletsProviderDefault>(
          builder: (context,value,child){
            List<String> keyList=value.coins().keys.toList();
            return Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil.getInstance().setWidth(20.0),
                    horizontal: ScreenUtil.getInstance().setWidth(30.0),
                  ),
                  itemCount: keyList.length==0?0:keyList.length+1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    if(index==keyList.length){
                      return InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(32.0)),
                          margin: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(10.0)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
                            color: Theme.of(context).cardTheme.color,
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(40.0)),
                                child: Image.asset(
                                  'assets/images/mtk.png',
                                  width: ScreenUtil.getInstance().setWidth(66.0),
                                  height: ScreenUtil.getInstance().setWidth(66.0),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Text(S.of(context).g_key_142,
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.headline1!.color,
                                    fontSize: ScreenUtil.getInstance().setSp(30.0),
                                  ),
                                ),

                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(40.0)),
                                width: ScreenUtil.getInstance().setWidth(56.0),
                                height: ScreenUtil.getInstance().setWidth(56.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(56.0))),
                                  border: Border.all(
                                    color: Color(0xffe67c3b),
                                    width: ScreenUtil.getInstance().setWidth(2.0),
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: ScreenUtil.getInstance().setWidth(30.0),
                                  color: Color(0xffe67c3b),
                                ),
                              ),

                            ],
                          ),
                        ),
                        onTap: () {
                          _onSelect_cross();
                        },
                      );
                    }
                    EthProvider? eth = value.coinByName(keyList[index]);
                    Map<String,dynamic> item=eth!.info;
                    return InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(32.0)),
                        margin: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(10.0)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
                          color: Theme.of(context).cardTheme.color,
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(40.0)),
                              child: Image.asset(
                                'assets/images/${item['name_m']}.png',
                                width: ScreenUtil.getInstance().setWidth(66.0),
                                height: ScreenUtil.getInstance().setWidth(66.0),
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${item['name_k']}-${S.of(context).g_key_73}",
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.headline1!.color,
                                      fontSize: ScreenUtil.getInstance().setSp(30.0),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: item['isERC20'],
                                        child: Container(
                                          margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10.0)),
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
                                        visible: item['changeIndex']!='',
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
                                          child: Text(item['changeIndex'],style: TextStyle(
                                            color: Theme.of(context).textTheme.headline2!.color,
                                            fontSize: ScreenUtil.getInstance().setSp(18.0),
                                          ),),
                                          height: ScreenUtil.getInstance().setWidth(34.0),
                                          //width: ScreenUtil.getInstance().setWidth(50.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(40.0)),
                              width: ScreenUtil.getInstance().setWidth(56.0),
                              height: ScreenUtil.getInstance().setWidth(56.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(56.0))),
                                border: Border.all(
                                  color: Color(0xffe67c3b),
                                  width: ScreenUtil.getInstance().setWidth(2.0),
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: ScreenUtil.getInstance().setWidth(30.0),
                                color: Color(0xffe67c3b),
                              ),
                            ),

                          ],
                        ),
                      ),
                      onTap: () => _onSelect(keyList[index]),
                    );
                  }),
            );
          },
        ),

    );
  }
}
