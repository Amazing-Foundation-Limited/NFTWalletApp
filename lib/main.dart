import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/component/enum/load.dart';
import 'package:kingloryapp/src/event/swich_theme_mode.dart';
import 'package:kingloryapp/src/http/network_api.dart';
import 'package:kingloryapp/src/markets/markets_new.dart';
import 'package:kingloryapp/src/setting/setService.dart';
import 'package:kingloryapp/src/setting/settting.dart';
import 'package:kingloryapp/src/state/cc_transaction_provider.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/markets_provider.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/src/transaction/transaction.dart';
import 'package:kingloryapp/src/wallet/wallet.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:kingloryapp/util/sp_utils.dart';
import 'package:kingloryapp/util/theme_adapter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kingloryapp/util/event_bus.dart';

import 'eth/eth.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/web3dart.dart';

import 'kinglory/kgc.dart';


void main(){
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketsProvider>(create: (_) => MarketsProvider(),),
        ChangeNotifierProvider<CoinsProvider>(create: (_) => CoinsProvider(),),
        ChangeNotifierProvider<WalletsProviderDefault>(create: (_) => WalletsProviderDefault(),),
        ChangeNotifierProvider<CCTransactionProvider>(create: (_)=>CCTransactionProvider(),),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget{
  @override
  _MyAppState createState()=>_MyAppState();
}
class _MyAppState extends State<MyApp>{
  Locale _locale=Locale.fromSubtags(languageCode: 'en');
  Load _load=Load.loading;
  ThemeMode themeMode=ThemeMode.system;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听主题切换
    eventBus.on<SwichThemeMode>().listen((event) {
      if(event.themeModeType==1){
        if(themeMode==ThemeMode.light)return;
        switchTheme(1);
      }if(event.themeModeType==2){
        if(themeMode==ThemeMode.dark)return;
        switchTheme(2);
      }else{
        if(themeMode==ThemeMode.system)return;
        switchTheme(0);
      }
    });
    _setBaseUrl();
    _getThemeModeType();
    _init();
    //_switchLocale('zh');
  }
  //切换系统语言
  _switchLocale(String code){
    if(code=='zh'){
      _locale=Locale('zh');
    }else{
      _locale=Locale('en');
    }
    setState(() {});
  }
  switchTheme(int type){
    if(type==0){
      //系统默认
      themeMode=ThemeMode.system;
      SPUtils.setThemeMode(0);
    }else if(type==1){
      //亮色
      themeMode=ThemeMode.light;
      SPUtils.setThemeMode(1);
    }else if(type==2){
      //暗色
      themeMode=ThemeMode.dark;
      SPUtils.setThemeMode(2);
    }
    setState(() {
    });
  }
  _getThemeModeType()async{
    var themeModeT=await SPUtils.getThemeMode();
    if(themeModeT==null){
      themeModeT=0;
      SPUtils.setThemeMode(0);
    }
    switchTheme(themeModeT);
  }
  //设置api接口地址，是使用测试地址，还是正式地址
  _setBaseUrl()async{
    var isTestApi=await SPUtils.getTestApi();
    if(isTestApi==null){
      isTestApi=true;
    }
    Api.reSetBaseUrl(isTestApi);
    useTestAddress=isTestApi;
  }
  Future<void> _init() async {
    await _setServerConfig();
    final defaultWallet = await WalletDatabaseProvider.dbProvider.getAllWallet();
    final address=await WalletDatabaseProvider.dbProvider.getAddressDefault();
    if (defaultWallet != null) {
      await Provider.of<WalletsProviderDefault>(context, listen: false).init(defaultWallet,address);
    } else {
      print("无默认钱包");
      /*
      bool isLoadWallet=WalletDatabaseProvider.dbProvider.loadOldData();
      if(isLoadWallet){
        WalletDb? defaultWallet = await WalletDatabaseProvider.dbProvider.getAllWallet();
        AddressDb? addInfo=await WalletDatabaseProvider.dbProvider.getAddressDefault();
        await Provider.of<WalletsProviderDefault>(context, listen: false).init(
            WalletDb(
                name: defaultWallet!.name,
                password: defaultWallet!.password,
                mnemonic: defaultWallet!.mnemonic
            ),addInfo);
      }*/
    }
    Provider.of<CoinsProvider>(context, listen: false).walletsProviderDefault=Provider.of<WalletsProviderDefault>(context, listen: false);
    Provider.of<CCTransactionProvider>(context, listen: false).walletsProviderDefault=Provider.of<WalletsProviderDefault>(context, listen: false);
    await Provider.of<CoinsProvider>(context, listen: false).initCoinsProvider();
    Provider.of<CCTransactionProvider>(context, listen: false).getNotDoneValue();
    Timer(Duration(seconds: 2),(){
      setState(() {
        _load=Load.finish;
      });
    });
    //每30秒检查一遍是否有未完成的跨链交易
    Timer timer;
    Timer.periodic(Duration(seconds: 30),(timer){
      Provider.of<CCTransactionProvider>(context, listen: false).getNotDoneValue();
    });
  }
  //设置服务地址配置
  _setServerConfig()async{
    ServiceModel? sm= await WalletDatabaseProvider.dbProvider.getServiceConfig();
    if(sm!=null){
      ETHMainnetWs =sm.ethMainnetWs;
      ETHMainnetRpc =sm.ethMainnerRpc;
      ETHRinkebyWs =sm.ethTextnetWs;
      ETHRinkebyChainID = sm.ethMainnetChainID;
      ETHRopstenRpc =sm.ethTextnetRpc;
      ETHRopstenWs =sm.ethTextnetWs;
      ETHRopstenChainID = sm.ethTextnetChainID;

      BSCMainnetRpc = sm.bnbMainnerRpc;
      BSCMainnetWs = sm.bnbMainnetWs;
      BSCMainnetChainID = sm.bnbMainnetChainID;
      BSCTestnetRpc = sm.bnbTextnetRpc;
      BSCTestnetWs = sm.bnbTextnetWs;
      BSCTestnetChainID = sm.bnbTextnetChainID;

      mETHTestnetAddr=sm.eth_eTestnetAddr;//合约地址
      mBNBTestnetAddr=sm.bnb_eTestnetAddr;//合约地址
      mtkErc20TestnetAddr=sm.mtk_eTestnetAddr;

      //MTK
      MTKMainnetWs = sm.mtkMainnetWs;
      MTKMainnetRpc = sm.mtkMainnerRpc;
      MTKMainnetChainID = sm.mtkMainnetChainID;
      MTKTestnetRpc =sm.mtkTextnetRpc;
      MTKTestnetWs =sm.mtkTextnetWs;
      MTKTestnetChainID = sm.mtkTextnetChainID;

      MTKAddress=sm.mtkAddress;
      ETHAddress=sm.ethAddress;
      BNBAddress=sm.bnbAddress;
    }
  }
  checkThemeMode()async{
    int themeModeType=await SPUtils.getThemeMode();
    if(themeMode==null){
      themeModeType=0;
    }
    switchTheme(themeModeType);
  }
  Widget _widgetPage() {
    if (_load == Load.loading) {
      /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor:Color(0xffffffff),
          statusBarColor:Color(0xffffffff)),);*/
      //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack,overlays:[SystemUiOverlay.top]);
      //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor:Color(0xff232323),
            //statusBarColor:Color(0xff232323)
        ),
        child: Scaffold(
          appBar: null,
          backgroundColor: Color(0xff232323),
          body: Container(
            width: double.infinity,
            color: Color(0xff232323),
            child: Image.asset('assets/img/splash_bg.png',
              width: double.infinity,
            ),
          ),
        ),
      );
    } else {
      return App();
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      themeMode: themeMode,
      theme: ThemeAdapter.themeDataLight,
      darkTheme: ThemeAdapter.themeDataDark,
      builder: EasyLoading.init(),
      title: 'Kinglory',
      home:_widgetPage(),
    );
  }
}
class App extends StatefulWidget {
  final pages = [
    MarketsWidget(),
    WalletWidget(),
    TransactionWidget(),
    SettingWidget(),
  ];

  App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  var _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    //_init();
  }

  Future<void> _init() async {
    Timer(Duration(seconds: 1),(){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor:Theme.of(context).backgroundColor,
          statusBarColor:Theme.of(context).backgroundColor),);
    });

    /*
    final defaultWallet = await WalletDatabaseProvider.dbProvider.getDefaultWallet();
    if (defaultWallet != null) {
      await Provider.of<WalletsProviderDefault>(context, listen: false).init(defaultWallet);
    } else {
      print("无默认钱包");
    }
    await Provider.of<CoinsProvider>(context, listen: false).initCoinsProvider();

     */
  }

  Widget _buildBottomItem(String title,int curIndex,int index,String imagePath){
    double width=MediaQuery.of(context).size.width/4;
    return InkWell(
      onTap: (){
        setState(() {
          _selectedIndex=index;
        });
      },
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
                curIndex==index?imagePath+'-a.png':imagePath+'.png',
                width: ScreenUtil.getInstance().setWidth(40.0)
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(24.0),
                  height: 1.5,
                  color: curIndex==index?Theme.of(context).bottomNavigationBarTheme.selectedItemColor:Theme.of(context).bottomNavigationBarTheme.unselectedItemColor
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil()..init(context); //屏幕尺寸适配
    //判断是否是明亮主题,暗色主题icon名字后面+'-n'
    String icon_light=Theme.of(context).brightness==Brightness.light?'':'-n';

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        systemNavigationBarColor:Theme.of(context).backgroundColor,
        //statusBarColor:Color(0xffffffff)
        ),
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          child: Container(
            height: ScreenUtil.getInstance().setWidth(100.0),
            decoration: BoxDecoration(
              border: Border(top:BorderSide(width: 0.5,
                  color: Theme.of(context).brightness==Brightness.light?Colors.transparent:Color(0xff4b4b4b))),
                color: Theme.of(context).backgroundColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBottomItem(S.of(context).g_key_0,_selectedIndex,0,"assets/img/Markets${icon_light}"),
                _buildBottomItem(S.of(context).g_key_6,_selectedIndex,1,"assets/img/Wallet${icon_light}"),
                _buildBottomItem(S.of(context).g_key_93,_selectedIndex,2,"assets/img/Ttansfer${icon_light}"),
                _buildBottomItem(S.of(context).g_key_94,_selectedIndex,3,"assets/img/Setting${icon_light}"),
              ],
            ),
          ),
        ),


        /*BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.blueGrey,
        items: [
          _buildBottomItem(S.of(context).g_key_0,_selectedIndex,0,"assets/img/Markets"),
          _buildBottomItem(S.of(context).g_key_0,_selectedIndex,1,"assets/img/Wallet"),
          _buildBottomItem(S.of(context).g_key_0,_selectedIndex,2,"assets/img/Ttansfer"),
          _buildBottomItem(S.of(context).g_key_0,_selectedIndex,3,"assets/img/Setting"),
          BottomNavigationBarItem(
              icon: Icon(Icons.auto_stories), label: 'Markets'),
          /*BottomNavigationBarItem(
              icon: Icon(Icons.wallet_travel_sharp), label: 'Wallet'),
          BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows_sharp), label: 'Transfer'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_sharp), label: 'Setting'),*/
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),*/
        body: IndexedStack(
          index: _selectedIndex,
          children: widget.pages,
        ),
      ),
    );

  }
}

/**
 * _testContract() async {
    // String mnemonic = "purchase camera loyal orient sausage pet grace like ancient vanish caution barely";//bip39.generateMnemonic();
    // Map<String, dynamic> info = {"service":ETHRopstenRpc, "chainId":ETHRopstenChainID, "contract":"0x502fBA0dcb132d3a5E93040b84c26823Bfd653C0"};
    // final kgc = KGCProvider(kgcInfo: info);
    // await kgc.init(mnemonic, "m/44'/60'/0'/0/0", "123", chainId:ETHRopstenChainID);
    // var b = await kgc.balance();
    // final name = await kgc.getName();
    // final symbol = await kgc.getSymbol();
    // final decimals = await kgc.getDecimals();
    // final total = await kgc.getTotalSupply();
    // final owner = await kgc.getOwner();
    }
 */