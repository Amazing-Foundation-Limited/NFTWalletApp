
import 'package:flutter/foundation.dart';
import 'package:kingloryapp/src/component/enum/load.dart';
import 'package:kingloryapp/src/http/network_api.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/util/toast_utils.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:intl/intl.dart';

class CoinsProvider with ChangeNotifier, DiagnosticableTreeMixin {

  List< dynamic > _coinslist = [];
  List< dynamic > get coinslist=>_coinslist;
  //List<dynamic> _price = [];
  //List< dynamic > get price=>_price;
  List<CoinModel> _coinModels=[];
  List<CoinModel> get coinModels=>_coinModels;

  Map<String, dynamic> _markets = {};
  Map<String, dynamic> get markets=>_markets;
  List<dynamic > coins_vs_usdt_price = [];
  int update_timestamp = 0;

  ///wallet
  String _totalBalance = "0.0";
  String get totalBalance=>_totalBalance;
  double _priceRate = 0.0;
  double get priceRate=>_priceRate;
  Load _load = Load.loading; //当前加载状态
  Load get load =>_load;
  String _errorMessage = ""; //数据加载提示信息
  String get errorMessage=>_errorMessage;

  ///Address
  bool addressListIsManage=false;//地址列表页，是否是编辑状态true编辑中，false非编辑状态
  List<AddressDb> _addressList=[];
  List<AddressDb> get addressList=>_addressList;
  bool addressList_showLoading=false;

  final oCcy = NumberFormat("#,##0.0####", "en_US");

  late WalletsProviderDefault walletsProviderDefault;


  CoinsProvider();

  Map<String, dynamic> getCoinPrice(String symbol) {
    if (verifyUpdate()) {
      update();
    }

    for (var element in coins_vs_usdt_price) {
      if (element['symbol'] == symbol) {
        return element;
      }
    }
    return {};
  }

  initCoinsProvider() async {
    await getCoinInfo();
    update_timestamp = DateTime.now().millisecondsSinceEpoch;
  }

  ///是否是刷新
  getCoinInfo({bool isRefresh=false}) async {
    if(isRefresh==false){
      _load = Load.loading; //当前加载状态
      notifyListeners();
    }
    getAddressList();
    var list=await Api.coinsPriceList();
    if (list['error']) {
      if(isRefresh==false) {
        _load = Load.error; //当前加载状态
        _errorMessage = list['data']; //数据加载提示信息
        notifyListeners();
      }else{
        ToastUtils.show(list['data']);
      }
      return;
    }else{
      _coinslist=list['data'];
    }
    await _setCoinsValue();
    if(isRefresh==false){
      _load = Load.finish; //当前加载状态
    }
    notifyListeners();
  }
  _setCoinsValue()async{
    if(walletsProviderDefault.wallet().isEmpty){
      return;
    }
    Map<String,dynamic> coinsDefault=walletsProviderDefault.coins();
    List<String> coinKeys=coinsDefault.keys.toList();
    double totalAmount=0;
    _coinModels=[];
    for(String k in coinKeys){
      CoinModel cm=await createCoinModel(k);
      totalAmount+=cm.value;
      _coinModels.add(cm);
    }
    _totalBalance = oCcy.format(totalAmount);
    reload();
  }

  Future<CoinModel> createCoinModel(String k)async{
    CoinModel cm=new CoinModel();
    switch(k){
      case 'ETH':
        EthProvider? ethPro = walletsProviderDefault.ethCoin();
        cm.coin=ethPro!.info;
        cm.balance=await ethPro.balance();
        cm.address=await ethPro.address;
        setCoinPrice('eth',coinslist,cm);
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
      case 'BNB':
        EthProvider? bscPro = walletsProviderDefault.bscCoin();
        cm.coin=bscPro!.info;
        cm.balance=await bscPro.balance();
        cm.address=await bscPro.address;
        setCoinPrice('bnb',coinslist,cm);
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
      case 'MTK':
        EthProvider? mtkPro = walletsProviderDefault.mtkCoin();
        cm.coin=mtkPro!.info;
        cm.balance=await mtkPro.balance();
        cm.address=await mtkPro.address;
        setCoinPrice('eos',coinslist,cm);
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
      case 'ETH_E':
        KGCProvider? eth_ePro = walletsProviderDefault.eth_eCoin();
        cm.coin=eth_ePro!.info;
        cm.balance=await eth_ePro.getBalance();
        cm.address=await eth_ePro.address;
        setCoinPrice('eth',coinslist,cm);
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
      case 'BNB_E':
        KGCProvider? bnb_ePro = walletsProviderDefault.bnb_eCoin();
        cm.coin=bnb_ePro!.info;
        cm.balance=await bnb_ePro.getBalance();
        cm.address=await bnb_ePro.address;
        setCoinPrice('bnb',coinslist,cm);
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
      case 'MTK_E':
        KGCProvider? mtk_ePro = walletsProviderDefault.mtk_eCoin();
        cm.coin=mtk_ePro!.info;
        cm.balance=await mtk_ePro.getBalance();
        cm.lockupBalance = await mtk_ePro.getLockupBalance();
        if (cm.lockupBalance != BigInt.from(0)) {
          cm.releaseBalance =  await mtk_ePro.getReleaseAmount();
        }
        cm.owner=await mtk_ePro.getOwner();
        cm.address=await mtk_ePro.address;
        setCoinPrice('eos',coinslist,cm);
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
    }
    return cm;
  }
  //获取余额，根据coin的key
  getBalance(String key)async{
    CoinModel cm=new CoinModel();
    for(CoinModel cModel in coinModels){
      if(key==cModel.coin['name_key']){
        cm=cModel;
        break;
      }
    }

    switch(key){
      case 'ETH':
        EthProvider? ethPro = walletsProviderDefault.ethCoin();
        cm.balance=ethPro!.balance();
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
      case 'BNB':
        EthProvider? bscPro = walletsProviderDefault.bscCoin();
        cm.balance=bscPro!.balance();
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
      case 'MTK':
        EthProvider? mtkPro = walletsProviderDefault.mtkCoin();
        cm.balance=mtkPro!.balance();
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
      case 'ETH_E':
        KGCProvider? eth_ePro = walletsProviderDefault.eth_eCoin();
        cm.balance=eth_ePro!.getBalance();
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
      case 'BNB_E':
        KGCProvider? bnb_ePro = walletsProviderDefault.bnb_eCoin();
        cm.balance=bnb_ePro!.getBalance();
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
      case 'MTK_E':
        KGCProvider? mtk_ePro = walletsProviderDefault.mtk_eCoin();
        cm.balance=mtk_ePro!.getBalance();
        cm.value=toEther(cm.balance.toString()) * cm.coinPrice;
        break;
    }
    double totalAmount=0;
    for(CoinModel cModel in coinModels){
      totalAmount+=cModel.value;
    }
    _totalBalance = oCcy.format(totalAmount);
    reload();
  }
  //设置币的价格和涨幅比例
  setCoinPrice(String name,List<dynamic> data,CoinModel cm){
    for (var element in data) {
      if(element['symbol']==name){
        cm.coinPrice=element['current_price'];
        cm.percentage=element['price_change_percentage_24h'];
        break;
      }
    }
  }
  getPriceFromName(String name, List<dynamic> data,) {
    for (var element in data) {
      if (name == "mtk") {
        name = "eos";
      }
      if(name == "mtk_e"){
        name="eos";
      }
      if (element['symbol'] == name) {
        return element['current_price'];
      }
    }
  }

  //修改钱包信息
  updateWallerInfo(){

  }

  bool verifyUpdate() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (update_timestamp == 0) {
      update_timestamp = now;
    } else if (now > update_timestamp + 600000) {
      update_timestamp = now;
    } else {
      return false;
    }

    return true;
  }

  update() async {
    // coinslist = await Api.coinsList();
    coins_vs_usdt_price = await Api.coinsPriceList();
    _markets = await Api.markets()['data'];
  }


  //Address
  //修改AddList的管理状态
  setAddressListIsManage()async{
    addressListIsManage=!addressListIsManage;
    reload();
  }
  //获取地址列表
  getAddressList()async{
    if(walletsProviderDefault.wallet().isEmpty){
      return;
    }
    _addressList=await WalletDatabaseProvider.dbProvider.getAllAddress();
    reload();
  }
  //删除地址
  deleteAddress(int index)async{
    AddressDb adb=addressList[index];
    if(adb.isDefault==1){
      return;
    }
    else{
      addressList_showLoading=true;
      reload();

      await WalletDatabaseProvider.dbProvider.deleteAddressWithId(adb.id);
      addressList.removeAt(index);

      addressList_showLoading=false;
      reload();
    }
  }
  //切换默认地址
  changeDefaultAddress(int index)async{

    AddressDb adb=addressList[index];
    if(adb.isDefault==1){
      return;
    }
    else{
      addressList_showLoading=true;
      notifyListeners();

      //修改默认钱包
      await WalletDatabaseProvider.dbProvider.updateAddress_isDefault_0();
      adb.isDefault=1;
      await WalletDatabaseProvider.dbProvider.updateAddress(AddressDb.coin(
          addressName: adb.addressName, isDefault: adb.isDefault,walletId: adb.walletId,coins: adb.coins),
          adb.id);
      await reloadWallet();

      addressList_showLoading=false;
      notifyListeners();

    }
  }

  //重新加载钱包
  reloadWallet()async{
    final defaultWallet = await WalletDatabaseProvider.dbProvider.getAllWallet();
    final address=await WalletDatabaseProvider.dbProvider.getAddressDefault();
    if (defaultWallet != null) {
      await walletsProviderDefault.init(defaultWallet, address);
    } else {
      print("无默认钱包");
    }
    await initCoinsProvider();
  }
  reload(){
    notifyListeners();
  }
}

class CoinModel{
  Map<String,dynamic> coin={};
  BigInt balance=BigInt.from(0);//余额
  double coinPrice=0;//币价
  double value=0;//价值 balance * coinPrice
  double percentage=0;//百分比
  BigInt lockupBalance = BigInt.from(0);//所仓数
  BigInt releaseBalance = BigInt.from(0);//释放数
  var owner;
  var address;
}