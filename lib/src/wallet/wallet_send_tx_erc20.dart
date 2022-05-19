
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class SendTransactionErc20 extends StatefulWidget {
  String name;
  double usableBalance;
  SendTransactionErc20({Key? key, required this.name, required this.usableBalance}) : super(key: key);
  @override
  SendTransactionErc20State createState() => SendTransactionErc20State();

}

class SendTransactionErc20State extends State<SendTransactionErc20> {
  final _formKey = GlobalKey<FormState>();
  String to = "0x0CE9Ce2479B71FBAFb5b4d2eb699eB6ae8Ead838";
  String toValue = "";
  TextEditingController toTextEditingController=TextEditingController();
  //是否显示操作等待
  bool showLoading=false;

  @override
  void initState() {
    super.initState();
    toTextEditingController.text=to;
    _getLockupBalance();
  }
  @override
  void dispose(){
    toTextEditingController.dispose();
    super.dispose();
  }

  _getLockupBalance() async {
  }

  void _onCheckForm(context) async {
    var _state = _formKey.currentState;
    if (_state != null) {
      if (this.mounted){
        _state.save();
        if (_state.validate()) {
          setState(() {
            showLoading=true;
          });
          final kgcPro = Provider.of<WalletsProviderDefault>(context, listen: false).mtk_eCoin();
          BigInt value = ethToWeiString(toValue);

          try{
           Map<String,dynamic> r = await kgcPro!.sendTransfer(EthereumAddress.fromHex(to), value, credentials: kgcPro.private);
           setState(() {
             showLoading=false;
           });
           if(r['error']){
             ToastUtils.show(r['data']);
           }else{
             Navigator.pop(context);
           }

          }catch(e){
            setState(() {
              showLoading=false;
            });
            ToastUtils.show(e.toString());
          }

          // kgcPro.subscriptionEvent(1);

          //发送交易
        }
      }

    }
  }

  ///扫描二维码
  scan()async{
    String scanValue =await Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanPage()));

    toTextEditingController.text=scanValue;
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
                          width: double.infinity,
                          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                          margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(30.0)),
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness==Brightness.light?Color(0xfffafafa):Color(0xff2b2b2b),
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(S.of(context).g_key_43,style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(24.0),
                                color: Theme.of(context).textTheme.headline2!.color,)),
                              SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                              getMatchWidget(
                                  '${widget.usableBalance}',
                                  ScreenUtil.getInstance().setWidth(750.0-140.0),
                                  TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(40.0),
                                    color: Theme.of(context).textTheme.headline1!.color,
                                    height: 1.5,
                                  ), ScreenUtil.getInstance().setSp(40.0), ScreenUtil.getInstance().setSp(30.0)
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
                          initialValue: to,
                          // restorationId: 'salary_field',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            //labelText: S.of(context).g_key_39,
                              hintText: S.of(context).g_key_39,
                              suffixIcon: IconButton(icon: Icon(Icons.qr_code_scanner_outlined),
                                color: Theme.of(context).iconTheme.color,
                                onPressed: () {
                                  scan();
                                },)
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
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            //labelText: S.of(context).g_key_44,
                              hintText: S.of(context).g_key_44
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
                            }
                            else if (double.parse(value!) > widget.usableBalance) {
                              return S.of(context).g_key_47;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            toValue = value!;
                          },
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(40.0)),
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