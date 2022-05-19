import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kingloryapp/util/regular.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';

class ProtfolioItem extends StatelessWidget {
  Map<String,dynamic> coin;
  String mainLabel;
  double balance;
  var coinPrice;
  var percentage;
  final oCcy = new NumberFormat("#,##0.0####", "en_US");
  ProtfolioItem(this.coin, this.coinPrice, this.percentage, this.balance, {this.mainLabel="",Key? key}) : super(key: key);

  Widget percentageWidget(BuildContext context, var percentage) {
    if (percentage >= 0) {
      return Text("${percentage.toStringAsFixed(2)}% 24h", style: TextStyle(
        fontSize: ScreenUtil.getInstance().setSp(24.0),
        color: Theme.of(context).textTheme.headline4!.color,
      ));
    } else {
      return Text("${percentage.toStringAsFixed(2)}% 24h", style: TextStyle(
        fontSize: ScreenUtil.getInstance().setSp(24.0),
        color: Theme.of(context).textTheme.headline5!.color,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    String balanceStr="";
    if(balance>=1000000000){
      balanceStr=Regular.getMoneyAbbreviation(balance);
    }else{
      balanceStr=oCcy.format(balance);
    }
    return Container(
      padding: EdgeInsets.only(
        //top: ScreenUtil.getInstance().setWidth(40.0),
        bottom: ScreenUtil.getInstance().setWidth(40.0),
        right: ScreenUtil.getInstance().setWidth(40.0),
        //left: ScreenUtil.getInstance().setWidth(40.0),
      ),
      decoration: BoxDecoration(
          //color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(16.0), )),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*Visibility(
            visible: isERC20,
            child: Container(
            alignment: Alignment.center,
            //padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(42.0)),
            decoration: BoxDecoration(
                color: Theme.of(context).textTheme.headline2!.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenUtil.getInstance().setWidth(16.0)),
                  bottomRight: Radius.circular(ScreenUtil.getInstance().setWidth(16.0)),
                )
            ),
            child: Text('ERC20',style: TextStyle(
              color: Theme.of(context).textTheme.headline3!.color,
              fontSize: ScreenUtil.getInstance().setSp(18.0),
            ),),
            height: ScreenUtil.getInstance().setWidth(34.0),
            width: ScreenUtil.getInstance().setWidth(90.0),
          ),
          ),*/
          Container(
              padding: EdgeInsets.only(
                left: ScreenUtil.getInstance().setWidth(40.0),
                top: ScreenUtil.getInstance().setWidth(40.0),
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(30.0),),
                  child: Image.asset("assets/images/${coin['name_m']}.png",
                    height: ScreenUtil.getInstance().setWidth(66.0),
                    width: ScreenUtil.getInstance().setWidth(66.0),),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(coin['name'], style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(28.0),
                              color: Theme.of(context).textTheme.headline1!.color,
                              fontWeight: FontWeight.bold),),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: coin['isERC20'],
                                  child: Container(
                                    margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(10.0)),
                                    alignment: Alignment.center,
                                    //padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(42.0)),
                                    decoration: BoxDecoration(
                                      //color: Theme.of(context).textTheme.headline2!.color,
                                        border:Border.all(
                                          color: Theme.of(context).textTheme.headline2!.color!,
                                          width: ScreenUtil.getInstance().setWidth(1.0),
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0)),)
                                    ),
                                    child: Text('ERC20',style: TextStyle(
                                      color: Theme.of(context).textTheme.headline2!.color,
                                      fontSize: ScreenUtil.getInstance().setSp(18.0),
                                    ),),
                                    height: ScreenUtil.getInstance().setWidth(34.0),
                                    width: ScreenUtil.getInstance().setWidth(90.0),
                                  ),
                                ),
                                Visibility(
                                  visible: mainLabel!="",
                                  child: Container(
                                    margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(10.0)),
                                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(20.0)),
                                    alignment: Alignment.center,
                                    //padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getInstance().setWidth(42.0)),
                                    decoration: BoxDecoration(
                                      //color: Theme.of(context).textTheme.headline2!.color,
                                        border:Border.all(
                                          color: Theme.of(context).textTheme.headline2!.color!,
                                          width: ScreenUtil.getInstance().setWidth(1.0),
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(16.0)),)
                                    ),
                                    child: Text(mainLabel,style: TextStyle(
                                      color: Theme.of(context).textTheme.headline2!.color,
                                      fontSize: ScreenUtil.getInstance().setSp(18.0),
                                    ),),
                                    height: ScreenUtil.getInstance().setWidth(34.0),
                                    //width: ScreenUtil.getInstance().setWidth(50.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text("\$$coinPrice", style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(28.0),
                              color: Theme.of(context).textTheme.headline1!.color,
                              fontWeight: FontWeight.bold))
                        ],
                      ),
                      //SizedBox(height: ScreenUtil.getInstance().setWidth(16.0),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${balanceStr} ${coin['name']}", style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(24.0),
                            color: Theme.of(context).textTheme.headline6!.color,
                          ),),
                          percentageWidget(context, percentage)
                        ],
                      ),
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}