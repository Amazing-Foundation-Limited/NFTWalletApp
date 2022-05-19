
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/wallet/wallet_gen_name.dart';
import 'package:kingloryapp/src/wallet/wallet_import_mnemonic.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class WalletGen extends StatefulWidget {
  const WalletGen({Key? key}) : super(key: key);

  @override
  WalletGenState createState() => WalletGenState();

}

class WalletGenState extends State<WalletGen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: ScreenUtil.getInstance().setWidth(900),
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(70),),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).g_key_7, style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(60.0),
                color: Theme.of(context).textTheme.bodyText1!.color)),
            SizedBox(height: ScreenUtil.getInstance().setWidth(70),),
            Text(S.of(context).g_key_8, style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(30.0),
                color: Theme.of(context).textTheme.bodyText1!.color)),
            SizedBox(height: ScreenUtil.getInstance().setWidth(20),),
            Text(S.of(context).g_key_9,
                style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30.0),
              color: Theme.of(context).textTheme.bodyText1!.color)),

            Container(
              margin: EdgeInsets.only(
                top: ScreenUtil.getInstance().setWidth(120.0),
              ),
              width: double.infinity,
              height: ScreenUtil.getInstance().setWidth(88.0),
              child: TextButton(
                onPressed: (){
                  _onGeName(context);
                },
                style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                  shape:MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(88.0))),
                  )),
                ),
                child: Text(
                  S.of(context).g_key_10,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(32.0),
                      color: Theme.of(context).textTheme.headline3!.color
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: ScreenUtil.getInstance().setWidth(40.0),
              ),
              width: double.infinity,
              height: ScreenUtil.getInstance().setWidth(88.0),
              child: InkWell(
                onTap: (){
                  _onImport(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/img/igw-l-import-1.png',
                      width: ScreenUtil.getInstance().setWidth(28.0),
                      height: ScreenUtil.getInstance().setWidth(28.0),
                    ),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(10.0),),
                    Text(S.of(context).g_key_11,
                        style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(24.0),
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyText1!.color)
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    /*
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: Center(
              // child:  Text("Wallet gen", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              child: Wrap(
              spacing: ScreenUtil.getInstance().setWidth(30.0),
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(S.of(context).g_key_7, style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(48.0),
                    fontWeight: FontWeight.bold)),
                Text(S.of(context).g_key_8, style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(30.0))),
                Text(S.of(context).g_key_9,
                    style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26.0))),
              ],
            ),
            )
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Container(
              height: ScreenUtil.getInstance().setWidth(90.0),
              width: ScreenUtil.getInstance().setWidth(460.0),
              child:  FloatingActionButton.extended(
                onPressed: ()=> _onGeName(context),
                label: Text(S.of(context).g_key_10,
                    style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(32.0))),
                ),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                icon: Icon(Icons.download_outlined),
                label: Text(S.of(context).g_key_11,
                    style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(32.0),
                        fontWeight: FontWeight.bold)),
                onPressed: ()=> _onImport(context),
              ),
            ],
          ),
        )
      ],
    );*/
  }

  _onImport(contest) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WalletImportMnemonic();
    }));
  }

  _onGeName(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WalletGenName(mnemonic: "",);
    }));
  }
}