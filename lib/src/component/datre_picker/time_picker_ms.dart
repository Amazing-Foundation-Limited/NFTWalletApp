import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class TimerPickerMS extends StatefulWidget{
  dynamic valueChangeCallBack;//值更改事件
  var startData;//初始数据
  dynamic closeCallBack;//关闭回调
  TimerPickerMS(this.startData,{
    this.valueChangeCallBack=null,
    this.closeCallBack=null,
    Key?key}):super(key:key);
  @override
  _TimerPickerMSState createState()=>_TimerPickerMSState();
}
class _TimerPickerMSState extends State<TimerPickerMS>{
  late TimeData timeDate;
  late FixedExtentScrollController _controllerMonth;
  late FixedExtentScrollController _controllerDay;
  late FixedExtentScrollController _controllerHour;
  late FixedExtentScrollController _controllerMinute;
  late FixedExtentScrollController _controllerSecond;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeDate=widget.startData;
    _controllerMonth=FixedExtentScrollController(initialItem: timeDate.months);
    _controllerDay=FixedExtentScrollController(initialItem: timeDate.days);
    _controllerHour=FixedExtentScrollController(initialItem: timeDate.hours);
    _controllerMinute=FixedExtentScrollController(initialItem: timeDate.minutes-10);
    _controllerSecond=FixedExtentScrollController(initialItem: timeDate.seconds-1);
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width/5;
    // TODO: implement build
    return Container(
      color: Theme.of(context).backgroundColor,
      height: ScreenUtil.getInstance().setWidth(540.0),
      //padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: (){
                  widget.closeCallBack();
                },
                child: Text(S.of(context).g_key_79,style: TextStyle(
                  color: Theme.of(context).textTheme.headline2!.color,
                  fontSize: ScreenUtil.getInstance().setWidth(36.0),
                ),),
              ),
              TextButton(
                onPressed: (){
                  widget.valueChangeCallBack(timeDate);
                },
                child: Text(S.of(context).g_key_78,style: TextStyle(
                    color: Theme.of(context).textTheme.headline2!.color,
                    fontSize: ScreenUtil.getInstance().setWidth(36.0),
                ),),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: CupertinoTheme(
              data: CupertinoTheme.of(context).copyWith(
                textTheme: CupertinoTextThemeData(
                  pickerTextStyle: TextStyle(
                      fontSize: ScreenUtil.getInstance().setWidth(36.0),
                      color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width,
                    child:
                        Stack(
                          children:[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: ScreenUtil.getInstance().setWidth(72.0),
                                width: ScreenUtil.getInstance().setWidth(50.0),
                                alignment:Alignment.centerLeft,
                                child: Text(S.of(context).g_key_87,style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setWidth(32.0),
                                    color: Theme.of(context).textTheme.bodyText1!.color,),),
                              ),
                            ),
                            CupertinoPicker.builder(
                              //selectionOverlay:null
                              scrollController: _controllerMonth,
                              itemExtent:  ScreenUtil.getInstance().setWidth(72.0),
                              childCount: 13,
                              onSelectedItemChanged: (int index){
                                timeDate.months=index;
                                timeDate.resetValue();
                              },
                              itemBuilder: (context,index){
                                return Container(
                                  height:  ScreenUtil.getInstance().setWidth(72.0),
                                  alignment:Alignment.center,
                                  child: Text(index.toString()),
                                );
                              },
                            ),
                          ],
                        ),
                  ),
                  Container(
                    width: width,
                    child:
                    Stack(
                      children:[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: ScreenUtil.getInstance().setWidth(72.0),
                            width: ScreenUtil.getInstance().setWidth(50.0),
                            alignment:Alignment.centerLeft,
                            child: Text(S.of(context).g_key_88,style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setWidth(32.0),
                                color: Theme.of(context).textTheme.bodyText1!.color,),),
                          ),
                        ),
                        CupertinoPicker.builder(
                          scrollController:_controllerDay,
                          itemExtent: ScreenUtil.getInstance().setWidth(72.0),
                          childCount: 31,
                          onSelectedItemChanged: (int index){
                            timeDate.days=index;
                            timeDate.resetValue();
                          },
                          itemBuilder: (context,index){
                            return Container(
                              height:  ScreenUtil.getInstance().setWidth(72.0),
                              alignment:Alignment.center,
                              child: Text(index.toString()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    child:
                    Stack(
                      children:[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: ScreenUtil.getInstance().setWidth(72.0),
                            width: ScreenUtil.getInstance().setWidth(50.0),
                            alignment:Alignment.centerLeft,
                            child: Text(S.of(context).g_key_89,style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setWidth(32.0),
                                color: Theme.of(context).textTheme.bodyText1!.color,),),
                          ),
                        ),
                        CupertinoPicker.builder(
                          //selectionOverlay:null,
                          scrollController:_controllerHour,
                          itemExtent:  ScreenUtil.getInstance().setWidth(72.0),
                          childCount: 24,
                          onSelectedItemChanged: (int index){
                            timeDate.hours=index;
                            timeDate.resetValue();
                          },
                          itemBuilder: (context,index){
                            return Container(
                              height:  ScreenUtil.getInstance().setWidth(72.0),
                              alignment:Alignment.center,
                              child: Text(index.toString()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    child:
                    Stack(
                      children:[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: ScreenUtil.getInstance().setWidth(72.0),
                            width: ScreenUtil.getInstance().setWidth(50.0),
                            alignment:Alignment.centerLeft,
                            child: Text(S.of(context).g_key_90,style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setWidth(32.0),
                                color: Theme.of(context).textTheme.bodyText1!.color,),),
                          ),
                        ),
                        CupertinoPicker.builder(
                          //selectionOverlay:null,
                          scrollController:_controllerMinute,
                          itemExtent:  ScreenUtil.getInstance().setWidth(72.0),
                          childCount: 60,
                          onSelectedItemChanged: (int index){
                            timeDate.minutes=index;
                            timeDate.resetValue();
                          },
                          itemBuilder: (context,index){
                            return Container(
                              height:  ScreenUtil.getInstance().setWidth(72.0),
                              alignment:Alignment.center,
                              child: Text(index.toString()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    child:
                    Stack(
                      children:[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: ScreenUtil.getInstance().setWidth(72.0),
                            width: ScreenUtil.getInstance().setWidth(50.0),
                            alignment:Alignment.centerLeft,
                            child: Text(S.of(context).g_key_91,style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setWidth(32.0),
                                color: Theme.of(context).textTheme.bodyText1!.color,),),
                          ),
                        ),
                        CupertinoPicker.builder(
                          scrollController:_controllerSecond,
                          itemExtent:  ScreenUtil.getInstance().setWidth(72.0),
                          childCount: 60,
                          onSelectedItemChanged: (int index){
                            timeDate.seconds=index;
                            timeDate.resetValue();
                          },
                          itemBuilder: (context,index){
                            return Container(
                              height:  ScreenUtil.getInstance().setWidth(72.0),
                              alignment:Alignment.center,
                              child: Text(index.toString()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  /*Expanded(
                    flex: 1,
                    child: CupertinoTimerPicker(
                      //backgroundColor: Color(0xffffffff),
                      mode: CupertinoTimerPickerMode.ms, //可以设置时分、时分秒和分秒三种模式
                      initialTimerDuration: Duration(minutes: timeDate.minutes, seconds: timeDate.seconds), // 默认显示的时间值
                      minuteInterval: 1, // 分值间隔，必须能够被initialTimerDuration.inMinutes整除
                      secondInterval: 1, // 秒值间隔，必须能够被initialTimerDuration.inSeconds整除，此时设置为10，则选择项为0、10、20、30、40、50六个值
                      onTimerDurationChanged: (duration) {
                        //返回秒
                        timeDate=TimeData(duration.inMinutes, duration.inSeconds-duration.inMinutes*60,duration.inSeconds);
                      },
                    ),
                  ),*/

                ],
              )

            ),),


        ],
      ),

    );
  }
}
class TimeData{
  late int minutes;//分
  late int seconds;//秒
  late int hours;//小时
  late int days;//天
  late int months;//月
  late int value;
  TimeData(this.minutes,this.seconds,this.value,{this.months=0,this.days=0,this.hours=0});
  resetValue(){
    int v=0;
    if(months!=0){
      v+=months*30*24*60*60;
    }
    if(days!=0){
      v+=days*24*60*60;
    }
    if(hours!=0){
      v+=hours*60*60;
    }
    if(minutes!=0){
      v+=minutes*60;
    }
    value=v+seconds;
  }
}