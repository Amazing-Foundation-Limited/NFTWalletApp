import 'package:flutter/material.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class TopBackground extends StatefulWidget{
  late bool isLight;
  TopBackground({this.isLight=true});
  @override
  _TopBackgroundState createState()=>_TopBackgroundState();
}
class _TopBackgroundState extends State<TopBackground>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BaseLineChart baseLineChart=BaseLineChart(widget.isLight);
    // TODO: implement build
    return Container(
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
  Paint painter=Paint()..strokeWidth=1.0..style=PaintingStyle.stroke;
  ///文字
  TextPainter textPainter=TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: 1
  );



  /// 整体宽度
  late double width;
  ///整体高度
  late double height;



  @override
  void paint(Canvas canvas,Size size){
    ///基本区域剪切
    Rect rect =Offset.zero & size;
    canvas.clipRect(rect);
    painter.color=isLight?Color(0xfff9f9f9):Color(0xff222222);
    painter.style=PaintingStyle.fill;
    canvas.drawRect(rect, painter);

    width=size.width;
    height=size.height;

    painter.style= PaintingStyle.fill;
    painter.color=isLight?Color(0xffff6f16):Color(0xff222222);
    drawValueLine(canvas);
  }

  /// 画线
  void drawValueLine(Canvas canvas) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0,height*0.7);
    path.cubicTo(0, height*0.7,
        width/2, height,
        width, height*0.7);
    //path.lineTo(width,height*0.7);
    path.lineTo(width,0);
    canvas.drawPath(path, painter);
    path.close();
  }
  /*
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
*/
  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}