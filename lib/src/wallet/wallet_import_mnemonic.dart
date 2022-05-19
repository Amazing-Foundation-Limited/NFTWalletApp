
import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/wallet/wallet_gen_name.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:kingloryapp/util/toast_utils.dart';
import 'package:flutter/services.dart';

class WalletImportMnemonic extends StatefulWidget {
  WalletImportMnemonic({Key? key}) : super(key: key);

  @override
  WalletImportMnemonicState createState() => WalletImportMnemonicState();
}

class WalletImportMnemonicState extends State<WalletImportMnemonic> with WidgetsBindingObserver{
  String mnemonic = "";
  List<String> mnemonicList=['','','','','','','','','','','',''];
  final _formKey = GlobalKey<FormState>();
  TextEditingController m1TextEdittingController=TextEditingController();
  TextEditingController m2TextEdittingController=TextEditingController();
  TextEditingController m3TextEdittingController=TextEditingController();
  TextEditingController m4TextEdittingController=TextEditingController();
  TextEditingController m5TextEdittingController=TextEditingController();
  TextEditingController m6TextEdittingController=TextEditingController();
  TextEditingController m7TextEdittingController=TextEditingController();
  TextEditingController m8TextEdittingController=TextEditingController();
  TextEditingController m9TextEdittingController=TextEditingController();
  TextEditingController m10TextEdittingController=TextEditingController();
  TextEditingController m11TextEdittingController=TextEditingController();
  TextEditingController m12TextEdittingController=TextEditingController();

  FocusScopeNode _focusScopeNode = FocusScopeNode();
  FocusNode m1FocusNode=FocusNode();
  FocusNode m2FocusNode=FocusNode();
  FocusNode m3FocusNode=FocusNode();
  FocusNode m4FocusNode=FocusNode();
  FocusNode m5FocusNode=FocusNode();
  FocusNode m6FocusNode=FocusNode();
  FocusNode m7FocusNode=FocusNode();
  FocusNode m8FocusNode=FocusNode();
  FocusNode m9FocusNode=FocusNode();
  FocusNode m10FocusNode=FocusNode();
  FocusNode m11FocusNode=FocusNode();
  FocusNode m12FocusNode=FocusNode();
  List<TextEditingController> controllerList=[];
  List<FocusNode> focusList=[];
  @override
  void initState() {
    _checkClipboard();
    // TODO: implement initState
    controllerList=[m1TextEdittingController,
    m2TextEdittingController,
    m3TextEdittingController,
    m4TextEdittingController,
    m5TextEdittingController,
    m6TextEdittingController,
    m7TextEdittingController,
    m8TextEdittingController,
    m9TextEdittingController,
    m10TextEdittingController,
    m11TextEdittingController,
    m12TextEdittingController];
    focusList=[
      m1FocusNode,
      m2FocusNode,
      m3FocusNode,
      m4FocusNode,
      m5FocusNode,
      m6FocusNode,
      m7FocusNode,
      m8FocusNode,
      m9FocusNode,
      m10FocusNode,
      m11FocusNode,
      m12FocusNode
    ];
    m1FocusNode.addListener(() {
      setState(() {
      });
    });
    m2FocusNode.addListener(() {
      setState(() {
      });
    });
    m3FocusNode.addListener(() {
      setState(() {
      });
    });
    m4FocusNode.addListener(() {
      setState(() {
      });
    });
    m5FocusNode.addListener(() {
      setState(() {
      });
    });
    m6FocusNode.addListener(() {
      setState(() {
      });
    });
    m7FocusNode.addListener(() {
      setState(() {
      });
    });
    m8FocusNode.addListener(() {
      setState(() {
      });
    });
    m9FocusNode.addListener(() {
      setState(() {
      });
    });
    m10FocusNode.addListener(() {
      setState(() {
      });
    });
    m11FocusNode.addListener(() {
      setState(() {
      });
    });
    m12FocusNode.addListener(() {
      setState(() {
      });
    });
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controllerList=[];
    focusList=[];
    m1TextEdittingController.dispose();
    m2TextEdittingController.dispose();
    m3TextEdittingController.dispose();
    m4TextEdittingController.dispose();
    m5TextEdittingController.dispose();
    m6TextEdittingController.dispose();
    m7TextEdittingController.dispose();
    m8TextEdittingController.dispose();
    m9TextEdittingController.dispose();
    m10TextEdittingController.dispose();
    m11TextEdittingController.dispose();
    m12TextEdittingController.dispose();

    m1FocusNode.dispose();
    m2FocusNode.dispose();
    m3FocusNode.dispose();
    m4FocusNode.dispose();
    m5FocusNode.dispose();
    m6FocusNode.dispose();
    m7FocusNode.dispose();
    m8FocusNode.dispose();
    m9FocusNode.dispose();
    m10FocusNode.dispose();
    m11FocusNode.dispose();
    m12FocusNode.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  _checkClipboard()async{
    ClipboardData? cd=await Clipboard.getData('text/plain');
    Clipboard.setData(ClipboardData(text: ''));
    if(cd!=null){
      String? mCD=cd.text;
      if(mCD==null)return;

      mCD=mCD.trim();
      if(mCD==mnemonic){
        return;
      }
      List<String> mCDList=mCD.split(' ');
      if(mCDList.length==12){
        mnemonicList=mCDList;
        mnemonic=mCD;
        _setTextFieldValue();
        ToastUtils.show(S.of(context).g_key_123);
      }
    }
  }
  _setTextFieldValue(){
    int i=0;
    for(int i=0;i<controllerList.length;i++){
      controllerList[i].text=mnemonicList[i];
    }
    /*
    for(TextEditingController tec in controllerList){
      tec.text=mnemonicList[i];
      i++;
    }*/
  }
  void _onSaveName(context) {
    _focusScopeNode = FocusScope.of(context);
    if(m1TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('01'));
      _focusScopeNode.requestFocus(focusList[0]);
      return ;
    }
    if(m2TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('02'));
      _focusScopeNode.requestFocus(focusList[1]);
      return ;
    }
    if(m3TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('03'));
      _focusScopeNode.requestFocus(focusList[2]);
      return ;
    }
    if(m4TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('04'));
      _focusScopeNode.requestFocus(focusList[3]);
      return ;
    }
    if(m5TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('05'));
      _focusScopeNode.requestFocus(focusList[4]);
      return ;
    }
    if(m6TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('06'));
      _focusScopeNode.requestFocus(focusList[5]);
      return ;
    }
    if(m7TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('07'));
      _focusScopeNode.requestFocus(focusList[6]);
      return ;
    }
    if(m8TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('08'));
      _focusScopeNode.requestFocus(focusList[7]);
      return ;
    }
    if(m9TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('09'));
      _focusScopeNode.requestFocus(focusList[8]);
      return ;
    }
    if(m10TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('10'));
      _focusScopeNode.requestFocus(focusList[9]);
      return ;
    }
    if(m11TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121('11'));
      _focusScopeNode.requestFocus(focusList[10]);
      return ;
    }
    if(m12TextEdittingController.text==""){
      ToastUtils.show(S.of(context).g_key_121("12"));
      _focusScopeNode.requestFocus(focusList[11]);
      return ;
    }
    for(int i=0;i<controllerList.length;i++){
      mnemonicList[i]=controllerList[i].text;
    }
    _onGenMnemonic(context);
    /*
    var _state = _formKey.currentState;
    if (_state != null && _state.validate()) {
      _state.save();
      _onGenMnemonic(context);
    }*/
  }
  @override
  Widget build(BuildContext context) {
    return _newWidget();
  }

  _newWidget(){
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).g_key_6),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(30.0)),
                height: ScreenUtil.getInstance().setWidth(1000.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).g_key_12, style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(40.0),
                        color: Theme.of(context).textTheme.bodyText1!.color)),
                    Text('(${S.of(context).g_key_122})', style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(28.0),
                        color: Theme.of(context).textTheme.bodyText1!.color)),
                    SizedBox(height: ScreenUtil.getInstance().setSp(30.0),),
                    Expanded(child: Form(
                      key: _formKey,
                      child:GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 1.4,
                        crossAxisSpacing: ScreenUtil.getInstance().setWidth(26.0),
                        children: List.generate(12, (index) {
                          String num="";
                          if(index+1<10){
                            num='0${index+1}';
                          }
                          else{
                            num='${index+1}';
                          }
                          return Container(
                            /*constraints: BoxConstraints(
                            minHeight: ScreenUtil.getInstance().setWidth(72.0),
                            minWidth: double.infinity,
                          ),*/
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil.getInstance().setWidth(30.0),
                              //horizontal: ScreenUtil.getInstance().setWidth(5.0),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline1!.color,
                                //height: 1,
                              ),
                              controller: controllerList[index],
                              focusNode: focusList[index],
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil.getInstance().setWidth(10.0),
                                  vertical: ScreenUtil.getInstance().setWidth(20.0),
                                ),
                                isDense: true,
                                filled: Theme.of(context).brightness==Brightness.dark,
                                fillColor: Color(0xff2b2b2b),
                                prefixIcon: Text(" "+num+" ",style: TextStyle(
                                    color: Theme.of(context).textTheme.headline2!.color,
                                    fontSize: ScreenUtil.getInstance().setSp(32.0),
                                    fontWeight: FontWeight.bold
                                ),),
                                prefixIconConstraints: BoxConstraints(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffff6f16),
                                    //width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(50.0))),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).brightness==Brightness.light? Color(0xffcccccc):Color(0xff2b2b2b),
                                    //width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(50.0))),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).brightness==Brightness.light? Color(0xffcccccc):Color(0xff2b2b2b),
                                    //width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(50.0))),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffd9445a),
                                    //width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(50.0))),
                                ),
                              ),
                              maxLines: 1,
                              onSaved: (value) {
                                mnemonicList[index] = value.toString().trim().replaceAll(' ', '');
                              },
                              onEditingComplete: (){
                                _focusScopeNode = FocusScope.of(context);
                                int i=index+1;
                                if(i==12){
                                  i=0;
                                }
                                _focusScopeNode.requestFocus(focusList[i]);
                              },
                            ),
                          );
                        }),
                      ),
                    ),),
                  ],
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
                  _onSaveName(context);
                },
                style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                  shape:MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(88.0))),
                  )),
                ),
                child: Text(
                  S.of(context).g_key_16,
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
  _oldWidget(){
    return Scaffold (
      appBar: AppBar(
        title: Text(S.of(context).g_key_6),
      ),
      body: Center(
        child: Container(
          height: ScreenUtil.getInstance().setWidth(900),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(70.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).g_key_12, style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(60.0),
                  color: Theme.of(context).textTheme.bodyText1!.color)),
              SizedBox(height: ScreenUtil.getInstance().setWidth(120),),
              Text(S.of(context).g_key_13, style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                  color: Theme.of(context).textTheme.headline2!.color)),
              Form(
                key: _formKey,
                child: TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                  initialValue: mnemonic,
                  // textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    hintText: S.of(context).g_key_12,
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value != null && value.isEmpty ) {
                      return S.of(context).g_key_14;
                    } else if (value != null) {
                      if (!bip39.validateMnemonic(value)) {
                        return S.of(context).g_key_15;
                      }
                    }

                    return null;
                  },
                  onSaved: (value) {
                    mnemonic = value!;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setWidth(300.0),
                ),
                width: double.infinity,
                height: ScreenUtil.getInstance().setWidth(88.0),
                child: TextButton(
                  onPressed: (){
                    _onSaveName(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                    shape:MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(88.0))),
                    )),
                  ),
                  child: Text(
                    S.of(context).g_key_16,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(32.0),
                        color: Theme.of(context).textTheme.headline3!.color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      /*Column (
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child:  Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: ScreenUtil.getInstance().setWidth(36.0),
                  spacing: ScreenUtil.getInstance().setWidth(18.0),
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(64.0),
                        ),
                        children: [
                          TextSpan(
                            text: S.of(context).g_key_12,
                          )
                        ],
                      ),
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints(
                            // maxHeight: 400,
                            maxWidth: ScreenUtil.getInstance().setWidth(630.0),
                        ),
                      child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: mnemonic,
                        // textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(24.0),),
                          ),
                          labelText: S.of(context).g_key_13,
                            labelStyle: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(34.0),
                                fontWeight: FontWeight.bold)
                        ),
                        maxLines: 10,
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(44.0),
                            fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        validator: (value) {
                          if (value != null && value.isEmpty ) {
                            return S.of(context).g_key_14;
                          } else if (value != null) {
                             if (!bip39.validateMnemonic(value)) {
                               return S.of(context).g_key_15;
                             }
                          }

                          return null;
                        },
                        onSaved: (value) {
                          mnemonic = value!;
                        },
                      ),
                    ),
                    ),
                  ],),
              ),
            ),
            Expanded(
                flex: 1,
                child: Wrap(
                    children: [
                      Container(
                        // height: 45.0,
                        width: ScreenUtil.getInstance().setWidth(460.0),
                        child:  FloatingActionButton.extended(
                          onPressed: () => _onSaveName(context),
                          label: Text(S.of(context).g_key_16, style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(32.0),)),
                        ),
                      ),
                    ]
                )),
          ],
        )*/
    );
  }
  _onGenMnemonic(context) {
    mnemonic="";
    for(String m in mnemonicList){
      mnemonic+=m+' ';
    }
    mnemonic=mnemonic.trimRight();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WalletGenName(mnemonic: mnemonic,);
    }));
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if(state==AppLifecycleState.resumed){
      _checkClipboard();
    }
    super.didChangeAppLifecycleState(state);
  }

}