import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kingloryapp/src/wallet/wallet_info.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';

class WalletGenPassword extends StatefulWidget {
  String name = "";
  String mnemonic = "";
  WalletGenPassword({Key? key, required this.name, required this.mnemonic})
      : super(key: key);

  @override
  WalletGenPasswordState createState() => WalletGenPasswordState();
}

class WalletGenPasswordState extends State<WalletGenPassword> {
  String password = "";
  String passwordr = "";
  bool showLoading=false;
  final _formKey = GlobalKey<FormState>();

  void _onSaveName(context) {
    var _state = _formKey.currentState;

    if (_state != null) {
      _state.save();
      if (_state.validate()) {
        setState(() {
          showLoading=true;
        });
        _onGenMnemonic();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Stack(
          children: [
            Positioned.fill(child: Center(
              child: Container(
                height: ScreenUtil.getInstance().setWidth(900),
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(70),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).g_key_20, style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(60.0),
                        color: Theme.of(context).textTheme.bodyText1!.color)),
                    SizedBox(height: ScreenUtil.getInstance().setWidth(70),),
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
                              //border: OutlineInputBorder(),
                              hintText: S.of(context).g_key_21,
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
                          SizedBox(height: ScreenUtil.getInstance().setWidth(40.0),),
                          TextFormField(
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            obscureText: true,
                            initialValue: passwordr,
                            // textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              hintText: S.of(context).g_key_24,
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
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setWidth(200.0),
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
                          S.of(context).g_key_26,
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
        /*Column(
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
                          fontSize: ScreenUtil.getInstance().setSp(64.0),
                        ),
                        children: [
                          TextSpan(
                            text: S.of(context).g_key_20,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setWidth(36.0),
                          right: ScreenUtil.getInstance().setWidth(36.0),
                          left: ScreenUtil.getInstance().setWidth(36.0),
                      ),
                      child: Form(
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
                                  labelText: S.of(context).g_key_21,
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
                              SizedBox(height: ScreenUtil.getInstance().setWidth(90.0),),
                              TextFormField(
                                obscureText: true,
                                initialValue: passwordr,
                                // textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: S.of(context).g_key_24,
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
                      label: Text(S.of(context).g_key_26, style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(32.0)
                      )),
                    ),
                  ),
                ])),
          ],
        )*/
    );
  }

  _processWallet() async {
      final defaultWallet =
          Provider.of<WalletsProviderDefault>(context, listen: false).wallet();
      //final addressInfo=Provider.of<WalletsProviderDefault>(context, listen: false).addressInfo();
      if (defaultWallet.isEmpty) {
        //WalletDb w = WalletDb(name: widget.name, password: password, mnemonic: widget.mnemonic);
        //添加钱包
        int walletId=await WalletDatabaseProvider.dbProvider.addWalletToDatabase(WalletDb(
            name: widget.name, password: password,mnemonic: widget.mnemonic));
        //添加默认地址
        
        await WalletDatabaseProvider.dbProvider.addAddress(AddressDb.coin(
            addressName: 'Address 1', isDefault: 1,walletId: walletId,coins: GetCoins(0)));
        AddressDb? addInfo=await WalletDatabaseProvider.dbProvider.getAddressDefault();
        await Provider.of<WalletsProviderDefault>(context, listen: false).init(
            WalletDb(
                name: widget.name,
                password: password,
                mnemonic: widget.mnemonic
            ),addInfo);
      }
      /*await WalletDatabaseProvider.dbProvider.addWalletToDatabase(WalletDb(
          name: widget.name, password: password,
          //mnemonic: widget.mnemonic
      ));*/
      await Provider.of<CoinsProvider>(context, listen: false)
          .initCoinsProvider();
  }

  _onGenMnemonic() async {
    if (widget.mnemonic.isEmpty) {
      widget.mnemonic = bip39.generateMnemonic();
    }
    await _processWallet();

    setState(() {
      showLoading=false;
    });
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    // EasyLoading.showInfo('Useful Information.');
  //   final defaultWallet =
  //       Provider.of<WalletsProviderDefault>(context, listen: false).wallet();
  //   if (defaultWallet.isEmpty) {
  //     WalletDb w = WalletDb(
  //         name: widget.name, password: password, mnemonic: widget.mnemonic);
  //     await WalletDatabaseProvider.dbProvider.addDefaultWallet(WalletDb(
  //         name: widget.name, password: password, mnemonic: widget.mnemonic));
  //     await Provider.of<WalletsProviderDefault>(context, listen: false).init(
  //         WalletDb(
  //             name: widget.name,
  //             password: password,
  //             mnemonic: widget.mnemonic));
  //   }
  //
  //   await WalletDatabaseProvider.dbProvider.addWalletToDatabase(WalletDb(
  //       name: widget.name, password: password, mnemonic: widget.mnemonic));
  //   await Provider.of<CoinsProvider>(context, listen: false)
  //       .initCoinsProvider();
  //   Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }
}
