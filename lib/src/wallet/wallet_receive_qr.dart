import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';

class ReceiveQr extends StatefulWidget {
  EthereumAddress addr;

  ReceiveQr({Key? key, required this.addr}) : super(key: key);
  @override
  ReceiveQrState createState() => ReceiveQrState();
}

class ReceiveQrState extends State<ReceiveQr>
    with AutomaticKeepAliveClientMixin { // 切换界面保持，不被重置

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));*/
    return Scaffold(
      backgroundColor: Theme.of(context).brightness==Brightness.light?
      Theme.of(context).textTheme.headline2!.color:Theme.of(context).backgroundColor,
      appBar: new AppBar(
        backgroundColor: Theme.of(context).brightness==Brightness.light?
        Theme.of(context).textTheme.headline2!.color:Theme.of(context).backgroundColor,
        title: new Text(S.of(context).g_key_33),
        titleTextStyle: TextStyle(
            color: Color(0xffffffff),
        ),
        iconTheme: IconThemeData(
            color: Color(0xffffffff),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().setWidth(30.0),
          vertical: ScreenUtil.getInstance().setWidth(160.0),
        ),
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(36.0)),
        child: Column (
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/img/shoukuan.png',width: ScreenUtil.getInstance().setWidth(32.0),),
                SizedBox(width: ScreenUtil.getInstance().setWidth(16.0),),
                Text(
                  "Make collections",
                  style: TextStyle(
                    color: Color(0xff222222),
                    fontSize: ScreenUtil.getInstance().setSp(30.0),
                  ),
                ),
              ],
            ),
            Divider(
              height: ScreenUtil.getInstance().setWidth(50.0),
              color: Color(0xffe4e4e4),
              indent: 0,
              endIndent: 0,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sweep and pay me',style: TextStyle(
                    color: Color(0xff888888),
                    fontSize: ScreenUtil.getInstance().setSp(28.0),
                  ),),
                  Container(
                    width: ScreenUtil.getInstance().setWidth(500.0),
                    height: ScreenUtil.getInstance().setWidth(500.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: ScreenUtil.getInstance().setWidth(1.0),
                        color: Color(0xffe4e4e4),
                      )
                    ),
                    margin: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(36.0)),
                    padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10.0)),
                    child: QrImage(
                      data: widget.addr.toString(),
                      version: QrVersions.min+7,
                      //size: ScreenUtil.getInstance().setWidth(540.0),
                    ),
                  ),
                  Container(
                    child: SelectableText(widget.addr.toString(), textAlign: TextAlign.center, style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(30.0),
                        color: Colors.black54),),
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil.getInstance().setWidth(180.0),
                left: ScreenUtil.getInstance().setWidth(18.0),
                right: ScreenUtil.getInstance().setWidth(18.0),
              ),
              child: Center(
                child: new QrImage(
                  data: widget.addr.toString(),
                  version: QrVersions.min+7,
                  size: ScreenUtil.getInstance().setWidth(540.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(36.0),),
              // width: ,
              child: SelectableText(widget.addr.toString(), textAlign: TextAlign.center, style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(32.0),
                  color: Colors.black54),),
            ),*/
            // SelectableText()
          ],
        ),
      ),

    );
  }
}