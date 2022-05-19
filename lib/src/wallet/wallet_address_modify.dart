import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/src/wallet/wallet_address_modify_select_coins.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WalletAddressModify extends StatefulWidget{
  late AddressDb? addressDb;
  late int index;//列表index值
  late bool isAdd;
  WalletAddressModify({this.addressDb=null,this.isAdd=true,this.index=0});
  @override
  _WalletAddressModifyState createState()=>_WalletAddressModifyState();
}
class _WalletAddressModifyState extends State<WalletAddressModify>{
  final _formKey = GlobalKey<FormState>();
  late AddressDb _addressDb;
  String coinsStr="";
  TextEditingController addressNameTextEditingController=TextEditingController();
  TextEditingController coinsTextEditingController=TextEditingController();
  bool showLoading=false;//是否正在操作
  bool isInit=true;//是否正在加载
  @override
  void initState() {
    // TODO: implement initState

    initData();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressNameTextEditingController.dispose();
    coinsTextEditingController.dispose();
  }
  initData()async{
    if(widget.isAdd){
      Map<String,dynamic>wallet=Provider.of<WalletsProviderDefault>(context,listen:false).wallet();
      int walletId=wallet['id'];
      //获取地址表的数据行数，加1后作为 coin的地址最后一位
      int pathId=await WalletDatabaseProvider.dbProvider.getAddress_DataRows();
      Map<String,dynamic>coins=GetCoins(pathId);
      _addressDb=AddressDb.coin(addressName: "address",isDefault: 0,walletId: walletId,coins: coins);
    }else{
      //Map<String,dynamic>coins=GetCoins(widget.addressDb!.id);
      _addressDb=AddressDb.coin(
          addressName: widget.addressDb!.addressName,
          isDefault: widget.addressDb!.isDefault,
          walletId: widget.addressDb!.walletId,
          coins: widget.addressDb!.coins);

      _addressDb.id=widget.addressDb!.id;
      _addressDb.state=widget.addressDb!.state;
    }
    addressNameTextEditingController.text=_addressDb.addressName;
    _setCoinsText();
    setState(() {
      isInit=false;
    });
  }
  _setCoinsText(){
    coinsStr="";
    List<String> keyList=_addressDb.coins.keys.toList();
    for(int i=0;i<keyList.length;i++){
      Map<String,dynamic> coin=_addressDb.coins[keyList[i]];
      //if(coin['isSelect']){
        coinsStr+=keyList[i]+',';
      //}
    }
    coinsTextEditingController.text=coinsStr;
    //setState(() {});
  }
  _selectCoins()async{
    int pathId=0;
    if(widget.isAdd){
      pathId=await WalletDatabaseProvider.dbProvider.getAddress_DataRows();
    }
    showDialog(
      context: context,
      builder: (context){
        //List<String> keyList=_addressDb.coins.keys.toList();
        //Map<String,dynamic> addressDb=_addressDb.coins;

        return Center(
          child:WalletAddressModifySelectCoins(_addressDb,(isOk,Map<String,dynamic>? adb){
            if(isOk){
              setState(() {
                _addressDb.coins=adb!;
                _setCoinsText();
              });
            }
            Navigator.pop(context,'');
          },
            pathId: pathId,
          ),
        );

      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.addressDb==null?S.of(context).g_key_112:S.of(context).g_key_114),
        actions: [
          widget.isAdd?Container():widget.addressDb!.isDefault==1?Container():
          TextButton(
            onPressed: (){
              Provider.of<CoinsProvider>(context,listen: false).deleteAddress(widget.index);
            },
            child: Text(
              S.of(context).g_key_113,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline2!.color,
              ),),
          ),
        ],
      ),
      body: isInit?Container(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        child: LoadingPage1(),
      ):
      Stack(
        children: [
          Positioned.fill(child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0),),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: addressNameTextEditingController,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          //obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                            hintText: S.of(context).g_key_108,
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return S.of(context).g_key_116;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _addressDb.addressName = value!;
                          },
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(40.0),),
                        TextFormField(
                          controller: coinsTextEditingController,
                          readOnly: true,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                            hintText: S.of(context).g_key_117,
                            suffixIcon: IconButton(
                              color:Theme.of(context).iconTheme.color,
                              icon: Icon(Icons.list_alt,),
                              onPressed: (){
                                _selectCoins();
                              },
                            ),
                          ),
                          maxLines: 1,
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                          },
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(40.0),),
                        (_addressDb.isDefault==1 && widget.isAdd)?Container():
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).g_key_109,
                              style: TextStyle(
                                  color: Theme.of(context).textTheme.headline1!.color,
                                  fontSize: ScreenUtil.getInstance().setSp(26.0)
                              ),
                            ),
                            CupertinoSwitch(
                              thumbColor: Color(0xffffffff),
                              activeColor: Color(0xffff6f16),
                              value: _addressDb.isDefault==1?true:false,
                              onChanged: (value){
                                setState(() {
                                  _addressDb.isDefault=value?1:0;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil.getInstance().setWidth(68.0),
                  vertical: ScreenUtil.getInstance().setWidth(30.0),
                ),
                width: double.infinity,
                height: ScreenUtil.getInstance().setWidth(88.0),
                child: TextButton(
                  onPressed: ()async{
                    var _state = _formKey.currentState;
                    if (_state != null) {
                      _state.save();
                      if (_state.validate()) {
                        //EasyLoading.instance.loadingStyle = Theme.of(context).brightness==Brightness.light? EasyLoadingStyle.light:EasyLoadingStyle.dark;
                        //EasyLoading.show(status: S.current.g_key_118);
                        setState(() {
                          showLoading=true;
                        });
                        _modifyAddress();

                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                    shape:MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(88.0))),
                    )),
                  ),
                  child: Text(widget.isAdd?S.of(context).g_key_26:
                  S.of(context).g_key_115,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(32.0),
                        color: Theme.of(context).textTheme.headline3!.color
                    ),
                  ),
                ),
              ),),

            ],
          ),),
          Positioned.fill(
            child: Visibility(
              visible: showLoading,
              child: Container(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                child: LoadingPage1(),
              ),
            ),
          ),
        ],
      ),

    );
  }
  _modifyAddress()async{
    Map<String,dynamic> newCoins={};
    List<String> keyList=_addressDb.coins.keys.toList();
    for(int i=0;i<keyList.length;i++){
      Map<String,dynamic> coin=_addressDb.coins[keyList[i]];
      newCoins[keyList[i]]=coin;
    }
    _addressDb.coins=newCoins;

    //创建地址
    if(_addressDb.isDefault==1){
      //修改所有地址全部为非默认
      await WalletDatabaseProvider.dbProvider.updateAddress_isDefault_0();
    }
    Map<String,dynamic>wallet=Provider.of<WalletsProviderDefault>(context,listen:false).wallet();
    if(widget.isAdd){
      await WalletDatabaseProvider.dbProvider.addAddress(AddressDb.coin(
          addressName: _addressDb.addressName, isDefault: _addressDb.isDefault,walletId: wallet["id"],coins: _addressDb.coins));
    }else{
      await WalletDatabaseProvider.dbProvider.updateAddress(AddressDb.coin(
          addressName: _addressDb.addressName, isDefault: _addressDb.isDefault,walletId: wallet["id"],coins: _addressDb.coins),
          _addressDb.id);
    }
    if(_addressDb.isDefault==1){
      await _reloadWallet();
    }else{
      await _reloadAddress();
    }
    setState(() {
      showLoading=false;
    });
    //EasyLoading.dismiss();
    Navigator.pop(context,'');
  }
  //重新加载钱包数据
  _reloadWallet()async{
    await Provider.of<CoinsProvider>(context,listen: false).reloadWallet();
    /*final defaultWallet = await WalletDatabaseProvider.dbProvider.getAllWallet();
    final address=await WalletDatabaseProvider.dbProvider.getAddressDefault();
    if (defaultWallet != null) {
      await Provider.of<WalletsProviderDefault>(context, listen: false).init(defaultWallet,address);
    } else {
      print("无默认钱包");
    }
    Provider.of<CoinsProvider>(context, listen: false).walletsProviderDefault=Provider.of<WalletsProviderDefault>(context, listen: false);
    await Provider.of<CoinsProvider>(context, listen: false).initCoinsProvider();*/
  }
  //重新加载地址列表
  _reloadAddress()async{
    await Provider.of<CoinsProvider>(context,listen: false).getAddressList();
  }
}