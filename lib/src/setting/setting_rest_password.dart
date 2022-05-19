import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:kingloryapp/src/wallet/wallet_info.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';

class SettingRestPassword extends StatefulWidget {
  String oldPassword = "";
  SettingRestPassword({Key? key, required this.oldPassword})
      : super(key: key);

  @override
  SettingRestPasswordState createState() => SettingRestPasswordState();
}

class SettingRestPasswordState extends State<SettingRestPassword> {
  String password = "";
  String passwordr = "";
  final _formKey = GlobalKey<FormState>();

  void _onSaveName(context) {
    var _state = _formKey.currentState;

    if (_state != null) {
      _state.save();
      if (_state.validate()) {
        _onGenMnemonic(
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).g_key_98),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(72.0)),
            height: ScreenUtil.getInstance().setWidth(1000.0),
            //width: ScreenUtil.getInstance().setWidth(580.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).g_key_98,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: ScreenUtil.getInstance().setSp(60.0),
                  ),
                ),
                SizedBox(height: ScreenUtil.getInstance().setWidth(170.0),),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          obscureText: true,
                          initialValue: password,
                          // restorationId: 'salary_field',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: S.of(context).g_key_81,
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return S.of(context).g_key_22;
                            } else if (value != null &&
                                value.length < 8) {
                              return S.of(context).g_key_23;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value!;
                          },
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setWidth(20.0)),
                        TextFormField(
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          obscureText: true,
                          initialValue: passwordr,
                          // textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: S.of(context).g_key_83,
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return S.of(context).g_key_22;
                            } else if (value != null &&
                                value != password) {
                              return S.of(context).g_key_25;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            passwordr = value!;
                          },
                        ),
                      ],
                    )),
                SizedBox(height: ScreenUtil.getInstance().setWidth(200.0),),
                Container(
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
                      S.of(context).g_key_84,
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
  _oldWidget(){
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).g_key_98),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: ScreenUtil.getInstance().setWidth(36.0),
                  spacing: ScreenUtil.getInstance().setWidth(18.0),
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(60.0),
                        ),
                        children: [
                          TextSpan(
                            text: S.of(context).g_key_98,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setWidth(36.0),
                          right: ScreenUtil.getInstance().setWidth(36.0),
                          left: ScreenUtil.getInstance().setWidth(36.0)),
                      child:
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                obscureText: true,
                                initialValue: password,
                                // restorationId: 'salary_field',
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: S.of(context).g_key_81,
                                ),
                                maxLines: 1,
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return S.of(context).g_key_22;
                                  } else if (value != null &&
                                      value.length < 8) {
                                    return S.of(context).g_key_23;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  password = value!;
                                },
                              ),
                              SizedBox(height: ScreenUtil.getInstance().setWidth(90.0)),
                              TextFormField(
                                obscureText: true,
                                initialValue: passwordr,
                                // textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: S.of(context).g_key_83,
                                ),
                                maxLines: 1,
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return S.of(context).g_key_22;
                                  } else if (value != null &&
                                      value != password) {
                                    return S.of(context).g_key_25;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  passwordr = value!;
                                },
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Wrap(children: [
                  Container(
                    // height: 45.0,
                    width: ScreenUtil.getInstance().setWidth(460.0),
                    child: FloatingActionButton.extended(
                      onPressed: () => _onSaveName(context),
                      label: Text(S.of(context).g_key_84, style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(32.0))),
                    ),
                  ),
                ])),
          ],
        ));
  }

  _onGenMnemonic(context) async {
    final defaultWallet =
    Provider.of<WalletsProviderDefault>(context, listen: false).wallet();
    defaultWallet['password'] = password;
    await WalletDatabaseProvider.dbProvider.updateWalletWithId(WalletDb.fromMap(defaultWallet));
    Provider.of<WalletsProviderDefault>(context, listen: false).updatePassword(password);
    Navigator.pop(context);
  }
}
