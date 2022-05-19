import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

Size getTextSize(String text, TextStyle style,double maxWidth) {
  TextPainter painter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: ui.TextDirection.ltr,
  );
  painter.layout(maxWidth: maxWidth);
  return painter.size;
}
//返回计算后的widget
Widget getMatchWidget(String value,double maxWidth,TextStyle testStyle,double maxFontSize,double minFontSize){
  double fontSize=maxFontSize;
  while(true){
    if(fontSize<=minFontSize){
      break;
    }
    testStyle=testStyle.copyWith(
      fontSize: fontSize,
    );
    Size s=getTextSize(value,testStyle,maxWidth);
    double height=ScreenUtil.getInstance().setSp(fontSize*1.4);
    if(s.width<maxWidth){
      if(s.height>height){
        fontSize=fontSize-2;
      }else{
        break;
      }
    }else{
      fontSize=fontSize-2;
    }
  }
  return Text(value,
    style: testStyle,
  );
}