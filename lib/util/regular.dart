import 'package:common_utils/common_utils.dart';
class Regular{
  //验证是否是浮点数
  static bool regular_double(String str){
     bool r=RegExp(r'^\d+(\.)?[0-9]').hasMatch(str);
     return r;
  }
  //验证数字
  static bool regular_nums(String str){
    return RegExp(r"^[0-9]+$").hasMatch(str);
  }
  //返回钱的缩写
  static String getMoneyAbbreviation(double money){
    //double r=0;
    String rStr="";
    if(money>=1000000000000){
      String r=NumUtil.getNumByValueDouble(money/1000000000000, 5)!.toString();
      rStr=r.substring(0,r.length-1);
      return rStr+"T";
    }
    if(money>=1000000000){
      String r=NumUtil.getNumByValueDouble(money/1000000000, 5)!.toString();
      rStr=r.substring(0,r.length-1);
      return rStr+"B";
    }
    return money.toString();
  }
}