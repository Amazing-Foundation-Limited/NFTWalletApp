import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

///加载错误页，带刷新按钮的
class ErrorPage1 extends StatefulWidget{
  String message;
  dynamic reloadBack;
  int type;//错误类型，0报错，1没有数据
  ErrorPage1({this.message='',this.reloadBack=null,this.type=0,Key? key}):super(key:key) {
    if(message==''){
      message=S.current.g_key_5;
    }
  }
  @override
  _ErrorPage1State createState()=>_ErrorPage1State();
}
class _ErrorPage1State extends State<ErrorPage1>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String imageStr='assets/img/network-no.png';
    if(widget.type==1){
      imageStr='assets/img/no_data.png';
    }
    // TODO: implement build
    return Container(
      height: ScreenUtil.getInstance().setWidth(500.0),
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(54.0),
        left: ScreenUtil.getInstance().setWidth(30.0),
        right: ScreenUtil.getInstance().setWidth(30.0)
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Image.asset(
                imageStr,
                width: ScreenUtil.getInstance().setWidth(440.0),
              ),
            ),

          ),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(54.0)),
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(36.0),
                      color: Theme.of(context).textTheme.headline1!.color,
                      height: 1.5,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: (){
                    if(widget.reloadBack!=null){
                      widget.reloadBack();
                    }
                  },
                  icon: Icon(
                    Icons.wifi_protected_setup_outlined,
                    size: ScreenUtil.getInstance().setWidth(60.0),
                  ),
                ),
              ],
            ),
          ),

        ],
      )

    );
  }
}