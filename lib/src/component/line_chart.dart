import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class LineChart extends StatefulWidget{
  late double lastValue;//最后值，暂用
  late bool isLight;
  LineChart(this.lastValue,{this.isLight=true,Key? key}):super(key :key);
  @override
  _LineChartState createState()=>_LineChartState();
}
class _LineChartState extends State<LineChart> with TickerProviderStateMixin{
  GlobalKey<State<StatefulWidget>> anchorKey = GlobalKey();
  late BaseLineChart baseLineChart;
  @override
  Widget build(BuildContext context) {
    baseLineChart=BaseLineChart(widget.isLight);
    // TODO: implement build
    return Container(
      key: anchorKey,
      height: ScreenUtil.getInstance().setWidth(320.0),
      width: double.infinity,
      child: CustomPaint(
        painter: baseLineChart,
      ),
    );
  }
}
class BaseLineChart extends CustomPainter{
  late bool isLight;
  BaseLineChart(this.isLight);
  ///画笔
  Paint painter=Paint()..strokeWidth=ScreenUtil.getInstance().setWidth(2.0)..style=PaintingStyle.stroke;
  ///文字
  TextPainter textPainter=TextPainter(
    textDirection: TextDirection.ltr,
    maxLines: 1
  );

  /// 横向线段间隔
  double LINE_SPACE = 20;

  /// 线段数量
  int LINE_NUM = 5;

  /// 最大值
  double MAX_VALUE = 120.0;

  /// 整体宽度
  late double width;
  ///整体高度
  late double height;

  /// Y轴坐标文字宽度
  late double yTextwidth;

  /// x轴坐标单元间距
  late double unitWidth;


  @override
  void paint(Canvas canvas,Size size){
    LINE_SPACE=ScreenUtil.getInstance().setWidth(40.0);
    ///基本区域剪切
    Rect rect =Offset.zero & size;
    canvas.clipRect(rect);
    painter.color=isLight?Colors.white:Color(0xff222222);
    painter.style=PaintingStyle.fill;
    canvas.drawRect(rect, painter);

    width=size.width;
    height=size.height;
    yTextwidth=30;
    unitWidth=(width-yTextwidth)/24;
    ///画背景线
    darwBackgroundLine(canvas);
    xyText(canvas);

    painter.style= PaintingStyle.stroke;
    painter.strokeWidth=ScreenUtil.getInstance().setWidth(4.0);
    painter.color=Color(0xffe67c3b);
    drawValueLine(canvas);

    painter.style= PaintingStyle.fill;
    painter.shader=ui.Gradient.linear(Offset(width/2,0), Offset(width/2,height), [Color.fromRGBO(230, 124, 59, 0.14),Color.fromRGBO(230, 124, 59, 0.0)]);
    painter.color=Color(0xff000000);
    drawValueLine_fill(canvas);
    painter.shader=null;
    /*
    painter.color = Color(0xff26DAD0);
    painter.strokeWidth = 2;
    drawValueLine(canvas);
    painter.color = Color(0xffC95FF2);*/
  }

  /// 画线
  void drawValueLine(Canvas canvas) {
    //List<double> values = [0.5,0.5,0.11,1,2,-0.5,-0.1,-0.2,1,-2,5,0.1,0.5,0.5,0.11,1,2,-0.5,-0.1,-0.2,1,-2,5,0.1];
    List<double> values = [10,50,80,30,15,10,50,60,30,15,10,50,40,30,15,10,50,100,30,15,10,50,120,30,111];
    Path path = Path();
    //path.moveTo(yTextwidth, (LINE_SPACE +ScreenUtil.getInstance().setSp(22.0))*4+ScreenUtil.getInstance().setSp(12.0));
    for (int i = 0; i < values.length - 1; i++) {
      double v1 = values[i];
      double v2 = values[i + 1];
      if (i == 0) {
        path.moveTo(getX(i.toDouble()), getY(v1));
      }
      path = getCurvePath(v1, v2, i, path);
    }
    //path.lineTo(width, (LINE_SPACE +ScreenUtil.getInstance().setSp(22.0))*4+ScreenUtil.getInstance().setSp(12.0));

    canvas.drawPath(path, painter);
    path.close();
  }
  /// 画线
  void drawValueLine_fill(Canvas canvas) {
    //List<double> values = [0.5,0.5,0.11,1,2,-0.5,-0.1,-0.2,1,-2,5,0.1,0.5,0.5,0.11,1,2,-0.5,-0.1,-0.2,1,-2,5,0.1];
    List<double> values = [10,50,80,30,15,10,50,60,30,15,10,50,40,30,15,10,50,100,30,15,10,50,120,30,111];
    Path path = Path();
    path.moveTo(yTextwidth, (LINE_SPACE +ScreenUtil.getInstance().setSp(22.0))*4+ScreenUtil.getInstance().setSp(12.0));
    for (int i = 0; i < values.length - 1; i++) {
      double v1 = values[i];
      double v2 = values[i + 1];
      /*if (i == 0) {
        path.moveTo(getX(i.toDouble()), getY(v1));
      }*/
      path = getCurvePath(v1, v2, i, path);
    }
    path.lineTo(width, (LINE_SPACE +ScreenUtil.getInstance().setSp(22.0))*4+ScreenUtil.getInstance().setSp(12.0));

    canvas.drawPath(path, painter);
    path.close();
  }
  /// 获取曲线路径
  /// [v1] 第一个Y轴值 [v2] 第二个Y轴值
  /// [index] X轴坐标位置
  Path getCurvePath(double v1, double v2, int index, Path path) {
    int clipNum = 30;
    double temp = 1 / clipNum;
    bool isNegativeNumber;
    double diff = (v1 - v2).abs();
    isNegativeNumber = (v1 - v2) < 0;
    for (int i = 0; i < clipNum; i++) {
      path.lineTo(getX(temp * i + index.toDouble()),
          getY((cos((isNegativeNumber ? pi : 0) + pi * temp * i) + 1) * diff / 2 + (isNegativeNumber ? v1 : v2)));
    }
    return path;
  }

  /// 获取Y轴坐标
  double getY(double value) {
    double ySum=(LINE_SPACE +ScreenUtil.getInstance().setSp(22.0))*4;
    double aY=ySum/MAX_VALUE;

    return (ySum-value*aY)+ScreenUtil.getInstance().setSp(12.0);
  }
      /// MAX_VALUE * (LINE_NUM - 1) * LINE_SPACE;

  /// 获取X轴坐标
  double getX(double index) => yTextwidth + index * unitWidth;

  /// 坐标抽文字
  void xyText(Canvas canvas) {

    // y 轴文字
    for (int i = 0; i < LINE_NUM; i++) {
      textPainter.text = TextSpan(
        text: '${(LINE_NUM - i - 1) * 30}',
        style: new TextStyle(
          color: Color(0xffc8c8c8),
          fontSize: ScreenUtil.getInstance().setWidth(22.0),
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas,
          Offset(0, i *( LINE_SPACE +ScreenUtil.getInstance().setSp(22.0))));
      //textPainter.paint(canvas, Offset((yTextwidth - textPainter.width) / 2, i * LINE_SPACE - textPainter.height / 2));
    }

    textPainter.text = TextSpan(
      text: '0:00',
      style: TextStyle(
        color: Color(0xffc8c8c8),
        fontSize: ScreenUtil.getInstance().setSp(22.0),
      ),
    );
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(yTextwidth ,height-ScreenUtil.getInstance().setWidth(40.0)));

    textPainter.text = TextSpan(
      text: '24:00',
      style: TextStyle(
        color: Color(0xffc8c8c8),
        fontSize: ScreenUtil.getInstance().setWidth(22.0),
      ),
    );
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(width- ScreenUtil.getInstance().setWidth(65.0),height-ScreenUtil.getInstance().setWidth(40.0)));
  }
  /// 画背景线
  void darwBackgroundLine(Canvas canvas) {
    painter.strokeWidth = ScreenUtil.getInstance().setWidth(0.5);
    painter.color = Color(0xffc8c8c8);
    for (int i = 0; i < LINE_NUM; i++) {
      canvas.drawLine(
          Offset(yTextwidth, i *( LINE_SPACE +ScreenUtil.getInstance().setSp(22.0))+ScreenUtil.getInstance().setWidth(12.0)),
          Offset(width, i *( LINE_SPACE +ScreenUtil.getInstance().setSp(22.0))+ScreenUtil.getInstance().setWidth(12.0)),
          painter);
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}