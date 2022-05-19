
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/http/network_api.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:kingloryapp/util/toast_utils.dart';
import 'package:web3dart/web3dart.dart';

class CCTransactionProvider with ChangeNotifier, DiagnosticableTreeMixin{
  TransactionData1? _transactionData1= new TransactionData1();
  TransactionData1? get transactionData1=>_transactionData1;
  bool _isKGC=false;
  bool get isKGC=>_isKGC;
  //String ercAddress_out="0x48ba0c65289f697407de6f66d0b866c091213281";//erc外转内链erc地址
  //String ercAddress_in="0x3732f33cc0ee7371141637555770c9b8ce62f812";//内转外erc地址
  //String bnbAddress_out="0x21e93a64fee6fe8b46a6c229286a5ff184879211";//bnb外转内链mtk地址
  bool _showLoading=false;//是否正在操作
  bool get showLoading=>_showLoading;
  late WalletsProviderDefault walletsProviderDefault;
  double _usableBalance=0;
  double get usableBalance=>_usableBalance;

  setTransactionData_coin(Map<String,dynamic> coin)async{
    if(transactionData1==null)return;
    _transactionData1?.coin=coin;
    List<String> keyList=coin.keys.toList();
    _transactionData1?.coinName=keyList[0];
    if(_transactionData1?.coin[_transactionData1?.coinName]['contract']==""){
      EthProvider? coinPro = walletsProviderDefault.coinByName(_transactionData1!.coinName);
      final balance=await coinPro!.balance();
      _usableBalance=toEther(EtherAmount.inWei(balance).getInWei.toString());
    }else{
      KGCProvider? coinPro = walletsProviderDefault.coinByName_kgc(_transactionData1!.coinName);
      final balance=await coinPro!.getBalance();
      _usableBalance=toEther(EtherAmount.inWei(balance).getInWei.toString());
    }

    notifyListeners();
  }
  setTransactionData_coinName(String coinName){
    if(transactionData1==null)return;
    _transactionData1?.coinName=coinName;
  }
  setTransactionData_from(String from){
    if(transactionData1==null)return;
    _transactionData1?.from=from;
  }
  setTransactionData_toCoin(Map<String,dynamic> coin){
    if(transactionData1==null)return;
    _transactionData1?.to_coinName=coin.keys.toList()[0];
    _transactionData1?.to_coin=coin;
  }
  setTransactionData_to(String to){
    if(transactionData1==null)return;
    _transactionData1?.to=to;
  }
  setTransactionData_value(double value){
    if(transactionData1==null)return;
    _transactionData1?.value=value;
  }
  setTransactionData_receive(String receive){
    if(transactionData1==null)return;
    _transactionData1?.receive=receive;
  }
  setTransactionData_returnHash(String returnHash){
    if(transactionData1==null)return;
    _transactionData1?.returnHash=returnHash;
  }
  setTransactionData_state(String state){
    if(transactionData1==null)return;
    _transactionData1?.state=state;
  }

  sendTransaction_public(context)async{
    _showLoading=true;
    notifyListeners();

    try{
      //if(_transactionData1!.coin[_transactionData1?.coinName]['contract']!='' || _transactionData1!.coin[_transactionData1?.coinName]['name_k']=="MTK"){
      if(_transactionData1!.coin[_transactionData1?.coinName]['contract']!=''){
        //内向外转
        if(_transactionData1!.coin[_transactionData1?.coinName]['name_k']=="MTK_E"){
          _transactionData1!.to=ETHAddress;
        }else{
          _transactionData1!.to=MTKAddress;
        }

        sendTransaction_out(context);
      }else{
        //外向内转
        if(_transactionData1!.coin[_transactionData1?.coinName]['name_k']=="MTK"){
          _transactionData1!.to=MTKAddress;
        }else{
          if(_transactionData1!.coin[_transactionData1!.coinName]['name']=="BNB"){
            _transactionData1!.to=BNBAddress;
          }else{
            _transactionData1!.to=ETHAddress;
          }
        }
        sendTransaction_in(context);
      }
    }catch(e){
      _showLoading=false;
      notifyListeners();
      ToastUtils.show(e.toString());
    }

  }



  //kgc => other coins
  ///向kgc数据中心 默认地址提交交易请求
  //发送交易请求，内向外传
  sendTransaction_out(context) async {
    BigInt value;
    if(_transactionData1!.coin[_transactionData1?.coinName]['contract']==''){
      EthProvider? coinPro = walletsProviderDefault.coinByName(_transactionData1!.coinName);
      try{
        value= ethToWeiString(_transactionData1!.value.toString());
        Map<String,dynamic> r = await coinPro!.sendTransaction_1(_transactionData1!.to, value);
        if(r['error']){
          ToastUtils.show(r['data']);
          _showLoading=false;
          notifyListeners();
          return;
        }else{
          _transactionData1?.returnHash=r['data'];
          _transactionData1?.time=(DateTime.now().millisecondsSinceEpoch~/1000).toString();
          await WalletDatabaseProvider.dbProvider.addCrossChainTransaction(_transactionData1!);
          sendTranslation_out();
          _showLoading=false;
          notifyListeners();
          Navigator.pop(context);
        }
      }catch(e){
        ToastUtils.show(e.toString());
        _showLoading=false;
        notifyListeners();
      }
    }else{
      KGCProvider? coinPro = walletsProviderDefault.coinByName_kgc(_transactionData1!.coinName);
      value= ethToWeiString(_transactionData1!.value.toString());
      //BigInt gas=BigInt.parse('100');
      try{

        Map<String,dynamic> r = await coinPro!.sendTransfer(
            EthereumAddress.fromHex(_transactionData1!.to),
            value,
            credentials: coinPro.private,
        );
        if(r['error']){
          ToastUtils.show(r['data']);
          _showLoading=false;
          notifyListeners();
          return;
        }else{
          _transactionData1?.returnHash=r['data'];
          _transactionData1?.time=(DateTime.now().millisecondsSinceEpoch~/1000).toString();
          await WalletDatabaseProvider.dbProvider.addCrossChainTransaction(_transactionData1!);
          sendTranslation_out();
          _showLoading=false;
          notifyListeners();
          Navigator.pop(context);
        }

      }catch(e){
        ToastUtils.show(e.toString());
        _showLoading=false;
        notifyListeners();
      }
    }
  }

  ///向数据中心请求交易
  sendTranslation_out(){
    _showLoading=true;
    notifyListeners();
    // coins币种，from地址，to地址，value交易金额，receive接收地址，returnHash
    Map<String,dynamic> data={
      'coin':transactionData1!.coin[transactionData1!.coinName]['name_m'],
      'tx_hash':transactionData1!.returnHash,
      'user_to_addr':transactionData1!.receive,
    };
    CoinType ct;
    if(transactionData1!.coin[transactionData1!.coinName]['name']=="BNB"){
      ct=CoinType.BNB;
    }else if(transactionData1!.coin[transactionData1!.coinName]['name']=="BNB"){
      ct=CoinType.ETH;
    }else{
      ct=CoinType.MTK;
    }
    /*if(transactionData1!.to_coin[transactionData1!.to_coinName]['name']=="BNB"){
      ct=CoinType.BNB;
    }else{
      ct=CoinType.ETH;
    }*/
    selectTranslationInfo_out(data,ct);
    //selectTranslationInfo();
    _showLoading=false;
    notifyListeners();
  }
  //内向外转 提交、查询交易结果
  selectTranslationInfo_out(data,CoinType type)async{
    Map<String,dynamic> res= await Api.sendTransaction_out(data,type);
    print(res);
    if(res['error']){
      ToastUtils.show(res['data']);
    }else{
      if(res['data']['err']==''){
        _transactionData1!.state=res['data']['data']['status'].toString();
        await WalletDatabaseProvider.dbProvider.updateCrossChainTransaction(_transactionData1!.state, _transactionData1!.returnHash);
        if(_transactionData1!.state=='done'){
          ToastUtils.show(S.current.g_key_140);
        }else{
          /*Timer(Duration(seconds: 10),(){
            selectTranslationInfo_out(data,type);
          });*/
        }
      }else{
        ToastUtils.show(res['data']['err']);
      }
    }
  }

  //发送交易请求，外向内转
  sendTransaction_in(context) async {
    EthProvider? coinPro = walletsProviderDefault.coinByName(_transactionData1!.coinName);
    BigInt value = ethToWeiString(_transactionData1!.value.toString());
    //BigInt gas=BigInt.parse('100');
    try{
      Map<String,dynamic> r = await coinPro!.sendTransaction_1(_transactionData1!.to, value);
      if(r['error']){
        ToastUtils.show(r['data']);
        _showLoading=false;
        notifyListeners();
        return;
      }else{
        _transactionData1?.returnHash=r['data'];
        _transactionData1?.time=(DateTime.now().millisecondsSinceEpoch~/1000).toString();
        await WalletDatabaseProvider.dbProvider.addCrossChainTransaction(_transactionData1!);
        sendTranslation_in();
        _showLoading=false;
        notifyListeners();
        Navigator.pop(context);
      }
    }catch(e){
      print(e.toString());
      ToastUtils.show(e.toString());
      _showLoading=false;
      notifyListeners();
    }

  }

  ///向数据中心请求交易
  sendTranslation_in()async{
    _showLoading=true;
    notifyListeners();
    // coins币种，from地址，to地址，value交易金额，receive接收地址，returnHash
    Map<String,dynamic> data={
      'coin':transactionData1!.coin[transactionData1!.coinName]['name_m'],
      'tx_hash':transactionData1!.returnHash,
      'user_to_addr':transactionData1!.receive,
    };
    CoinType ct;
    if(transactionData1!.coin[transactionData1!.coinName]['name']=="BNB"){
      ct=CoinType.BNB;
    }else  if(transactionData1!.coin[transactionData1!.coinName]['name']=="ETH"){
      ct=CoinType.ETH;
    }else{
      ct=CoinType.MTK;
    }
    await selectTranslationInfo_in(data,ct);
    ToastUtils.show(S.current.g_key_141);
    //selectTranslationInfo();
    _showLoading=false;
    notifyListeners();
  }
  //外向内转 提交、查询交易结果

  selectTranslationInfo_in(data,CoinType type)async{
    Map<String,dynamic> res= await Api.sendTransaction_in(data,type);
    print(res);
    if(res['error']){
      ToastUtils.show(res['data']);
    }else{
      if(res['data']['err']==""){
        _transactionData1!.state=res['data']['data']['status'].toString();
        await WalletDatabaseProvider.dbProvider.updateCrossChainTransaction(_transactionData1!.state, _transactionData1!.returnHash);
        if(_transactionData1!.state=='done'){
          ToastUtils.show(S.current.g_key_140);
        }else{
          /*Timer(Duration(seconds: 10),(){
            selectTranslationInfo_in(data,type);
          });*/
        }
      }else{
        ToastUtils.show(res['data']['err']);
      }
    }
  }

  //获取未完成的数据
  getNotDoneValue()async{
    //await WalletDatabaseProvider.dbProvider.updateCrossChainTransaction_all('done');
    List<TransactionData1> notPendding=await WalletDatabaseProvider.dbProvider.getCrossChainTransactionByState('done');
    for(TransactionData1 td1 in notPendding){
      Map<String,dynamic> data={
        'coin':td1.coin[td1.coinName]['name_m'],
        'tx_hash':td1.returnHash,
        'user_to_addr':td1.receive,
      };
      Map<String,dynamic> res;
      CoinType ct;
      //if(td1.coin[td1.coinName]['contract']!='' || td1.coin[td1.coinName]['name_k']=="MTK"){
      if(td1.coin[td1.coinName]['contract']!=''){
        //内向外转
        if(td1.coin[td1.coinName]['name']=="BNB"){
          ct=CoinType.BNB;
        }else if(td1.coin[td1.coinName]['name']=="ETH"){
          ct=CoinType.ETH;
        }else{
          ct=CoinType.MTK;
        }
        res= await Api.sendTransaction_out(data,ct);
      }else{
        //外向内转
        if(td1.coin[td1.coinName]['name']=="BNB"){
          ct=CoinType.BNB;
        }else if(td1.coin[td1.coinName]['name']=="ETH"){
          ct=CoinType.ETH;
        }else{
          ct=CoinType.MTK;
        }
        res= await Api.sendTransaction_in(data,ct);
      }
      print(res);
      if(res['data']['err']==""){
        if(td1.state==res['data']['data']['status'].toString()){
          continue;
        }else{
          td1.state=res['data']['data']['status'].toString();
          await WalletDatabaseProvider.dbProvider.updateCrossChainTransaction(td1.state, td1.returnHash);
        }
      }
    }
  }

  resetData(){
    _transactionData1=TransactionData1();
  }
}
class TransactionData1{
  late Map<String,dynamic> coin={};
  late String coinName="";//币种
  late String from="";//付款地址
  late String to="";//收款地址
  late String to_coinName="";//内向外转，币种名
  late Map<String,dynamic> to_coin={};
  late double value=0;//金额
  late String receive="";//接收地址，默认和from一样，可由用户修改
  late String returnHash="";//提交交易请求成功后返回的hash
  late String state="";//交易状态
  late String time="";//交易发起时间
  TransactionData1();
  TransactionData1.fromMap(Map<String,dynamic> map){
    coin=json.decode(map['coin']);
    coinName=map['coinName'];
    from=map['from1'];
    to=map['to1'];
    to_coinName=map['to_coinName'];
    to_coin=json.decode(map['to_coin']);
    value=map['value'];
    receive=map['receive'];
    returnHash=map['returnHash'];
    state=map['state'];
    time=map['time'];
  }
  TransactionData1.init_FromJson(json){
    coin=json['coin'];
    coinName=json['coinName'];
    from=json['from1'];
    to=json['to1'];
    to_coinName=json['to_coinName'];
    to_coin=json['to_coin'];
    value=json['value']==null?0:double.parse(json['value']);
    receive=json['receive'];
    returnHash=json['returnHash'];
    state=json['state'];
  }
  //转为数据库需要的map
  Map<String,dynamic>toMap_db(){
    return {
      'coin':json.encode(coin).toString(),
      'coinName':coinName,
      'from1':from,
      'to1':to,
      'to_coinName':to_coinName,
      'to_coin':json.encode(to_coin).toString(),
      'value':value,
      'receive':receive,
      'returnHash':returnHash,
      'state':state,
      'time':time
    };
  }
}