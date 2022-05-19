import 'package:shared_preferences/shared_preferences.dart';
class SPUtils{
  //app主题模式0系统，1亮，2暗
  static setThemeMode(int value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(SPKey.themeMode, value);
  }
  static getThemeMode()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var r= prefs.get(SPKey.themeMode);
    return r;
  }



  //是否使用测试地址
  static setTestApi(bool value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SPKey.testApi, value);
  }
  static getTestApi()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var r= prefs.get(SPKey.testApi);
    return r;
  }
}
class SPKey{
  static String themeMode="themeMode";//app主题模式0系统，1亮，2暗


  static String testApi="testApi";//是否使用测试地址
}