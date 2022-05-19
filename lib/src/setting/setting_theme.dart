import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/event/swich_theme_mode.dart';
import 'package:kingloryapp/util/event_bus.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:kingloryapp/util/sp_utils.dart';

class SettingTheme extends StatefulWidget{
  @override
  _SettingThemeState createState()=>_SettingThemeState();
}
class _SettingThemeState extends State<SettingTheme>{
  int themeModeType=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }
  _init()async{
    int tmt=await SPUtils.getThemeMode();
    if(tmt!=null){
      setState(() {
        themeModeType=tmt;
      });
    }
  }
  swichTheme(int i){
    eventBus.fire(SwichThemeMode(i));
    setState(() {
      themeModeType=i;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(S.of(context).g_key_126),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation:0,
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).g_key_127,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize: ScreenUtil.getInstance().setSp(30.0),
                      ),
                    ),
                    CupertinoSwitch(
                      thumbColor: Color(0xffffffff),
                      activeColor: Color(0xffff6f16),
                      value: themeModeType==0,
                      onChanged: themeModeType==0?null:(value){
                        swichTheme(0);
                      },
                    ),
                    /*
                    Switch(
                      inactiveThumbColor: themeModeType==0?Color(0xffffffff):Color(0xffffffff),
                      inactiveTrackColor: themeModeType==0?Color(0xffff6f16):Color(0xff888888),
                      activeColor: Color(0xffffffff),
                      activeTrackColor:Color(0xffff6f16),
                      value: themeModeType==0,
                      onChanged: themeModeType==0?null:(value){
                        swichTheme(0);
                      },
                    ),*/
                  ],
                ),
              ),
            ),
            Card(
              elevation:0,
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).g_key_128,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize: ScreenUtil.getInstance().setSp(30.0),
                      ),
                    ),
                    CupertinoSwitch(
                      thumbColor: Color(0xffffffff),
                      activeColor: Color(0xffff6f16),
                      value: themeModeType==1,
                      onChanged: themeModeType==1?null:(value){
                        swichTheme(1);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation:0,
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).g_key_129,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize: ScreenUtil.getInstance().setSp(30.0),
                      ),
                    ),
                    CupertinoSwitch(
                      thumbColor: Color(0xffffffff),
                      activeColor: Color(0xffff6f16),
                      value: themeModeType==2,
                      onChanged: themeModeType==2?null:(value){
                        swichTheme(2);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}