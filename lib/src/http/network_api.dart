import 'package:kingloryapp/src/http/http_bsc.dart';
import 'package:kingloryapp/src/http/http_util.dart';
import 'package:kingloryapp/src/http/http_mtk.dart';
import 'package:kingloryapp/src/http/http_eth.dart';
import 'package:kingloryapp/src/http/http_cross_chain.dart';
import 'package:dio/dio.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';

class Api {
  static markets() async{
    try{
      var data=await Request.get('/global', params: {});
      return {"error":false,"data":data};
    }catch(e){
      return {"error":true,"data":e};
    }
  }

  static coinsPriceList({int per_page=100,int page=1}) async{
    try{
      var data=await Request.get(
          '/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$per_page&page=$page&sparkline=false',
          params: {});
      return {"error":false,"data":data};
    }catch(e){
      return {"error":true,"data":e};
    }
  }

  static accountList(String address,
      {int? fromBlock = 0, int? endBlock = 999999999}) async{
    try{
      var data= await RequestBSC.get(
          'module=account&action=txlist&address=$address&startblock=$fromBlock&endblock=$endBlock&sort=desc',
          params: {});
      return {"error":false,"data":data};
    }catch(e){
      return {"error":true,"data":e};
    }

  }

  static internalTxList(String address, {int? fromBlock = 0, int? endBlock = 99999999999}) async{
    // https://api.bscscan.com/api?module=account&action=txlistinternal&address=0x0000000000000000000000000000000000001004&startblock=0&endblock=2702578&sort=asc&apikey=YourApiKeyToken
    //https://api.bscscan.com/api?module=account&action=tokentx&address=0x7bb89460599dbf32ee3aa50798bbceae2a5f7f6a&startblock=0&endblock=2500000&sort=asc&apikey=YourApiKeyToken

    try{
      var data= await RequestBSC.get('module=account&action=tokentx&address=$address&startblock=$fromBlock&endblock=$endBlock&sort=desc', params: {});
      return {"error":false,"data":data};
    }catch(e){
      return {"error":true,"data":e};
    }
    //RequestBSC.get('module=account&action=tokentx&address=$address&startblock=$fromBlock&endblock=$endBlock&sort=desc', params: {});
  }


  static accountListFromEth(String address,
      {int? fromBlock = 0, int? endBlock = 99999999999, int? page = 1, int? offset = 10000}) async{
    try{
      var data= await RequestETH.get(
          'module=account&action=txlist&address=$address&startblock=$fromBlock&endblock=$endBlock&page=$page&offset=$offset&sort=desc',
          params: {});
      return {"error":false,"data":data};
    }catch(e){
      return {"error":true,"data":e};
    }
    //return RequestETH.get('module=account&action=txlist&address=$address&startblock=$fromBlock&endblock=$endBlock&page=$page&offset=$offset&sort=desc',params: {});
  }

  static internalTxListFromEth(String address, {int? page = 1, int? offset = 10000,int? fromBlock = 0, int? endBlock = 99999999999}) async{
    // https://api.bscscan.com/api?module=account&action=txlistinternal&address=0x0000000000000000000000000000000000001004&startblock=0&endblock=2702578&sort=asc&apikey=YourApiKeyToken
    //https://api.bscscan.com/api?module=account&action=tokentx&address=0x7bb89460599dbf32ee3aa50798bbceae2a5f7f6a&startblock=0&endblock=2500000&sort=asc&apikey=YourApiKeyToken
    try{
      var data= await RequestETH.get('module=account&action=tokentx&address=$address&startblock=$fromBlock&endblock=$endBlock&sort=desc', params: {});
      return {"error":false,"data":data};
    }catch(e){
      return {"error":true,"data":e};
    }
    //return RequestETH.get('module=account&action=tokentx&address=$address&startblock=$fromBlock&endblock=$endBlock&sort=desc', params: {});
  }


  ///mtk
  //查询交易列表
  static transactionListFromMtk(String address,{int? page = 1, int? offset = 10000,int? fromBlock = 0, int? endBlock = 99999999999})async{
    try{
      //module= account &action= txlist &address={ addressHash }
      var data=await RequestMTK.get('module=account&action=txlist&address=${address}&startblock=$fromBlock&endblock=$endBlock&page=$page&offset=$offset&sort=desc', params: {});
      return {"error":false,"data":data};
    }
    catch(e){
      return {"error":true,"data":e};
    }
  }
  //获取合约交易记录，mtk的合约币
  static transactionListFromMtk_contract(String address,{int? page = 1, int? offset = 10000,int? fromBlock = 0, int? endBlock = 99999999999})async{
    try{
      //module= account &action= txlist &address={ addressHash }
      var data=await RequestMTK.get('module=account&action=tokentx&address=${address}&startblock=$fromBlock&endblock=$endBlock&page=$page&offset=$offset&sort=desc', params: {});
      return {"error":false,"data":data};
    }
    catch(e){
      return {"error":true,"data":e};
    }
  }




  //跨链转账
  //外向内转
  static sendTransaction_in(Map<String,dynamic> value,CoinType type)async{
    try{
      String path;
      if(type==CoinType.MTK){
        path='/v1/mtkToBsc';
      }else if(type==CoinType.ETH){
        path='/v1/chainOut2Inside';
      }else{
        path='/v1/bscToMtk';
      }

      var data=await RequestCC.post(path,params:{},data: value);
      return {"error":false,"data":data};
    }
    catch(e){
      return {"error":true,"data":e};
    }
  }
  //内向外转
  static sendTransaction_out(Map<String,dynamic> value,CoinType type)async{
    try{
      String path;
      if(type==CoinType.MTK){
        path='/v1/bscToMtk';
      }else if(type==CoinType.ETH){
        path='/v1/chainInside2Out';
      }else{
        path='/v1/mtkToBsc';
      }
      var data=await RequestCC.post(path, params:{},data: value);
      return {"error":false,"data":data};
    }
    catch(e){
      return {"error":true,"data":e};
    }
  }

  //test
  static sendTest(Map<String,dynamic> value)async{
    try{
      String path="/v1/testSign";
      var data=await RequestCC.post(path, params:{},data: value);
      return {"error":false,"data":data};
    }
    catch(e){
      return {"error":true,"data":e};
    }
  }


  static reSetBaseUrl(bool isTest){
    RequestETH.reSetDio(isTest);
    RequestBSC.reSetDio(isTest);
    RequestMTK.reSetDio(isTest);
    RequestCC.reSetDio(isTest);
  }
  // static coinsList() {
  //   return Request.get('/coins/list', params: {"include_platform": false});
  // }
}
