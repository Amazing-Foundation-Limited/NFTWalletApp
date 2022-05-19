import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:flutter/services.dart';
import 'package:kingloryapp/util/toast_utils.dart';

class SettingMnemonic extends StatefulWidget {
  String mnemonic;
  SettingMnemonic({Key? key, required this.mnemonic}) : super(key: key);
  @override
  SettingMnemonicState createState() => SettingMnemonicState();
}

class SettingMnemonicState extends State<SettingMnemonic>
    with AutomaticKeepAliveClientMixin { // 切换界面保持，不被重置

  List<String> mnemonicList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mnemonicList=widget.mnemonic.split(' ');
  }
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).g_key_85),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  height: ScreenUtil.getInstance().setWidth(1000.0),
                  child: GridView.count(
                    padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                    crossAxisCount: 2,
                    childAspectRatio: 2.3,
                    crossAxisSpacing: ScreenUtil.getInstance().setWidth(26.0),
                    children: List.generate(mnemonicList.length, (index) {
                      String num="";
                      if(index+1<10){
                        num='0${index+1}';
                      }
                      else{
                        num='${index+1}';
                      }
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).brightness==Brightness.light?Color(0xffcccccc):Color(0xff2b2b2b),
                                width: ScreenUtil.getInstance().setWidth(1.0)),
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(36.0))),
                            color: Theme.of(context).brightness==Brightness.light?Colors.transparent:Color(0xff2b2b2b),
                          ),
                          constraints: BoxConstraints(
                            minHeight: ScreenUtil.getInstance().setWidth(72.0),
                            minWidth: double.infinity,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil.getInstance().setWidth(20.0),
                            horizontal: ScreenUtil.getInstance().setWidth(5.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(num,style: TextStyle(
                                color: Theme.of(context).textTheme.headline2!.color,
                                fontSize: ScreenUtil.getInstance().setSp(32.0),
                              ),),
                              SizedBox(width: ScreenUtil.getInstance().setSp(10.0),),
                              Text(mnemonicList[index],
                                maxLines: 2,
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.headline1!.color,
                                  fontSize: ScreenUtil.getInstance().setSp(32.0),
                                ),),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setWidth(80.0),
                  left: ScreenUtil.getInstance().setWidth(68.0),
                  right: ScreenUtil.getInstance().setWidth(68.0),
                ),
                width: double.infinity,
                height: ScreenUtil.getInstance().setWidth(88.0),
                child: TextButton(
                  onPressed: (){
                    Clipboard.setData(ClipboardData(text: widget.mnemonic));
                    ToastUtils.show(S.of(context).g_key_120);
                  },
                  style: ButtonStyle(
                    backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                    shape:MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(88.0))),
                    )),
                  ),
                  child: Text(
                    S.of(context).g_key_119,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(32.0),
                        color: Theme.of(context).textTheme.headline3!.color
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),


    );
  }
}
/*Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil.getInstance().setWidth(30.0),
              vertical: ScreenUtil.getInstance().setWidth(160.0),
            ),
            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(36.0)),
            child: Column (
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setWidth(180.0),
                    left: ScreenUtil.getInstance().setWidth(18.0),
                    right: ScreenUtil.getInstance().setWidth(18.0),
                  ),
                  child: Center(
                    child: SelectableText(widget.mnemonic, textAlign: TextAlign.center,
                      style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(32.0), color: Colors.black54),),
                  ),
                ),
                // SelectableText()
              ],
            ),
          ),*/