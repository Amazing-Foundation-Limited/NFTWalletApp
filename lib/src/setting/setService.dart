import 'package:flutter/material.dart';
import 'package:kingloryapp/main.dart';
import 'package:kingloryapp/src/http/http_cross_chain.dart';
import 'package:kingloryapp/src/http/network_api.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class SetService extends StatefulWidget{
  @override
  _SetServiceState createState()=>_SetServiceState();
}
class _SetServiceState extends State<SetService>{
  ServiceModel _serviceModel=ServiceModel();
  TextEditingController ethMainnerRpc=TextEditingController();
  TextEditingController ethTextnetRpc=TextEditingController();
  TextEditingController ethMainnetWs=TextEditingController();
  TextEditingController ethTextnetWs=TextEditingController();
  TextEditingController ethMainnetChainID=TextEditingController();
  TextEditingController ethTextnetChainID=TextEditingController();
  TextEditingController bnbMainnerRpc=TextEditingController();
  TextEditingController bnbTextnetRpc=TextEditingController();
  TextEditingController bnbMainnetWs=TextEditingController();
  TextEditingController bnbTextnetWs=TextEditingController();
  TextEditingController bnbMainnetChainID=TextEditingController();
  TextEditingController bnbTextnetChainID=TextEditingController();
  TextEditingController mtkMainnerRpc=TextEditingController();
  TextEditingController mtkTextnetRpc=TextEditingController();
  TextEditingController mtkMainnetWs=TextEditingController();
  TextEditingController mtkTextnetWs=TextEditingController();
  TextEditingController mtkMainnetChainID=TextEditingController();
  TextEditingController mtkTextnetChainID=TextEditingController();
  TextEditingController eth_eMainnerRpc=TextEditingController();
  TextEditingController eth_eTextnetRpc=TextEditingController();
  TextEditingController eth_eMainnetWs=TextEditingController();
  TextEditingController eth_eTextnetWs=TextEditingController();
  TextEditingController eth_eMainnetChainID=TextEditingController();
  TextEditingController eth_eTextnetChainID=TextEditingController();
  TextEditingController eth_eMainnetAddr=TextEditingController();
  TextEditingController eth_eTestnetAddr=TextEditingController();
  TextEditingController bnb_eMainnerRpc=TextEditingController();
  TextEditingController bnb_eTextnetRpc=TextEditingController();
  TextEditingController bnb_eMainnetWs=TextEditingController();
  TextEditingController bnb_eTextnetWs=TextEditingController();
  TextEditingController bnb_eMainnetChainID=TextEditingController();
  TextEditingController bnb_eTextnetChainID=TextEditingController();
  TextEditingController bnb_eMainnetAddr=TextEditingController();
  TextEditingController bnb_eTestnetAddr=TextEditingController();
  TextEditingController mtk_eMainnerRpc=TextEditingController();
  TextEditingController mtk_eTextnetRpc=TextEditingController();
  TextEditingController mtk_eMainnetWs=TextEditingController();
  TextEditingController mtk_eTextnetWs=TextEditingController();
  TextEditingController mtk_eMainnetChainID=TextEditingController();
  TextEditingController mtk_eTextnetChainID=TextEditingController();
  TextEditingController mtk_eMainnetAddr=TextEditingController();
  TextEditingController mtk_eTestnetAddr=TextEditingController();
  TextEditingController apiMain=TextEditingController();
  TextEditingController apiTest=TextEditingController();
  TextEditingController ethAddress=TextEditingController();
  TextEditingController mtkAddress=TextEditingController();
  TextEditingController bnbAddress=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }
  _initData() async{
    ServiceModel? sm=await WalletDatabaseProvider.dbProvider.getServiceConfig();
    if(sm!=null){
      _serviceModel=sm;
      ethMainnerRpc.text=_serviceModel.ethMainnerRpc;
      ethTextnetRpc.text=_serviceModel.ethTextnetRpc;
      ethMainnetWs.text=_serviceModel.ethMainnetWs;
      ethTextnetWs.text=_serviceModel.ethTextnetWs;
      ethMainnetChainID.text=_serviceModel.ethMainnetChainID.toString();
      ethTextnetChainID.text=_serviceModel.ethTextnetChainID.toString();
      bnbMainnerRpc.text=_serviceModel.bnbMainnerRpc;
      bnbTextnetRpc.text=_serviceModel.bnbTextnetRpc;
      bnbMainnetWs.text=_serviceModel.bnbMainnetWs;
      bnbTextnetWs.text=_serviceModel.bnbTextnetWs;
      bnbMainnetChainID.text=_serviceModel.bnbMainnetChainID.toString();
      bnbTextnetChainID.text=_serviceModel.bnbTextnetChainID.toString();
      mtkMainnerRpc.text=_serviceModel.mtkMainnerRpc;
      mtkTextnetRpc.text=_serviceModel.mtkTextnetRpc;
      mtkMainnetWs.text=_serviceModel.mtkMainnetWs;
      mtkTextnetWs.text=_serviceModel.mtkTextnetWs;
      mtkMainnetChainID.text=_serviceModel.mtkMainnetChainID.toString();
      mtkTextnetChainID.text=_serviceModel.mtkTextnetChainID.toString();
      eth_eMainnerRpc.text=_serviceModel.eth_eMainnerRpc;
      eth_eTextnetRpc.text=_serviceModel.eth_eTextnetRpc;
      eth_eMainnetWs.text=_serviceModel.eth_eMainnetWs;
      eth_eTextnetWs.text=_serviceModel.eth_eTextnetWs;
      eth_eMainnetChainID.text=_serviceModel.eth_eMainnetChainID.toString();
      eth_eTextnetChainID.text=_serviceModel.eth_eTextnetChainID.toString();
      eth_eMainnetAddr.text=_serviceModel.eth_eMainnetAddr;
      eth_eTestnetAddr.text=_serviceModel.eth_eTestnetAddr;
      bnb_eMainnerRpc.text=_serviceModel.bnb_eMainnerRpc;
      bnb_eTextnetRpc.text=_serviceModel.bnb_eTextnetRpc;
      bnb_eMainnetWs.text=_serviceModel.bnb_eMainnetWs;
      bnb_eTextnetWs.text=_serviceModel.bnb_eTextnetWs;
      bnb_eMainnetChainID.text=_serviceModel.bnb_eMainnetChainID.toString();
      bnb_eTextnetChainID.text=_serviceModel.bnb_eTextnetChainID.toString();
      bnb_eMainnetAddr.text=_serviceModel.bnb_eMainnetAddr;
      bnb_eTestnetAddr.text=_serviceModel.bnb_eTestnetAddr;
      mtk_eMainnerRpc.text=_serviceModel.mtk_eMainnerRpc;
      mtk_eTextnetRpc.text=_serviceModel.mtk_eTextnetRpc;
      mtk_eMainnetWs.text=_serviceModel.mtk_eMainnetWs;
      mtk_eTextnetWs.text=_serviceModel.mtk_eTextnetWs;
      mtk_eMainnetChainID.text=_serviceModel.mtk_eMainnetChainID.toString();
      mtk_eTextnetChainID.text=_serviceModel.mtk_eTextnetChainID.toString();
      mtk_eMainnetAddr.text=_serviceModel.mtk_eMainnetAddr;
      mtk_eTestnetAddr.text=_serviceModel.mtk_eTestnetAddr;
      apiMain.text=_serviceModel.apiMain;
      apiTest.text=_serviceModel.apiTest;
      mtkAddress.text=_serviceModel.mtkAddress;
      ethAddress.text=_serviceModel.ethAddress;
      bnbAddress.text=_serviceModel.bnbAddress;
    }
    else{
      ethMainnerRpc.text=ETHMainnetRpc;
      ethTextnetRpc.text=ETHRopstenRpc;
      ethMainnetWs.text=ETHMainnetWs;
      ethTextnetWs.text=ETHRopstenWs;
      ethMainnetChainID.text=ETHRinkebyChainID.toString();
      ethTextnetChainID.text=ETHRopstenChainID.toString();
      bnbMainnerRpc.text=BSCMainnetRpc;
      bnbTextnetRpc.text=BSCTestnetRpc;
      bnbMainnetWs.text=BSCMainnetWs;
      bnbTextnetWs.text=BSCTestnetWs;
      bnbMainnetChainID.text=BSCMainnetChainID.toString();
      bnbTextnetChainID.text=BSCTestnetChainID.toString();
      mtkMainnerRpc.text=MTKMainnetRpc;
      mtkTextnetRpc.text=MTKTestnetRpc;
      mtkMainnetWs.text=MTKMainnetWs;
      mtkTextnetWs.text=MTKTestnetWs;
      mtkMainnetChainID.text=MTKMainnetChainID.toString();
      mtkTextnetChainID.text=MTKTestnetChainID.toString();
      eth_eMainnerRpc.text=ETHMainnetRpc;
      eth_eTextnetRpc.text=MTKTestnetRpc;
      eth_eMainnetWs.text=ETHMainnetWs;
      eth_eTextnetWs.text=MTKTestnetWs;
      eth_eMainnetChainID.text=ETHRinkebyChainID.toString();
      eth_eTextnetChainID.text=MTKTestnetChainID.toString();
      eth_eMainnetAddr.text=BSCContractAddr;
      eth_eTestnetAddr.text=mETHTestnetAddr;
      bnb_eMainnerRpc.text=BSCMainnetRpc;
      bnb_eTextnetRpc.text=MTKTestnetRpc;
      bnb_eMainnetWs.text=BSCMainnetWs;
      bnb_eTextnetWs.text=BSCTestnetWs;
      bnb_eMainnetChainID.text=BSCMainnetChainID.toString();
      bnb_eTextnetChainID.text=MTKTestnetChainID.toString();
      bnb_eMainnetAddr.text=BSCContractAddr;
      bnb_eTestnetAddr.text=mBNBTestnetAddr;
      mtk_eMainnerRpc.text=BSCMainnetRpc;
      mtk_eTextnetRpc.text=ETHRopstenRpc;
      mtk_eMainnetWs.text=BSCMainnetWs;
      mtk_eTextnetWs.text=BSCTestnetWs;
      mtk_eMainnetChainID.text=BSCMainnetChainID.toString();
      mtk_eTextnetChainID.text=ETHRopstenChainID.toString();
      mtk_eMainnetAddr.text=BSCContractAddr;
      mtk_eTestnetAddr.text=mtkErc20TestnetAddr;
      apiMain.text=RequestCC.baseUrl;
      apiTest.text=RequestCC.baseUrl_test;
      mtkAddress.text=MTKAddress;
      ethAddress.text=ETHAddress;
      bnbAddress.text=BNBAddress;
    }
  }
  _save()async{
    _serviceModel.ethMainnerRpc=ethMainnerRpc.text;
    _serviceModel.ethTextnetRpc=ethTextnetRpc.text;
    _serviceModel.ethMainnetWs=ethMainnetWs.text;
    _serviceModel.ethTextnetWs=ethTextnetWs.text;
    _serviceModel.ethMainnetChainID=int.parse(ethMainnetChainID.text);
    _serviceModel.ethTextnetChainID=int.parse(ethTextnetChainID.text);
    _serviceModel.bnbMainnerRpc=bnbMainnerRpc.text;
    _serviceModel.bnbTextnetRpc=bnbTextnetRpc.text;
    _serviceModel.bnbMainnetWs=bnbMainnetWs.text;
    _serviceModel.bnbTextnetWs=bnbTextnetWs.text;
    _serviceModel.bnbMainnetChainID=int.parse(bnbMainnetChainID.text);
    _serviceModel.bnbTextnetChainID=int.parse(bnbTextnetChainID.text);
    _serviceModel.mtkMainnerRpc=mtkMainnerRpc.text;
    _serviceModel.mtkTextnetRpc=mtkTextnetRpc.text;
    _serviceModel.mtkMainnetWs=mtkMainnetWs.text;
    _serviceModel.mtkTextnetWs=mtkTextnetWs.text;
    _serviceModel.mtkMainnetChainID=int.parse(mtkMainnetChainID.text);
    _serviceModel.mtkTextnetChainID=int.parse(mtkTextnetChainID.text);
    _serviceModel.eth_eMainnerRpc=eth_eMainnerRpc.text;
    _serviceModel.eth_eTextnetRpc=eth_eTextnetRpc.text;
    _serviceModel.eth_eMainnetWs=eth_eMainnetWs.text;
    _serviceModel.eth_eTextnetWs=eth_eTextnetWs.text;
    _serviceModel.eth_eMainnetChainID=int.parse(eth_eMainnetChainID.text);
    _serviceModel.eth_eTextnetChainID=int.parse(eth_eTextnetChainID.text);
    _serviceModel.eth_eMainnetAddr=eth_eMainnetAddr.text;
    _serviceModel.eth_eTestnetAddr=eth_eTestnetAddr.text;
    _serviceModel.bnb_eMainnerRpc=bnb_eMainnerRpc.text;
    _serviceModel.bnb_eTextnetRpc=bnb_eTextnetRpc.text;
    _serviceModel.bnb_eMainnetWs=bnb_eMainnetWs.text;
    _serviceModel.bnb_eTextnetWs=bnb_eTextnetWs.text;
    _serviceModel.bnb_eMainnetChainID=int.parse(bnb_eMainnetChainID.text);
    _serviceModel.bnb_eTextnetChainID=int.parse(bnb_eTextnetChainID.text);
    _serviceModel.bnb_eMainnetAddr=bnb_eMainnetAddr.text;
    _serviceModel.bnb_eTestnetAddr=bnb_eTestnetAddr.text;
    _serviceModel.mtk_eMainnerRpc=mtk_eMainnerRpc.text;
    _serviceModel.mtk_eTextnetRpc=mtk_eTextnetRpc.text;
    _serviceModel.mtk_eMainnetWs=mtk_eMainnetWs.text;
    _serviceModel.mtk_eTextnetWs=mtk_eTextnetWs.text;
    _serviceModel.mtk_eMainnetChainID=int.parse(mtk_eMainnetChainID.text);
    _serviceModel.mtk_eTextnetChainID=int.parse(mtk_eTextnetChainID.text);
    _serviceModel.mtk_eMainnetAddr=mtk_eMainnetAddr.text;
    _serviceModel.mtk_eTestnetAddr=mtk_eTestnetAddr.text;
    _serviceModel.apiMain=apiMain.text;
    _serviceModel.apiTest=apiTest.text;
    _serviceModel.ethAddress=ethAddress.text;
    _serviceModel.mtkAddress=mtkAddress.text;
    _serviceModel.bnbAddress=bnbAddress.text;
    Api.sendTest({"name":"footbar"});
    return;
    ServiceModel? sm=await WalletDatabaseProvider.dbProvider.getServiceConfig();
    if(sm==null){
      //添加记录
      await WalletDatabaseProvider.dbProvider.insertServiceConfig(_serviceModel);
    }else{
      //修改记录
      await WalletDatabaseProvider.dbProvider.updateServiceConfig(_serviceModel);
    }

    final defaultWallet = await WalletDatabaseProvider.dbProvider.getAllWallet();
    if(defaultWallet!=null){
      defaultWallet.coins=GetCoins((defaultWallet.id-1));
      final address=await WalletDatabaseProvider.dbProvider.getAddressDefault();
      address!.coins=GetCoins((defaultWallet.id-1));
      await WalletDatabaseProvider.dbProvider.updateAddress(address, address.id);
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyApp()), (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('设置服务地址'),
        actions: [
          TextButton(
            onPressed: (){
              _save();
            },
            child: Text("保存"),),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(32.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ETH', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),

              Text('MainnerRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: ethMainnerRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnerRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller:ethTextnetRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: ethMainnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: ethTextnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: ethMainnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: ethTextnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('BNB', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),

              Text('MainnerRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnbMainnerRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnerRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnbTextnetRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnbMainnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnbTextnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnbMainnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnbTextnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MTK', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),

              Text('MainnerRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtkMainnerRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnerRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtkTextnetRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtkMainnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtkTextnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtkMainnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtkTextnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('ETH_E', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),

              Text('MainnerRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: eth_eMainnerRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnerRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: eth_eTextnetRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: eth_eMainnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: eth_eTextnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: eth_eMainnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: eth_eTextnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetAddr', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: eth_eMainnetAddr,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetAddr",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetAddr', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: eth_eTestnetAddr,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetAddr",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('BNB_E', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),

              Text('MainnerRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnb_eMainnerRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnerRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnb_eTextnetRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnb_eMainnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnb_eTextnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnb_eMainnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnb_eTextnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetAddr', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnb_eMainnetAddr,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetAddr",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetAddr', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnb_eTestnetAddr,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetAddr",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MTK_E', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),

              Text('MainnerRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtk_eMainnerRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnerRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetRpc', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtk_eTextnetRpc,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetRpc",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtk_eMainnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetWs', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtk_eTextnetWs,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetWs",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtk_eMainnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetChainID', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtk_eTextnetChainID,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetChainID",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MainnetAddr', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtk_eMainnetAddr,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MainnetAddr",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('TestnetAddr', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtk_eTestnetAddr,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "TestnetAddr",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('Api', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),

              Text('Main', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: apiMain,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "Main",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('Test', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: apiTest,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "Test",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('ToAddress', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),

              Text('ETH', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: ethAddress,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "ETHAddress",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('MTK', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: mtkAddress,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "MTKAddress",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),

              Text('BNB', style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  color: Theme.of(context).textTheme.headline2!.color
              ),),
              SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
              TextFormField(
                controller: bnbAddress,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                // restorationId: 'salary_field',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  //labelText: S.of(context).g_key_39,
                  hintText: "BNBAddress",
                ),
                maxLines: 1,
              ),
              SizedBox(height: ScreenUtil.getInstance().setWidth(40)),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceModel{
  String ethMainnerRpc="";
  String ethTextnetRpc="";
  String ethMainnetWs="";
  String ethTextnetWs="";
  int ethMainnetChainID=0;
  int ethTextnetChainID=0;
  String bnbMainnerRpc="";
  String bnbTextnetRpc="";
  String bnbMainnetWs="";
  String bnbTextnetWs="";
  int bnbMainnetChainID=0;
  int bnbTextnetChainID=0;
  String mtkMainnerRpc="";
  String mtkTextnetRpc="";
  String mtkMainnetWs="";
  String mtkTextnetWs="";
  int mtkMainnetChainID=0;
  int mtkTextnetChainID=0;
  String eth_eMainnerRpc="";
  String eth_eTextnetRpc="";
  String eth_eMainnetWs="";
  String eth_eTextnetWs="";
  int eth_eMainnetChainID=0;
  int eth_eTextnetChainID=0;
  String eth_eMainnetAddr="";
  String eth_eTestnetAddr="";
  String bnb_eMainnerRpc="";
  String bnb_eTextnetRpc="";
  String bnb_eMainnetWs="";
  String bnb_eTextnetWs="";
  int bnb_eMainnetChainID=0;
  int bnb_eTextnetChainID=0;
  String bnb_eMainnetAddr="";
  String bnb_eTestnetAddr="";
  String mtk_eMainnerRpc="";
  String mtk_eTextnetRpc="";
  String mtk_eMainnetWs="";
  String mtk_eTextnetWs="";
  int mtk_eMainnetChainID=0;
  int mtk_eTextnetChainID=0;
  String mtk_eMainnetAddr="";
  String mtk_eTestnetAddr="";
  String apiMain="";
  String apiTest="";
  String ethAddress="";
  String mtkAddress="";
  String bnbAddress="";

  ServiceModel();
  Map<String,dynamic> getMap(){
    Map<String,dynamic> r={
    "ethMainnerRpc": ethMainnerRpc,
    "ethTextnetRpc": ethTextnetRpc,
    "ethMainnetWs": ethMainnetWs,
    "ethTextnetWs": ethTextnetWs,
    "ethMainnetChainID": ethMainnetChainID,
    "ethTextnetChainID": ethTextnetChainID,
    "bnbMainnerRpc": bnbMainnerRpc,
    "bnbTextnetRpc": bnbTextnetRpc,
    "bnbMainnetWs": bnbMainnetWs,
    "bnbTextnetWs": bnbTextnetWs,
    "bnbMainnetChainID": bnbMainnetChainID,
    "bnbTextnetChainID": bnbTextnetChainID,
    "mtkMainnerRpc": mtkMainnerRpc,
    "mtkTextnetRpc": mtkTextnetRpc,
    "mtkMainnetWs": mtkMainnetWs,
    "mtkTextnetWs": mtkTextnetWs,
    "mtkMainnetChainID": mtkMainnetChainID,
    "mtkTextnetChainID": mtkTextnetChainID,
    "eth_eMainnerRpc": eth_eMainnerRpc,
    "eth_eTextnetRpc": eth_eTextnetRpc,
    "eth_eMainnetWs": eth_eMainnetWs,
    "eth_eTextnetWs": eth_eTextnetWs,
    "eth_eMainnetChainID": eth_eMainnetChainID,
    "eth_eTextnetChainID": eth_eTextnetChainID,
    "eth_eMainnetAddr": eth_eMainnetAddr,
    "eth_eTestnetAddr": eth_eTestnetAddr,
    "bnb_eMainnerRpc": bnb_eMainnerRpc,
    "bnb_eTextnetRpc": bnb_eTextnetRpc,
    "bnb_eMainnetWs": bnb_eMainnetWs,
    "bnb_eTextnetWs": bnb_eTextnetWs,
    "bnb_eMainnetChainID": bnb_eMainnetChainID,
    "bnb_eTextnetChainID": bnb_eTextnetChainID,
    "bnb_eMainnetAddr": bnb_eMainnetAddr,
    "bnb_eTestnetAddr": bnb_eTestnetAddr,
    "mtk_eMainnerRpc": mtk_eMainnerRpc,
    "mtk_eTextnetRpc": mtk_eTextnetRpc,
    "mtk_eMainnetWs": mtk_eMainnetWs,
    "mtk_eTextnetWs": mtk_eTextnetWs,
    "mtk_eMainnetChainID": mtk_eMainnetChainID,
    "mtk_eTextnetChainID": mtk_eTextnetChainID,
    "mtk_eMainnetAddr": mtk_eMainnetAddr,
    "mtk_eTestnetAddr": mtk_eTestnetAddr,
    "apiMain": apiMain,
    "apiTest": apiTest,
      "ethAddress":ethAddress,
      "mtkAddress":mtkAddress,
      "bnbAddress":bnbAddress
    };
    return r;
  }
  ServiceModel.fromMap(Map<String,dynamic> map){
    ethMainnerRpc=map["ethMainnerRpc"];
    ethTextnetRpc=map["ethTextnetRpc"];
    ethMainnetWs=map["ethMainnetWs"];
    ethTextnetWs=map["ethTextnetWs"];
    ethMainnetChainID=map["ethMainnetChainID"];
    ethTextnetChainID=map["ethTextnetChainID"];
    bnbMainnerRpc=map["bnbMainnerRpc"];
    bnbTextnetRpc=map["bnbTextnetRpc"];
    bnbMainnetWs=map["bnbMainnetWs"];
    bnbTextnetWs=map["bnbTextnetWs"];
    bnbMainnetChainID=map["bnbMainnetChainID"];
    bnbTextnetChainID=map["bnbTextnetChainID"];
    mtkMainnerRpc=map["mtkMainnerRpc"];
    mtkTextnetRpc=map["mtkTextnetRpc"];
    mtkMainnetWs=map["mtkMainnetWs"];
    mtkTextnetWs=map["mtkTextnetWs"];
    mtkMainnetChainID=map["mtkMainnetChainID"];
    mtkTextnetChainID=map["mtkTextnetChainID"];
    eth_eMainnerRpc=map["eth_eMainnerRpc"];
    eth_eTextnetRpc=map["eth_eTextnetRpc"];
    eth_eMainnetWs=map["eth_eMainnetWs"];
    eth_eTextnetWs=map["eth_eTextnetWs"];
    eth_eMainnetChainID=map["eth_eMainnetChainID"];
    eth_eTextnetChainID=map["eth_eTextnetChainID"];
    eth_eMainnetAddr=map["eth_eMainnetAddr"];
    eth_eTestnetAddr=map["eth_eTestnetAddr"];
    bnb_eMainnerRpc=map["bnb_eMainnerRpc"];
    bnb_eTextnetRpc=map["bnb_eTextnetRpc"];
    bnb_eMainnetWs=map["bnb_eMainnetWs"];
    bnb_eTextnetWs=map["bnb_eTextnetWs"];
    bnb_eMainnetChainID=map["bnb_eMainnetChainID"];
    bnb_eTextnetChainID=map["bnb_eTextnetChainID"];
    bnb_eMainnetAddr=map["bnb_eMainnetAddr"];
    bnb_eTestnetAddr=map["bnb_eTestnetAddr"];
    mtk_eMainnerRpc=map["mtk_eMainnerRpc"];
    mtk_eTextnetRpc=map["mtk_eTextnetRpc"];
    mtk_eMainnetWs=map["mtk_eMainnetWs"];
    mtk_eTextnetWs=map["mtk_eTextnetWs"];
    mtk_eMainnetChainID=map["mtk_eMainnetChainID"];
    mtk_eTextnetChainID=map["mtk_eTextnetChainID"];
    mtk_eMainnetAddr=map["mtk_eMainnetAddr"];
    mtk_eTestnetAddr=map["mtk_eTestnetAddr"];
    apiMain=map["apiMain"];
    apiTest=map["apiTest"];
    ethAddress=map["ethAddress"];
    bnbAddress=map["bnbAddress"];
    mtkAddress=map["mtkAddress"];
  }
}