import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';

class WalletNameModify extends StatefulWidget{
  @override
  _WalletNameModifyState createState()=>_WalletNameModifyState();
}

class _WalletNameModifyState extends State<WalletNameModify>{
  final _form = GlobalKey<FormState>();
  late String name = "牛魔王";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> wpd=Provider.of<WalletsProviderDefault>(context).wallet();
    name=wpd['name'];
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${S.of(context).g_key_28}( ${name})"),
      ),
      body: Center(
        child: Container(
          height: ScreenUtil.getInstance().setWidth(900),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(70.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).g_key_17, style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(60.0),
                  color: Theme.of(context).textTheme.bodyText1!.color)),
              SizedBox(height: ScreenUtil.getInstance().setWidth(120),),
              Text(S.of(context).g_key_18, style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                  color: Theme.of(context).textTheme.headline2!.color)),
              Form(
                key: _form,
                child: TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                  initialValue: name,
                  // textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    hintText: S.of(context).g_key_19,
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value != null && value.isEmpty ) {
                      return S.of(context).g_key_19;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value!;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setWidth(300.0),
                ),
                width: double.infinity,
                height: ScreenUtil.getInstance().setWidth(88.0),
                child: TextButton(
                  onPressed: (){
                    _onSaveName(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                    shape:MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(88.0))),
                    )),
                  ),
                  child: Text(
                    S.of(context).g_key_16,
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
      ),
    );
  }
  void _onSaveName(context) {
    var _state = _form.currentState;
    if (_state != null && _state.validate()) {
      _state.save();
      _onGenMnemonic(context);
    }
  }
  _onGenMnemonic(context) async{
    final defaultWallet =
    Provider.of<WalletsProviderDefault>(context, listen: false).wallet();
    defaultWallet['name'] = name;
    await WalletDatabaseProvider.dbProvider.updateWalletWithId(WalletDb.fromMap(defaultWallet));
    Provider.of<WalletsProviderDefault>(context, listen: false).updateName(name);
    Navigator.pop(context);
  }
}