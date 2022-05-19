
import 'package:flutter/foundation.dart';
import 'package:kingloryapp/src/component/enum/load.dart';
import 'package:kingloryapp/src/http/network_api.dart';
import 'package:kingloryapp/util/toast_utils.dart';

class MarketsProvider with ChangeNotifier, DiagnosticableTreeMixin {

  List< dynamic > _coinslist = [];
  List< dynamic > get coinslist=>_coinslist;

  Map<String, dynamic> _markets = {};
  Map<String, dynamic> get markets=>_markets;
  List<dynamic > coins_vs_usdt_price = [];
  //int update_timestamp = 0;


  ///markets页
  double _market_cap_change_percentage_24h_usd = 0.0;
  double get market_cap_change_percentage_24h_usd=>_market_cap_change_percentage_24h_usd;
  Load _load = Load.loading; //当前加载状态
  Load get load =>_load;
  String _errorMessage = ""; //数据加载提示信息
  String get errorMessage=>_errorMessage;
  int _coinsPageNumber=1;//当前是第几页
  int get coinsPageNumber=>_coinsPageNumber;
  int _coinsPageRowCount=10;//每页数据条数
  bool _coinsLastPage=false;//是否是最后一页
  bool get coinsLastPage=>_coinsLastPage;
  bool _showTop=false;//是否显示底部返回到顶部的按钮
  bool get showTop=>_showTop;

  MarketsProvider(){
    initCoinsProvider();
  }
  initCoinsProvider() async {
    await getCoinsPriceList();
    await getMarkets();
    notifyListeners();
    //update_timestamp = DateTime.now().millisecondsSinceEpoch;
  }
  //获取币价列表
  //isAddTo是否追加，默认false
  getCoinsPriceList({bool isAddTo=false})async{
    var coinsData=await Api.coinsPriceList(per_page: _coinsPageRowCount,page: coinsPageNumber);
    if(coinsData['error']==false){
      if(isAddTo){
        _coinslist.addAll(coinsData['data']);
      }else{
        _coinslist=coinsData['data'];
      }

      setLoadType(Load.finish);
      if(coinsData['data'].length<_coinsPageRowCount){
        _coinsLastPage=true;
      }
      return true;
    }else{
      setLoadType(Load.error);
      _errorMessage = coinsData['data'];
      return false;
    }
  }
  //获取市场列表
  getMarkets()async{
    var marketsData=await Api.markets();
    if(marketsData['error']==false){
      _markets=marketsData['data'];
      setLoadType(Load.finish);
      setGlobal();
      return true;
    }else{
      setLoadType(Load.error);
      _errorMessage = marketsData['data'];
      return false;
    }
  }


  ///warkets页面
  getGlobal() async {
    setLoadType(Load.loading);
    notifyListeners();
    if(await getMarkets()){
      await getCoinsPriceList();
    }else{
      _load = Load.error;
    }
    notifyListeners();

  }

  void setGlobal() {
    _market_cap_change_percentage_24h_usd = markets['data']['market_cap_change_percentage_24h_usd'];
    //widget.total_volume = global['total_volume'];
    //widget.market_cap_percentage = global['market_cap_percentage'];
  }
  setLoadType(Load l){
    _load=l;
  }
  //下一页
  getCoinsPriceList_next()async{
    if(coinsLastPage){
      return;
    }
    _coinsPageNumber++;
    _load=Load.loading;
    if(await getCoinsPriceList(isAddTo: true)){
      //_load=Load.finish;
    }else{
      _coinsPageNumber--;
      ToastUtils.show(errorMessage);
    }
    notifyListeners();

  }
  //刷新列表
  getGlobal_refresh() async {
    if(await getMarkets()){
      _coinsPageNumber=0;
      await getCoinsPriceList();
    }else{
      ToastUtils.show(errorMessage);
    }
    notifyListeners();
  }
  //设置置顶按钮状态isShow：true显示，false不显示
  setShowTop(bool isShow){
    _showTop=isShow;
    notifyListeners();
  }

  reload(){
    notifyListeners();
  }
}