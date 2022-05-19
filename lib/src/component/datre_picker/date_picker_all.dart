import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class DatePickerAll extends StatefulWidget{
  dynamic valueChangeCallBack;//值更改事件
  var startData;//初始数据
  dynamic closeCallBack;//关闭回调
  DatePickerAll(this.startData,{
    this.valueChangeCallBack=null,
    this.closeCallBack=null,
    Key?key}):super(key:key);
  @override
  _DatePickerAllState createState()=>_DatePickerAllState();
}
class _DatePickerAllState extends State<DatePickerAll>{
  late DateData dateDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateDate=widget.startData;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Theme.of(context).backgroundColor,
      height: ScreenUtil.getInstance().setWidth(540.0),
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
                  widget.valueChangeCallBack(dateDate);
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
              data: CupertinoThemeData(
                textTheme:CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: ScreenUtil.getInstance().setWidth(36.0),
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                dateOrder: DatePickerDateOrder.ymd,
                mode: CupertinoDatePickerMode.dateAndTime, //可以设置时分、时分秒和分秒三种模式
                //initialDateTime: dateDate.dateTime, // 默认显示的时间值
                minimumDate: DateTime.now(),
                // 秒值间隔，必须能够被initialTimerDuration.inSeconds整除，此时设置为10，则选择项为0、10、20、30、40、50六个值
                onDateTimeChanged: (duration) {
                  dateDate=DateData(duration);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class DateData{
  final DateTime dateTime;
  late int value;
  DateData(this.dateTime){
    value=dateTime.millisecondsSinceEpoch~/1000;
  }
}