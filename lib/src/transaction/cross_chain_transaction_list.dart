import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/enum/load.dart';
import 'package:kingloryapp/src/component/error_page.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/src/state/cc_transaction_provider.dart';
import 'package:kingloryapp/src/transaction/cross_chain_transaction_info.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//跨链转账列表
class CrossChainTransactionList extends StatefulWidget{
  @override
  _CrossChainTransactionListState createState()=>_CrossChainTransactionListState();
}
class _CrossChainTransactionListState extends State<CrossChainTransactionList>{
  List<TransactionData1> items = [];
  Load _load = Load.loading; //当前加载状态
  String _errorMessage = ""; //数据加载提示信息
  int errorType=0;
  bool lastPage=false;
  int limit=10;
  final oCcy = NumberFormat("#,##0.0####", "en_US");
  ScrollController _scrollController=ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectData(0);
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixel = _scrollController.position.pixels;
      /*if(pixel>1500){
        cp.setShowTop(true);
      }else{
        cp.setShowTop(false);
      }*/
      if(pixel>maxScroll-200){
        if (lastPage==false && (_load==Load.finish || _load==Load.error)) {
          _initCoinInfo(Load.nextPage);
          /*if(ProviderUtils.socketProFrend(context).onlineUserLoading==false){
            if(ProviderUtils.socketProFrend(context).onlineAllLoad==false){
              //可能未加载完,去加载
              ProviderUtils.socketProFrend(context).updateMoreOnlineUser();
            }
          }*/
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(S.of(context).g_key_142),
      ),
      body: listWidget(),
    );
  }
  listWidget(){
    if(_load==Load.error){
      return Container(
        height: double.infinity,
        child: ErrorPage1(
          type: errorType,
          message: _errorMessage,
          reloadBack: (){
            _initCoinInfo(Load.loading);
          },
        ),
      );
    }
    else if(_load==Load.loading){
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
    }
    else if(_load==Load.finish || _load==Load.refresh || _load==Load.nextPage)
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
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
          itemCount: items.length+1,
          itemBuilder: (BuildContext context, int index) {
            if(index==items.length){
              String str=S.of(context).g_key_106;
              bool showProgress=true;
              if(lastPage){
                str=S.of(context).g_key_105;
                showProgress=false;
              }
              if(_load==Load.error){
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
              TransactionData1 item = items[index];
              return InkWell(
                child: itemWidget(item),
                onTap: () => _onSelect(index),
              );
            }
          },
        ),
      );
  }
  itemWidget(TransactionData1 item){
    String time='';
    if(item.time!=null || item.time!=''){
      int timeStamp=int.parse(item.time)*1000;
      //time = DateTime.fromMillisecondsSinceEpoch(timeStamp).toString();
      time=DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(timeStamp));
    }
    final value = oCcy.format(item.value);
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
                    Icon(Icons.watch_later,color: Theme.of(context).textTheme.headline2!.color,
                      size: ScreenUtil.getInstance().setWidth(35.0),
                    ),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(10.0),),
                    Text(time,
                      style:
                      TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(26.0),
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        item.state,
                        style:
                        TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(26.0),
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                        textAlign: TextAlign.right,
                      ),
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
                          Text(S.of(context).g_key_75,style:TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(26.0),
                              color: Theme.of(context).textTheme.headline1!.color),
                          ),
                          Text(item.from.substring(0, 8),
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  color: Theme.of(context).textTheme.headline1!.color)),
                          SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                          Text(S.of(context).g_key_38,style:TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(26.0),
                              color: Theme.of(context).textTheme.headline1!.color),
                          ),
                          Text(item.receive==null?'':item.receive.substring(0,8),
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(26.0),
                                color: Theme.of(context).textTheme.headline1!.color),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: ScreenUtil.getInstance().setWidth(200.0),
                      child: Text("$value",
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(26.0),
                            color: Theme.of(context).textTheme.headline2!.color
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(40.0)),
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
              ],
            ))
    );
  }
  _onSelect(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CrossChainTransactionInfo(items[index]);
    }));
  }
  _initCoinInfo(Load lType) async {
    setState(() {
      _load=lType;
    });
    int itemLength=items.length;
    if(_load==Load.refresh){
      itemLength=0;
    }
    List<TransactionData1> tl=await WalletDatabaseProvider.dbProvider.getCrossChainTransaction(limit,itemLength,);
    await Provider.of<CCTransactionProvider>(context,listen: false).getNotDoneValue();
    if(_load==Load.refresh || _load==Load.loading){
      if(tl.length==0){
        setState(() {
          _load=Load.error;
          _errorMessage=S.of(context).g_key_143;
          errorType=1;
        });
        return;
      }
    }
    if(tl.length<limit){
      this.lastPage=true;
    }
    if(_load==Load.refresh){
      items=[];
    }
    items.addAll(tl);
    setState(() {
      _load=Load.finish;
    });
  }
  _selectData(int offset)async{
    items=await WalletDatabaseProvider.dbProvider.getCrossChainTransaction(limit, offset);
    setState(() {
      if(items.length==0){
        _load=Load.error;
        _errorMessage=S.of(context).g_key_143;
        errorType=1;
        lastPage=true;
      }else if(items.length<10 && items.length>0){
        lastPage=true;
        _load=Load.finish;
        items;
      }
    });
  }
}