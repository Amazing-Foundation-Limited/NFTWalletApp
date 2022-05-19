
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/datre_picker/date_picker_all.dart';
import 'package:kingloryapp/src/component/datre_picker/time_picker_ms.dart';
import 'package:kingloryapp/src/component/loading_page.dart';
import 'package:kingloryapp/src/component/scan_page.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:kingloryapp/util/get_test_size.dart';
import 'package:kingloryapp/util/regular.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:kingloryapp/util/toast_utils.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';
import 'package:intl/intl.dart' as dateformat;

class SendTransactionKgc extends StatefulWidget {
  String name;
  double usableBalance;
  SendTransactionKgc({Key? key, required this.name, required this.usableBalance}) : super(key: key);
  @override
  SendTransactionKgcState createState() => SendTransactionKgcState();

}

class SendTransactionKgcState extends State<SendTransactionKgc> {
  final _formKey = GlobalKey<FormState>();
  String to = "";
  String toValue = "";
  String lockAmount = "";
  int interval = 601;
  int start = 0;
  String releaseAmount = "";
  TextEditingController toTextEditingController=TextEditingController();
  TextEditingController intervalTextEditingController=TextEditingController();
  TextEditingController startTextEditingController=TextEditingController();
  //是否显示选择时间层
  bool showTimerPicker=false;
  //选择时间类型
  int timePickerType=0;
  //选择的间隔时间
  TimeData intervalTimeData=TimeData(10,1,601);
  //选择释放时间
  DateData startDateData=DateData(DateTime.now());
  //是否显示操作等待
  bool showLoading=false;

  @override
  void initState() {
    super.initState();
    toTextEditingController.text=to;
    intervalTextEditingController.text=interval.toString();
    startTextEditingController.text=dateformat.DateFormat('yyyy-MM-dd HH:mm').format(startDateData.dateTime);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    toTextEditingController.dispose();
    intervalTextEditingController.dispose();
    startTextEditingController.dispose();
  }

  void _showDemoPicker({required BuildContext context, required Widget child,}) {
    final themeData = CupertinoTheme.of(context);
    final dialogBody = CupertinoTheme(
      data: themeData,
      child: child,
    );

    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => dialogBody,
    );
  }
  void _onCheckForm(context) async {
    var _state = _formKey.currentState;
    if (_state != null) {
      _state.save();
      if (_state.validate()) {
        // _onGenMnemonic(context, );
        //发送交易
        setState(() {
          showLoading=true;
        });
        final kgcPro = Provider.of<WalletsProviderDefault>(context, listen: false).mtk_eCoin();
        BigInt value = ethToWeiString(toValue);
        BigInt lAmount = ethToWeiString(lockAmount);
        BigInt rAmount = ethToWeiString(releaseAmount);
        BigInt rInterval = BigInt.from(interval);
        BigInt sTimer = BigInt.from(start);
        var r;
        try{
          r= await kgcPro!.sendLockupTransfer(EthereumAddress.fromHex(to), value, lAmount, rInterval, rAmount, sTimer, credentials: kgcPro.private);
          setState(() {
            showLoading=false;
          });
          // kgcPro.subscriptionEvent(1);
          Navigator.pop(context);
        }catch(e){
          setState(() {
            showLoading=false;
          });
          print(e.toString());
          ToastUtils.show(e.toString());
        }


      }
    }
  }

  ///扫描二维码
  scan()async{
    String scanValue =await Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanPage()));

    toTextEditingController.text=scanValue;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}${S.of(context).g_key_49}"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setWidth(36.0),
                        left: ScreenUtil.getInstance().setWidth(40.0),
                        right: ScreenUtil.getInstance().setWidth(40.0),),
                    child: Form(
                        key: _formKey,
                        child: Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30.0)),
                              margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(30.0)),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness==Brightness.light?Color(0xfffafafa):Color(0xff2b2b2b),
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0))),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(S.of(context).g_key_43,style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(24.0),
                                    color: Theme.of(context).textTheme.headline2!.color,)),
                                  SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                                  getMatchWidget(
                                      '${widget.usableBalance}',
                                      ScreenUtil.getInstance().setWidth(750.0-140.0),
                                      TextStyle(
                                        fontSize: ScreenUtil.getInstance().setSp(40.0),
                                        color: Theme.of(context).textTheme.headline1!.color,
                                        height: 1.5,
                                      ), ScreenUtil.getInstance().setSp(40.0), ScreenUtil.getInstance().setSp(30.0)
                                  ),
                                ],
                              ),
                            ),
                            Text(S.of(context).g_key_38, style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(24.0),
                                color: Theme.of(context).textTheme.headline2!.color)),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                            TextFormField(
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                              controller: toTextEditingController,
                              //initialValue: to,
                              // restorationId: 'salary_field',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  //border: const OutlineInputBorder(),
                                  //labelText: S.of(context).g_key_39,
                                  hintText: S.of(context).g_key_39,
                                  suffixIcon: IconButton(
                                    color:Theme.of(context).iconTheme.color,
                                    icon: Icon(Icons.qr_code_scanner_outlined),
                                    onPressed: () {
                                      scan();
                                    },
                                  )
                              ),
                              maxLines: 1,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return S.of(context).g_key_41;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                to = value!;
                              },
                            ),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(40.0),),
                            Text(S.of(context).g_key_42, style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(24.0),
                                color: Theme.of(context).textTheme.headline2!.color
                            )),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                            TextFormField(
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                              initialValue: toValue,
                              // textInputAction: TextInputAction.next,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  //labelText: S.of(context).g_key_44,
                                  hintText: S.of(context).g_key_44
                              ),
                              maxLines: 1,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return S.of(context).g_key_46;
                                }
                                bool checkValue=Regular.regular_double(value.toString());
                                bool checkValue1=Regular.regular_nums(value.toString());
                                if(checkValue==false && checkValue1==false){
                                  return S.of(context).g_key_134;
                                }else if (double.parse(value!) > widget.usableBalance) {
                                  return S.of(context).g_key_47;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                toValue = value!;
                              },
                            ),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(40.0),),
                            Text(S.of(context).g_key_50, style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(24.0),
                                color: Theme.of(context).textTheme.headline2!.color
                                )),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                            TextFormField(
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                              textAlign: TextAlign.left,
                              initialValue: lockAmount,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                //border: OutlineInputBorder(),
                                //labelText: S.of(context).g_key_51,
                                hintText: S.of(context).g_key_51,
                              ),
                              maxLines: 1,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return S.of(context).g_key_52;
                                }
                                bool checkValue=Regular.regular_double(value.toString());
                                bool checkValue1=Regular.regular_nums(value.toString());
                                if(checkValue==false && checkValue1==false){
                                  return S.of(context).g_key_134;
                                }
                                else {
                                  if (double.parse(value!) > widget.usableBalance) {
                                    return S.of(context).g_key_53;
                                  } else if ( double.parse(value) > double.parse(toValue)) {
                                    return S.of(context).g_key_54;
                                  }
                                }
                                return null;
                              },
                              onSaved: (value) {
                                lockAmount = value!;
                              },
                            ),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(40.0),),
                            Text(S.of(context).g_key_55, style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(24.0),
                                color: Theme.of(context).textTheme.headline2!.color
                                )),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                            TextFormField(
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                              textAlign: TextAlign.left,
                              initialValue: releaseAmount,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                //border: OutlineInputBorder(),
                                //labelText: S.of(context).g_key_56,
                                hintText: S.of(context).g_key_56,
                              ),
                              maxLines: 1,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return S.of(context).g_key_57;
                                }
                                bool checkValue=Regular.regular_double(value.toString());
                                bool checkValue1=Regular.regular_nums(value.toString());
                                if(checkValue==false && checkValue1==false){
                                  return S.of(context).g_key_134;
                                }
                                else {
                                  if (double.parse(value!) > widget.usableBalance) {
                                    return S.of(context).g_key_58;
                                  } else if ( double.parse(value) > double.parse(toValue)) {
                                    return S.of(context).g_key_59;
                                  } else if ( double.parse(value) > double.parse(lockAmount)) {
                                    return S.of(context).g_key_60;
                                  }
                                }
                                return null;
                              },
                              onSaved: (value) {
                                releaseAmount = value!;
                              },
                            ),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(40.0),),
                            // const Text('释放间隔()', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(S.of(context).g_key_61, style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(24.0),
                                    color: Theme.of(context).textTheme.headline2!.color
                                    )),
                                Text(S.of(context).g_key_62,
                                    style: TextStyle(
                                        fontSize: ScreenUtil.getInstance().setSp(20.0),
                                        color: Theme.of(context).textTheme.headline2!.color
                                        )),
                              ],
                            ),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                            TextFormField(
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                              controller: intervalTextEditingController,
                              readOnly: true,
                              textAlign: TextAlign.left,
                              //initialValue: interval.toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                //border: OutlineInputBorder(),
                                //labelText: S.of(context).g_key_63,
                                hintText: S.of(context).g_key_63,
                                suffixIcon: IconButton(
                                  color:Theme.of(context).iconTheme.color,
                                  icon: const Icon(Icons.date_range_outlined),
                                  onPressed: () {
                                    showDialog(context: context, builder: (context){
                                      return Material(
                                        type: MaterialType.transparency,
                                        child: Center(
                                          child:TimerPickerMS(
                                            intervalTimeData,
                                            valueChangeCallBack: (TimeData value){
                                              setState(() {
                                                //showTimerPicker=false;
                                                //intervalTimeData=value;
                                                interval=value.value;
                                                intervalTextEditingController.text=value.value.toString();
                                              });
                                              Navigator.pop(context);
                                            },
                                            closeCallBack: (){
                                              Navigator.pop(context);
                                              /*setState(() {
                                            showTimerPicker=false;
                                          });*/
                                            },
                                          ),
                                        ),
                                      );
                                    });
                                    /*setState(() {
                                      timePickerType=0;
                                      showTimerPicker=true;
                                    });*/
                                  },
                                ),
                              ),
                              maxLines: 1,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return S.of(context).g_key_65;
                                } else {
                                  if (int.parse(value!) <= 600) {
                                    return S.of(context).g_key_66;
                                  }
                                }
                                return null;
                              },
                              onSaved: (value) {
                                interval = int.parse(value!);
                              },
                            ),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(40.0),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(S.of(context).g_key_67, style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(24.0),
                                    color: Theme.of(context).textTheme.headline2!.color
                                )),
                                /*Text(S.of(context).g_key_68, style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(20.0),
                                    color: Theme.of(context).textTheme.headline2!.color,
                                  height: 1.5
                                )),*/
                              ],
                            ),
                            SizedBox(height: ScreenUtil.getInstance().setWidth(10.0),),
                            TextFormField(
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                              controller:startTextEditingController,
                              readOnly:true,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                //border: OutlineInputBorder(),
                                //labelText: S.of(context).g_key_69,
                                hintText: S.of(context).g_key_69,
                                suffixIcon: IconButton(
                                  color:Theme.of(context).iconTheme.color,
                                  icon:Icon(
                                    Icons.date_range_outlined,
                                  ),
                                  onPressed: () {
                                    showDialog(context: context, builder: (context){
                                      return Material(
                                        type: MaterialType.transparency,
                                        child: Center(
                                          child:DatePickerAll(
                                            startDateData,
                                            valueChangeCallBack: (DateData value){
                                              setState(() {
                                                //showTimerPicker=false;
                                                //startDateData=value;
                                                start=value.value;
                                                startTextEditingController.text=dateformat.DateFormat('yyyy-MM-dd HH:mm').format(value.dateTime);
                                              });
                                              Navigator.pop(context);
                                            },
                                            closeCallBack: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      );
                                    });
                                    /*setState(() {
                                      timePickerType=1;
                                      showTimerPicker=true;
                                    });*/
                                  },
                                ),

                              ),
                              maxLines: 1,
                              validator: (value) {
                                //final now = DateTime.now().millisecondsSinceEpoch/1000;
                                if (value != null && value.isEmpty) {
                                  return S.of(context).g_key_71;
                                }
                                /*
                                else {
                                  final date3 = DateTime.parse(value!);
                                  if (date3 == 0) {
                                    return S.of(context).g_key_72;
                                  }
                                  // if (double.parse(value!) < now + 600) {
                                  //   return '释放间隔不能小于10分钟（600秒）';
                                  // }
                                }*/
                                return null;
                              },
                              onSaved: (value) {
                                // start = int.parse(value!);
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: ScreenUtil.getInstance().setWidth(80.0),
                              ),
                              width: double.infinity,
                              height: ScreenUtil.getInstance().setWidth(88.0),
                              child: TextButton(
                                onPressed: (){
                                  _onCheckForm(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                                  shape:MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(88.0))),
                                  )),
                                ),
                                child: Text(
                                  S.of(context).g_key_32,
                                  style: TextStyle(
                                      fontSize: ScreenUtil.getInstance().setSp(32.0),
                                      color: Theme.of(context).textTheme.headline3!.color
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Visibility(
                visible: showLoading,
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: LoadingPage1(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}