
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/component/scan_page.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:kingloryapp/util/get_test_size.dart';
import 'package:kingloryapp/util/regular.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:kingloryapp/util/toast_utils.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';
//import 'package:flutter_easyloading/flutter_easyloading.dart';

class SendTransaction extends StatefulWidget {
  String name;
  double usableBalance;
  SendTransaction({Key? key, required this.name, required this.usableBalance}) : super(key: key);
  @override
  SendTransactionState createState() => SendTransactionState();

}

class SendTransactionState extends State<SendTransaction> {
  final _formKey = GlobalKey<FormState>();
  String to = "0x0CE9Ce2479B71FBAFb5b4d2eb699eB6ae8Ead838";
  String toValue = "";
  BigInt gasPrice = BigInt.from(1);
  int gas = 2100;
  late TextEditingController toTextEditingController;
  //是否显示操作等待
  bool showLoading=false;

  @override
  void initState() {
    super.initState();
    toTextEditingController=TextEditingController();
    toTextEditingController.text=to;
    _getLockupBalance();
  }
  @override
  void dispose(){
    toTextEditingController.dispose();
    super.dispose();
  }

  _getLockupBalance() async {
    EthProvider? ethPro = Provider.of<WalletsProviderDefault>(context, listen: false).coinByName(widget.name);
    final gasprice = await ethPro!.gasPrice();
    // final strBalance = EtherAmount.inWei(balance).toString2();
    if (this.mounted) {
      setState(() {
        gasPrice = gasprice;
      });
    }
    // if (widget.name == "ETH") {
    //   final ethPro = Provider.of<WalletsProviderDefault>(context, listen: false).ethCoin();
    //   final gasprice = await ethPro.gasPrice();
    //   // final strBalance = EtherAmount.inWei(balance).toString2();
    //   setState(() {
    //     gasPrice = gasprice;
    //   });
    // } else {
    //   final ethPro = Provider.of<WalletsProviderDefault>(context, listen: false).bscCoin();
    //   final gasprice = await ethPro.gasPrice();
    //   setState(() {
    //     gasPrice = gasprice;
    //   });
    // }
  }

  void _onCheckForm(context) async {
    var _state = _formKey.currentState;
    if (_state != null) {
      _state.save();
      if (_state.validate()) {
        // _onGenMnemonic(context, );
        //发送交易
        setState(() {
          showLoading=true;
        });
        final totalGas = gasPrice * BigInt.from(gas);
        EthProvider? coinPro = Provider.of<WalletsProviderDefault>(context, listen: false).coinByName(widget.name);
        BigInt value = ethToWeiString(toValue);


        try{
          Map<String,dynamic> r = await coinPro!.sendTransaction(to, value, totalGas);
          setState(() {
            showLoading=false;
          });
          if(r['error']){
            ToastUtils.show(r['data']);
          }else{
            //print(r.toString());
            Navigator.pop(context);
          }
        }catch(e){
          setState(() {
            showLoading=false;
          });
          ToastUtils.show(e.toString());
          //print(e.toString());
        }


        // kgcPro.subscriptionEvent(1);

      }
    }
  }

  void scanQR() async{
    String scanValue =await Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanPage()));

    toTextEditingController.text=scanValue;
    /*try {
      final result = await BarcodeScanner.scan(
        /*options: ScanOptions(
          strings: {
            'cancel': "取消",
            'flash_on': "on",
            'flash_off': "off",
          },
          //restrictFormat: selectedFormats,
          //useCamera: _selectedCamera,
          //autoEnableFlash: _autoEnableFlash,
          /*android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),*/
        ),*/
      );
      toTextEditingController.text=result.rawContent;
      //setState(() => scanResult = result);
    } on PlatformException catch (e) {
      if(e.code==BarcodeScanner.cameraAccessDenied){
        ToastUtils.show("用户未授权使用相机");
      }else{
        ToastUtils.show("未知错误");
      }
    }catch(e){
      ToastUtils.show("未知错误");
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}-${S.of(context).g_key_37}"),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setWidth(36.0),
                  left: ScreenUtil.getInstance().setWidth(40.0),
                  right: ScreenUtil.getInstance().setWidth(40.0),
                ),
                child: Form(
                    key: _formKey,
                    child: Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                          margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(30.0)),
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness==Brightness.light?Color(0xfffafafa):Color(0xff2b2b2b),
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(S.of(context).g_key_43,style: TextStyle(
                                        fontSize: ScreenUtil.getInstance().setSp(24.0),
                                        color: Theme.of(context).textTheme.headline2!.color,)),
                                      SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                                      getMatchWidget(
                                        '${widget.usableBalance}',
                                        ScreenUtil.getInstance().setWidth((750.0-140.0)/2),
                                        TextStyle(
                                          fontSize: ScreenUtil.getInstance().setSp(40.0),
                                          color: Theme.of(context).textTheme.headline1!.color,
                                          height: 1.5,
                                        ), ScreenUtil.getInstance().setSp(40.0), ScreenUtil.getInstance().setSp(30.0)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenUtil.getInstance().setWidth(80.0),
                                child: VerticalDivider(
                                  width: ScreenUtil.getInstance().setWidth(20.0),
                                  color: Color(0xff979797),
                                  indent: ScreenUtil.getInstance().setWidth(10.0),
                                  endIndent: ScreenUtil.getInstance().setWidth(10.0),
                                  thickness: 1,
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(S.of(context).g_key_102,style: TextStyle(
                                        fontSize: ScreenUtil.getInstance().setSp(24.0),
                                        color: Theme.of(context).textTheme.headline2!.color,)),
                                      SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                                      getMatchWidget(
                                          '${toGWei(EtherAmount.inWei(gasPrice).getInWei.toString())} G',
                                          ScreenUtil.getInstance().setWidth((750.0-140.0)/2),
                                          TextStyle(
                                            fontSize: ScreenUtil.getInstance().setSp(40.0),
                                            color: Theme.of(context).textTheme.headline1!.color,
                                            height: 1.5,
                                          ), ScreenUtil.getInstance().setSp(40.0), ScreenUtil.getInstance().setSp(30.0)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(S.of(context).g_key_38, style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(24.0),
                            color: Theme.of(context).textTheme.headline2!.color
                        ),),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(10)),
                        TextFormField(
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          controller: toTextEditingController,
                          //initialValue: to,
                          // restorationId: 'salary_field',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                            //labelText: "请输入收款地址",
                              hintText: S.of(context).g_key_39,
                              suffixIcon: IconButton(
                                icon:
                                Icon(Icons.qr_code_scanner_outlined),
                                color: Theme.of(context).iconTheme.color,
                                onPressed: () => scanQR(),)
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return S.of(context).g_key_41;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            to = value!;
                          },
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(40)),
                        Text(S.of(context).g_key_42, style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(24.0),
                          color: Theme.of(context).textTheme.headline2!.color,)),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(10.0)),
                        TextFormField(
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          initialValue: toValue,
                          // textInputAction: TextInputAction.next,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),//TextInputType.number,
                          decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                            //labelText: "请输入金额",
                            hintText: S.of(context).g_key_44,
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return S.of(context).g_key_46;
                            }
                            bool checkValue=Regular.regular_double(value.toString());
                            bool checkValue1=Regular.regular_nums(value.toString());
                            if(checkValue==false && checkValue1==false){
                              return S.of(context).g_key_134;
                            } else if (double.parse(value!) > widget.usableBalance) {
                              return S.of(context).g_key_47;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            toValue = value!;
                          },
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(40.0)),
                        // const Text('矿工费', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
                        Text(S.of(context).g_key_101, style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(24.0),
                          color: Theme.of(context).textTheme.headline2!.color,)),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(10.0)),
                        TextFormField(
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          textAlign: TextAlign.left,
                          initialValue: gas.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                            //labelText: "请输入gas费用",
                            hintText: S.of(context).g_key_103,
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return S.of(context).g_key_104;
                            }
                            bool checkValue=Regular.regular_nums(value.toString());
                            if(checkValue==false){
                              return S.of(context).g_key_135;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            gas = int.parse(value!);
                          },
                        ),
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setWidth(80.0),
                  left: ScreenUtil.getInstance().setWidth(40.0),
                  right: ScreenUtil.getInstance().setWidth(40.0),
                ),
                width: double.infinity,
                height: ScreenUtil.getInstance().setWidth(88.0),
                child: TextButton(
                  onPressed: (){
                    _onCheckForm(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                    shape:MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(88.0))),
                    )),
                  ),
                  child: Text(
                    S.of(context).g_key_48,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(32.0),
                        color: Theme.of(context).textTheme.headline3!.color
                    ),
                  ),
                ),
              ),
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

}