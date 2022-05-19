import 'package:flutter/material.dart';

class ThemeAdapter{
  //基本色调，亮
  static Color bassColor_light=Color(0xffffffff);
  static Color bassColor_dark=Color(0xff222222);
  static ThemeData themeDataLight=ThemeData.light().copyWith(
    scaffoldBackgroundColor: bassColor_light,//页面主背景色
    cardTheme: CardTheme(
      shadowColor: bassColor_light,
      color: bassColor_light,
    ),
    backgroundColor: bassColor_light,//背景色
    primaryColor: Color(0xffF9f9f9),
    //头部导航样式
    appBarTheme: AppBarTheme(
      backgroundColor: bassColor_light,
      centerTitle:true,
      elevation: 0,//去掉阴影
      titleTextStyle: TextStyle(
        color: Color(0xff222222),
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xff222222),
      ),
      iconTheme: IconThemeData(
        color: Color(0xff222222),
      ),
    ),
    //底部导航样式
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bassColor_light,
      selectedIconTheme: IconThemeData(color: Colors.cyanAccent),
      unselectedIconTheme: IconThemeData(color: Color(0xffffffff)),
      selectedItemColor: Color(0xffFF6F16),
      unselectedItemColor: Color(0xff444444),
    ),
    iconTheme: IconThemeData(color: Color(0xff222222)),

    //cardColor: Color(0xff888888),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Color(0xff888888),//文本框，提示文本颜色
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffFF6F16),
          //width: 1,
          style: BorderStyle.solid,
        ),
      ),
      /*labelStyle: TextStyle(
        color: Color(0xff888888),//文本框，提示文本颜色
      ),*/

      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffc6c6c6),
          //width: 1,
          style: BorderStyle.solid,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffd9445a),
          //width: 1,
          style: BorderStyle.solid,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Color(0xff444444),
      ),
      headline2: TextStyle(
        color: Color(0xffFF6F16),
      ),
      headline3: TextStyle(
        color: Color(0xffffffff),
      ),
      headline4: TextStyle(
        color: Color(0xff44A677),
      ),
      headline5: TextStyle(
        color: Color(0xffd9445a),
      ),
      headline6: TextStyle(
        color: Color(0xff888888),
      ),
      bodyText1: TextStyle(
        color: Color(0xff222222),
      ),
      bodyText2: TextStyle(
        color: Color(0xff666666),
      ),
      subtitle1: TextStyle(
        color: Color(0xfffff3ec),
      ),
    ),
    /*textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: ButtonStyleButton.allOrNull<Color>(Colors.cyanAccent),
      ),
    ),*/
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    ),
    buttonTheme: ButtonThemeData(
        buttonColor: Colors.cyanAccent
    ),
    //进度条样式
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(0xffFF6F16),
      linearTrackColor:Colors.white24,
      //refreshBackgroundColor: Colors.white24,
    ),
    //分割线样式
    dividerTheme:DividerThemeData(
        color: Color(0xffe4e4e4),
        space: 0,
        thickness: 1,
        indent: 10,
        endIndent: 10
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xffFF6F16),
    ),
  );

  static ThemeData themeDataDark=ThemeData.dark().copyWith(
    scaffoldBackgroundColor: bassColor_dark,//页面主背景色
    cardTheme: CardTheme(
      shadowColor: Color(0xff2b2b2b),
      color: Color(0xff2b2b2b),
    ),
    backgroundColor: bassColor_dark,//背景色
    primaryColor: bassColor_dark,
    //头部导航样式
    appBarTheme: AppBarTheme(
      backgroundColor: bassColor_dark,
      centerTitle:true,
      elevation: 0,//去掉阴影
      titleTextStyle: TextStyle(
        color: Color(0xffffffff),
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xffffffff),
      ),
      iconTheme: IconThemeData(
        color: Color(0xffffffff),
      ),
    ),
    //底部导航样式
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bassColor_dark,
      selectedIconTheme: IconThemeData(color: Colors.cyanAccent),
      unselectedIconTheme: IconThemeData(color: Color(0xffffffff)),
      selectedItemColor: Color(0xffFF6F16),
      unselectedItemColor: Color(0xff888888),
    ),
    iconTheme: IconThemeData(color: Color(0xffffffff)),

    //cardColor: Color(0xff888888),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Color(0xff545454),//文本框，提示文本颜色
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffff6f16),
          //width: 1,
          style: BorderStyle.solid,
        ),
      ),
      /*labelStyle: TextStyle(
        color: Color(0xff888888),//文本框，提示文本颜色
      ),*/

      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff545454),
          //width: 1,
          style: BorderStyle.solid,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffd9445a),
          //width: 1,
          style: BorderStyle.solid,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Color(0xffffffff),
      ),
      headline2: TextStyle(
        color: Color(0xffFF6F16),
      ),
      headline3: TextStyle(
        color: Color(0xffffffff),
      ),
      headline4: TextStyle(
        color: Color(0xff44A677),
      ),
      headline5: TextStyle(
        color: Color(0xffd9445a),
      ),
      headline6: TextStyle(
        color: Color(0xff888888),
      ),
      bodyText1: TextStyle(
        color: Color(0xffff6f16)//Color(0xff222222),
      ),
      bodyText2: TextStyle(
        color: Color(0xff666666),
      ),
      subtitle1: TextStyle(
        color: Color(0xfffff3ec),
      ),
    ),
    /*textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: ButtonStyleButton.allOrNull<Color>(Colors.cyanAccent),
      ),
    ),*/
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
    ),
    buttonTheme: ButtonThemeData(
        buttonColor: Colors.cyanAccent
    ),
    //进度条样式
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(0xffFF6F16),
      linearTrackColor:Colors.white24,
      //refreshBackgroundColor: Colors.white24,
    ),
    //分割线样式
    dividerTheme:DividerThemeData(
        color: Color(0xff888888),
        space: 0,
        thickness: 1,
        indent: 10,
        endIndent: 10
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xffFF6F16),
    ),
  );
}