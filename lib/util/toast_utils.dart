import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ToastUtils{
  static show(String s){
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
        textColor: Color(0xffffffff),
        fontSize: 14.0
    );
  }
}