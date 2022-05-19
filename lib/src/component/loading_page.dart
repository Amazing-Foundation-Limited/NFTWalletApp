import 'package:flutter/material.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class LoadingPage1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(200.0),
        alignment: Alignment.center,
        child: Container(
          width: ScreenUtil.getInstance().setWidth(60.0),
          height: ScreenUtil.getInstance().setWidth(60.0),
          child: CircularProgressIndicator(
            //backgroundColor: Theme.of(context).backgroundColor,
            //color: Color(0xffffffff),
          ),
        ),
      )

    );
  }
}


class LoadingPage2 extends StatefulWidget{
  final Widget child;
  LoadingPage2(this.child,{Key? key}):super(key: key);
  @override
  _LoadingPage2State createState()=>_LoadingPage2State();
}
class _LoadingPage2State extends State<LoadingPage2> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=AnimationController(duration: Duration(milliseconds: 1500),vsync: this);
    _animation=Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.linear
      ),
    )..addListener(() {
      setState(() {});
    });
    _controller.repeat();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //width:  double.infinity,
      //height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(_animation.value, _animation.value),
              end: Alignment(1,1),
              colors: [Color.fromRGBO(0, 0, 0, 0.01), Color.fromRGBO(0, 0, 0, 0.02),Color.fromRGBO(0, 0, 0, 0.03),Color.fromRGBO(0, 0, 0, 0.02),Color.fromRGBO(0, 0, 0, 0.01),]
          )
      ),
      child: widget.child,
    );
  }
}