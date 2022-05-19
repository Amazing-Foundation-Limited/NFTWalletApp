//验证密码，然后跳转其它重要页面
import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/setting/setting_info_mnemonic.dart';
import 'package:kingloryapp/src/setting/setting_rest_password.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:kingloryapp/util/toast_utils.dart';
import 'package:provider/provider.dart';

//index 0跳转查看助记词，1修改密码
CheckPassword(context ,int index)async{
  Map<String, dynamic> walletMap=Provider.of<WalletsProviderDefault>(context,listen: false).wallet();
  if(walletMap.length==0){
    ToastUtils.show(S.of(context).g_key_124);
    return;
  }
  String pasw = "";
  final _formKey = GlobalKey<FormState>();
  sureClick(){
    var _state = _formKey.currentState;
    if (_state != null) {
      _state.save();
      if (pasw != walletMap['password']) {
        ToastUtils.show(S.of(context).g_key_146);
        Navigator.of(context).pop();
      } else {
        if (index == 1) {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SettingRestPassword(oldPassword: pasw)),
            //ModalRoute.withName('/')
          );
        } else if (index ==0 ) {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SettingMnemonic(mnemonic: walletMap['mnemonic'],)),
            //ModalRoute.withName('/')
          );
        }
      }
    }
  }
  showDialog(
    context: context,
    builder: (context){
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(648.0),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
            ),
            height: ScreenUtil.getInstance().setWidth(400.0),
            /*constraints: BoxConstraints(
              maxHeight: ScreenUtil.getInstance().setWidth(400.0),
            ),*/
            padding: EdgeInsets.only(
              top: ScreenUtil.getInstance().setWidth(44.0),
              bottom: ScreenUtil.getInstance().setWidth(30.0),
              left: ScreenUtil.getInstance().setWidth(44.0),
              right: ScreenUtil.getInstance().setWidth(44.0),
            ),
            child: Column(
              children: [
                Text(S.of(context).g_key_76,style: TextStyle(
                  color: Theme.of(context).brightness==Brightness?Theme.of(context).textTheme.bodyText1!.color:Theme.of(context).textTheme.headline1!.color,
                  fontSize: ScreenUtil.getInstance().setSp(32.0),
                ),),
                Container(
                  padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setWidth(40.0),
                    bottom: ScreenUtil.getInstance().setWidth(36.0),
                  ),
                  constraints: BoxConstraints(
                    minHeight: ScreenUtil.getInstance().setWidth(80.0),
                  ),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      obscureText: true,
                      initialValue: pasw,
                      textInputAction: TextInputAction.send,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: S.of(context).g_key_77,
                      ),
                      maxLines: 1,
                      onSaved: (value) {
                        pasw = value!;
                      },
                      onEditingComplete: (){
                        sureClick();
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child:TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor:  MaterialStateProperty.all(
                              Theme.of(context).brightness==Brightness.light?Colors.transparent:
                              Theme.of(context).textTheme.headline1!.color
                          ),
                          side: MaterialStateProperty.all(
                            BorderSide(
                                color: Theme.of(context).textTheme.headline2!.color!,
                                width: ScreenUtil.getInstance().setSp(1.0)),
                          ),
                          shape:MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(66.0))),
                          )),
                        ),
                        child: Text(
                          S.of(context).g_key_79,
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(26.0),
                              color: Theme.of(context).textTheme.headline2!.color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(20.0)),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: (){
                          sureClick();
                          /*sureClisureClick() {
                            var _state = _formKey.currentState;
                            if (_state != null) {
                              _state.save();
                              if (pasw != walletMap['password']) {
                                Navigator.of(context).pop();
                              } else {
                                if (index == 1) {
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>
                                        SettingRestPassword(oldPassword: pasw)),
                                    //ModalRoute.withName('/')
                                  );
                                } else if (index == 0) {
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>
                                        SettingMnemonic(
                                          mnemonic: walletMap['mnemonic'],)),
                                    //ModalRoute.withName('/')
                                  );
                                }
                              }
                            }
                          };*/
                        },
                        style: ButtonStyle(
                          backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                          shape:MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(66.0))),
                          )),
                        ),
                        child: Text(
                          S.of(context).g_key_78,
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(26.0),
                              color: Theme.of(context).textTheme.headline3!.color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}