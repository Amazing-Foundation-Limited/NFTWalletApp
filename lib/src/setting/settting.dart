import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/wallet_widget/check_password.dart';
import 'package:kingloryapp/src/http/network_api.dart';
import 'package:kingloryapp/src/setting/setService.dart';
import 'package:kingloryapp/src/setting/setting_browser.dart';
import 'package:kingloryapp/src/setting/setting_info_mnemonic.dart';
import 'package:kingloryapp/src/setting/setting_rest_password.dart';
import 'package:kingloryapp/src/setting/setting_theme.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:kingloryapp/util/sp_utils.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:kingloryapp/main.dart' as main;

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  SettingWidgetState createState() => SettingWidgetState();

}

class SettingWidgetState extends State<SettingWidget> {
  Map<String, dynamic> walletMap = {};
  String appVersion="2.0";
  bool isTestApi=true;
  @override
  void initState() {
    super.initState();

    final ws = Provider.of<WalletsProviderDefault>(context, listen: false).wallet();
    if (ws.isNotEmpty) {
      setState(() {
        walletMap = ws;
      });
    }
    _getPageInfo();
  }
  _getPageInfo()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var r=await SPUtils.getTestApi();
    if(r!=null){
      isTestApi=r;
    }
    setState(() {
      appVersion = packageInfo.version;
    });
  }
  _info(int index) {
    if (index == 0) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return SettingMnemonic(mnemonic: walletMap['mnemonic'],);
      }));
    }
  }

  _intoBrowser() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MyApp();
    }));
  }
  _intoThemeSet(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SettingTheme();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Setting"),
        ),
        body: newWidget(),
    );
  }
  newWidget(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.getInstance().setWidth(30.0),
        vertical: ScreenUtil.getInstance().setWidth(30.0),
      ),
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).g_key_95,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline2!.color,
                fontSize: ScreenUtil.getInstance().setSp(26.0),
                height: 1.5,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setSp(10.0)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setSp(16.0))),
              color: Theme.of(context).cardTheme.color,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    //_restPassword(0);
                    CheckPassword(context, 0);
                    //_restPawword(context, 0);
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(30.0)),
                    child: Row(
                      children:[
                        Image.asset('assets/img/chakan.png',
                          width: ScreenUtil.getInstance().setWidth(32.0),
                          height: ScreenUtil.getInstance().setWidth(32.0),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.getInstance().setWidth(20.0),
                            ),
                            child: Text(S.of(context).g_key_97,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline1!.color,
                                fontSize: ScreenUtil.getInstance().setSp(30.0),
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_sharp,
                          size: ScreenUtil.getInstance().setWidth(30.0),
                          color: Theme.of(context).textTheme.headline6!.color,
                        ),
                      ],


                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    //_restPassword(1);
                    CheckPassword(context,1);
                    //_restPawword(context, 1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(30.0)),
                    child: Row(
                      children:[
                        Image.asset('assets/img/mima.png',
                          width: ScreenUtil.getInstance().setWidth(32.0),
                          height: ScreenUtil.getInstance().setWidth(32.0),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.getInstance().setWidth(20.0),
                            ),
                            child: Text(S.of(context).g_key_98,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline1!.color,
                                fontSize: ScreenUtil.getInstance().setSp(30.0),
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_sharp,
                          size: ScreenUtil.getInstance().setWidth(30.0),
                          color: Theme.of(context).textTheme.headline6!.color,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).g_key_96,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline2!.color,
                fontSize: ScreenUtil.getInstance().setSp(26.0),
                height: 1.5,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setSp(10.0)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setSp(16.0))),
              color: Theme.of(context).cardTheme.color,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    _intoBrowser();
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(30.0)),
                    child: Row(
                      children:[
                        Image.asset('assets/img/liulanqi.png',
                          width: ScreenUtil.getInstance().setWidth(32.0),
                          height: ScreenUtil.getInstance().setWidth(32.0),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.getInstance().setWidth(20.0),
                            ),
                            child: Text(S.of(context).g_key_99,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline1!.color,
                                fontSize: ScreenUtil.getInstance().setSp(30.0),
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_sharp,
                          size: ScreenUtil.getInstance().setWidth(30.0),
                          color: Theme.of(context).textTheme.headline6!.color,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    _intoThemeSet();
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(30.0)),
                    child: Row(
                      children:[
                        Image.asset('assets/img/theme.png',
                          width: ScreenUtil.getInstance().setWidth(32.0),
                          height: ScreenUtil.getInstance().setWidth(32.0),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.getInstance().setWidth(20.0),
                            ),
                            child: Text(S.of(context).g_key_126,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline1!.color,
                                fontSize: ScreenUtil.getInstance().setSp(30.0),
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_sharp,
                          size: ScreenUtil.getInstance().setWidth(30.0),
                          color: Theme.of(context).textTheme.headline6!.color,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(30.0)),
                  child: Row(
                    children:[
                      Image.asset('assets/img/theme.png',
                        width: ScreenUtil.getInstance().setWidth(32.0),
                        height: ScreenUtil.getInstance().setWidth(32.0),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.getInstance().setWidth(20.0),
                          ),
                          child: Text(S.of(context).g_key_133,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.headline1!.color,
                              fontSize: ScreenUtil.getInstance().setSp(30.0),
                            ),
                          ),
                        ),
                      ),
                      Text("v${appVersion}",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color,
                          fontSize: ScreenUtil.getInstance().setSp(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(30.0)),
                    child: Row(
                      children:[
                        Image.asset('assets/img/theme.png',
                          width: ScreenUtil.getInstance().setWidth(32.0),
                          height: ScreenUtil.getInstance().setWidth(32.0),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.getInstance().setWidth(20.0),
                            ),
                            child: Text("是否使用测试地址",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline1!.color,
                                fontSize: ScreenUtil.getInstance().setSp(30.0),
                              ),
                            ),
                          ),
                        ),
                        CupertinoSwitch(
                          thumbColor: Color(0xffffffff),
                          activeColor: Color(0xffff6f16),
                          value: isTestApi,
                          onChanged: (value)async{
                            isTestApi=value;
                            SPUtils.setTestApi(isTestApi);
                            Api.reSetBaseUrl(isTestApi);
                            useTestAddress=isTestApi;
                            final defaultWallet = await WalletDatabaseProvider.dbProvider.getAllWallet();
                            if(defaultWallet!=null){
                              defaultWallet.coins=GetCoins((defaultWallet.id-1));
                              final address=await WalletDatabaseProvider.dbProvider.getAddressDefault();
                              address!.coins=GetCoins((defaultWallet.id-1));
                              await WalletDatabaseProvider.dbProvider.updateAddress(address, address.id);
                              //await Provider.of<WalletsProviderDefault>(context, listen: false).init(defaultWallet,address);
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>main.MyApp()), (route) => false);
                            }

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return SetService();
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(30.0)),
                    child: Row(
                      children:[
                        Image.asset('assets/img/theme.png',
                          width: ScreenUtil.getInstance().setWidth(32.0),
                          height: ScreenUtil.getInstance().setWidth(32.0),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil.getInstance().setWidth(20.0),
                            ),
                            child: Text("设置服务器地址",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline1!.color,
                                fontSize: ScreenUtil.getInstance().setSp(30.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}