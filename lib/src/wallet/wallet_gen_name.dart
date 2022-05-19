import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/wallet/wallet_gen_password.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class WalletGenName extends StatefulWidget {
  String mnemonic = "";
  WalletGenName({Key? key, required this.mnemonic}) : super(key: key);

  @override
  WalletGenNameState createState() => WalletGenNameState();
}

class WalletGenNameState extends State<WalletGenName> {
  late String name = "牛魔王";
  final _form = GlobalKey<FormState>();

  void _onSaveName(context) {
    var _state = _form.currentState;
    if (_state != null && _state.validate()) {
      _state.save();
      _onGenMnemonic(context);
    }
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold (
          appBar: AppBar(
            title: Text(S.of(context).g_key_6),
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
          /*Column (
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child:  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: ScreenUtil.getInstance().setWidth(36.0),
                    spacing: ScreenUtil.getInstance().setWidth(18.0),
                    children: [
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(64.0),
                          ),
                          children: [
                            TextSpan(
                              text: S.of(context).g_key_17,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:  EdgeInsets.only(
                            top: ScreenUtil.getInstance().setWidth(36.0),
                            right: ScreenUtil.getInstance().setWidth(36.0),
                            left: ScreenUtil.getInstance().setWidth(36.0),
                        ),
                        child: Form(
                          key: _form,
                          child: TextFormField(
                            initialValue: name,
                            // textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: S.of(context).g_key_18,
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
                      ),
                    ],),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Wrap(
                    children: [
                      Container(
                        // height: 45.0,
                        width: ScreenUtil.getInstance().setWidth(460.0),
                        child:  FloatingActionButton.extended(
                          onPressed: () => _onSaveName(context),
                          label: Text(S.of(context).g_key_16, 
                              style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(32.0))),
                        ),
                      ),
                    ]
                  )),
            ],
          )*/
      );
  }

  _onGenMnemonic(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      print(widget.mnemonic);
      return WalletGenPassword(name: name, mnemonic: widget.mnemonic,);
    }));
  }

}