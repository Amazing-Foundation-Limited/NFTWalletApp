import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/component/scan_page.dart';
import 'package:kingloryapp/src/cross_chain_transaction/cc_select_coins.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/src/state/cc_transaction_provider.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/util/regular.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';

class CCTransactionSend extends StatefulWidget{
  @override
  _CCTransactionSendState createState()=>_CCTransactionSendState();
}
class _CCTransactionSendState extends State<CCTransactionSend>{
  final _formKey = GlobalKey<FormState>();
  late AddressDb _addressDb;
  late Map<String,dynamic> coin={};//选择交易的币种,from
  late Map<String,dynamic> coin_to={};//选择交易的币种,to

  TextEditingController coinsTextEditingController=TextEditingController();
  TextEditingController fromTextEditingController=TextEditingController();
  TextEditingController toCoinTextEditingController=TextEditingController();
  //TextEditingController toTextEditingController=TextEditingController();
  TextEditingController valueTextEditingController=TextEditingController();
  TextEditingController receiveTextEditingController=TextEditingController();//接收地址

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //toTextEditingController.text="0x48ba0c65289f697407de6f66d0b866c091213281";
  }
  @override
  void dispose() {
    coinsTextEditingController.dispose();
    fromTextEditingController.dispose();
    toCoinTextEditingController.dispose();
    //toTextEditingController.dispose();
    valueTextEditingController.dispose();
    receiveTextEditingController.dispose();
    // TODO: implement dispose
    super.dispose();

  }
  ///扫描二维码 0=to ,1=recevie
  scan({int type=0})async{
    String scanValue =await Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanPage()));

    if(type==0){
      //toTextEditingController.text=scanValue;
    }else{
      receiveTextEditingController.text=scanValue;
    }

  }
  //选择币种，0选择from币种，1选择to币种
  _selectCoins({int type=0})async{
    _addressDb=Provider.of<WalletsProviderDefault>(context,listen: false).addressInfo_get;
    showDialog(
      context: context,
      builder: (context){
        //List<String> keyList=_addressDb.coins.keys.toList();
        //Map<String,dynamic> addressDb=_addressDb.coins;

        return Center(
          child:CCSelectCoins(_addressDb,type==0?coin:coin_to,(isOk,Map<String,dynamic> adb){
            if(isOk){
              if(type==0){
                coin=adb;
                coinsTextEditingController.text=coin.keys.toList()[0];
                var cc=Provider.of<CCTransactionProvider>(context,listen: false);
                //cc.setTransactionData_coinName(coin.keys.toList()[0]);
                cc.setTransactionData_coin(coin);
                KGCProvider? kgcPro = Provider.of<WalletsProviderDefault>(context, listen: false).mtk_eCoin();
                //cc.setTransactionData_from(kgcPro.address);
                fromTextEditingController.text=kgcPro!.address.toString();
                receiveTextEditingController.text=kgcPro.address.toString();
              }else{
                coin_to=adb;
                toCoinTextEditingController.text=coin_to.keys.toList()[0];
                var cc=Provider.of<CCTransactionProvider>(context,listen: false);
                cc.setTransactionData_toCoin(coin_to);
              }
              setState(() {});
            }
            Navigator.pop(context,'');
          },type: type,
          ),
        );

      },
    );
  }
  void _onCheckForm() async {
    var _state = _formKey.currentState;
    if (_state != null) {
      _state.save();
      if (_state.validate()) {
        Provider.of<CCTransactionProvider>(context,listen: false).sendTransaction_public(context);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).g_key_136),
      ),
      body: SafeArea(
        child: Consumer<CCTransactionProvider>(
          builder: (context,value,child){
            return Stack(
              children: [
                Positioned.fill(
                  child: ListView(
                  padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).g_key_138,style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(24.0),
                            color: Theme.of(context).textTheme.headline2!.color,)),
                          SizedBox(height:ScreenUtil.getInstance().setWidth(10.0),),
                          TextFormField(
                            controller: coinsTextEditingController,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            decoration: InputDecoration(
                                hintText: S.of(context).g_key_117,
                                suffixIcon: IconButton(
                                  color:Theme.of(context).iconTheme.color,
                                  icon: Icon(Icons.list_alt),
                                  onPressed: () {
                                    _selectCoins();
                                  },
                                )
                            ),
                          ),
                          SizedBox(height:ScreenUtil.getInstance().setWidth(40.0),),
                          Text(S.of(context).g_key_75,style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(24.0),
                            color: Theme.of(context).textTheme.headline2!.color,)),
                          SizedBox(height:ScreenUtil.getInstance().setWidth(10.0),),
                          TextFormField(
                            controller: fromTextEditingController,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: S.of(context).g_key_75,
                            ),
                            validator: (v) {
                              if (v != null && v.isEmpty) {
                                return S.of(context).g_key_41;
                              }
                              return null;
                            },
                            onSaved: (v) {
                              value.transactionData1?.from=v.toString();
                            },
                          ),
                          SizedBox(height:ScreenUtil.getInstance().setWidth(40.0),),
                          /*Visibility(
                            visible: value.transactionData1?.coinName=='MTK',
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.of(context).g_key_139,style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(24.0),
                                    color: Theme.of(context).textTheme.headline2!.color,)),
                                  SizedBox(height:ScreenUtil.getInstance().setWidth(10.0),),
                                  TextFormField(
                                    controller: toCoinTextEditingController,
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: S.of(context).g_key_117,
                                        suffixIcon: IconButton(
                                          color:Theme.of(context).iconTheme.color,
                                          icon: Icon(Icons.list_alt),
                                          onPressed: () {
                                            _selectCoins(type: 1);
                                          },
                                        )
                                    ),
                                  ),
                                  SizedBox(height:ScreenUtil.getInstance().setWidth(40.0),),
                                ],
                              ),
                            ),
                          ),*/
                          Text(S.of(context).g_key_38,style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(24.0),
                            color: Theme.of(context).textTheme.headline2!.color,)),
                          SizedBox(height:ScreenUtil.getInstance().setWidth(10.0),),
                          TextFormField(
                            controller: receiveTextEditingController,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            decoration: InputDecoration(
                                hintText: S.of(context).g_key_39,
                                suffixIcon: IconButton(
                                  color:Theme.of(context).iconTheme.color,
                                  icon: Icon(Icons.qr_code_scanner_outlined),
                                  onPressed: () {
                                    scan(type: 1);
                                  },
                                )
                            ),
                            validator: (v) {
                              if (v != null && v.isEmpty) {
                                return S.of(context).g_key_41;
                              }
                              return null;
                            },
                            onSaved: (v) {
                              value.transactionData1?.receive=v.toString();
                            },
                          ),
                          SizedBox(height:ScreenUtil.getInstance().setWidth(40.0),),
                          Text(S.of(context).g_key_42,style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(24.0),
                            color: Theme.of(context).textTheme.headline2!.color,)),
                          SizedBox(height:ScreenUtil.getInstance().setWidth(10.0),),
                          Text('${S.of(context).g_key_43}:${value.usableBalance}',style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(24.0),
                            color: Theme.of(context).textTheme.headline2!.color,)),
                          SizedBox(height:ScreenUtil.getInstance().setWidth(10.0),),
                          TextFormField(
                            controller: valueTextEditingController,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            decoration: InputDecoration(
                              hintText: S.of(context).g_key_44,
                            ),
                            validator: (v) {
                              if (v != null && v.isEmpty) {
                                return S.of(context).g_key_46;
                              }
                              bool checkValue=Regular.regular_double(v.toString());
                              bool checkValue1=Regular.regular_nums(v.toString());
                              if(checkValue==false && checkValue1==false){
                                return S.of(context).g_key_134;
                              }else if (double.parse(v!) > value.usableBalance) {
                                return S.of(context).g_key_47;
                              }
                              return null;
                            },
                            onSaved: (v) {
                              value.transactionData1?.value=double.parse(v.toString());
                            },
                          ),


                          Container(
                            margin: EdgeInsets.only(
                              top: ScreenUtil.getInstance().setWidth(80.0),
                            ),
                            width: double.infinity,
                            height: ScreenUtil.getInstance().setWidth(88.0),
                            child: TextButton(
                              onPressed: (){
                                _onCheckForm();
                              },
                              style: ButtonStyle(
                                backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                                shape:MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(88.0))),
                                )),
                              ),
                              child: Text(
                                S.of(context).g_key_32,
                                style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(32.0),
                                    color: Theme.of(context).textTheme.headline3!.color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ),
                Positioned.fill(
                  child: Visibility(
                    visible: value.showLoading,
                    child: Container(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      child: LoadingPage1(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}