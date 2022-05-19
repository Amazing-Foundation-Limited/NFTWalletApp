import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/src/wallet/wallet_protfolio_item.dart';
import 'package:intl/intl.dart';
import 'package:kingloryapp/src/wallet/wallet_receive_qr.dart';
import 'package:kingloryapp/src/wallet/wallet_send_tx_erc20.dart';
import 'package:kingloryapp/src/wallet/wallet_send_tx_erc20_kgc.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class PortfolioKgcScreen extends StatefulWidget {
  CoinModel coinModel;
  PortfolioKgcScreen(this.coinModel,
      {Key? key})
      : super(key: key);

  @override
  PortfolioKgcScreenState createState() => PortfolioKgcScreenState();
}

class PortfolioKgcScreenState extends State<PortfolioKgcScreen> {
  bool send = false;
  bool isOwner = false;
  //BigInt lockupBalance = BigInt.from(0);
  //BigInt releaseBalance = BigInt.from(0);
  //BigInt totalBalance = BigInt.from(0);
  final oCcy = new NumberFormat("#,##0.0####", "en_US");
  //late EthereumAddress addr;
  //bool isok = false;

  _changeWidget(BuildContext context) {
    setState(() {
      if (send) {
        send = false;
      } else {
        send = true;
      }
    });
  }

  _goReceive() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ReceiveQr(addr: widget.coinModel.address);
      },
      // fullscreenDialog: true
    ));
  }

  void _openSendTxDialog() {
    double usableBalance = toEther(
        EtherAmount.inWei(widget.coinModel.balance - widget.coinModel.lockupBalance).getInWei.toString());
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SendTransactionErc20(
          name: widget.coinModel.coin['name'],
          usableBalance: usableBalance,
        );
      },
      // fullscreenDialog: true
    ));
  }

  void _openLockTxDialog() {
    double usableBalance = toEther(
        EtherAmount.inWei(widget.coinModel.balance - widget.coinModel.lockupBalance).getInWei.toString());
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SendTransactionKgc(
          name: widget.coinModel.coin['name'],
          usableBalance: usableBalance,
        );
      },
      // fullscreenDialog: true
    ));
  }
/*
  _getLockupBalance() async {

    KGCProvider? kgcPro ;
    if(widget.coin['name_k']=='MTK_E'){
      kgcPro=Provider.of<WalletsProviderDefault>(context, listen: false).mtk_eCoin();
    }else if(widget.coin['name_k']=='ETH_E'){
      kgcPro=Provider.of<WalletsProviderDefault>(context, listen: false).eth_eCoin();
    }else if(widget.coin['name_k']=='BNB_E'){
      kgcPro=Provider.of<WalletsProviderDefault>(context, listen: false).bnb_eCoin();
    }

    print('${widget.coin['name_k']}:kgcPro:${kgcPro}');
    final lock = await kgcPro!.getLockupBalance();
    print('${widget.coin['name_k']}:lock:${lock}');
    final release = await kgcPro.getReleaseAmount();
    print('${widget.coin['name_k']}:release:${release}');
    final balance = await kgcPro.getBalance();
    print('${widget.coin['name_k']}:balance:${balance}');
    final owner = await kgcPro.getOwner();
    print('${widget.coin['name_k']}:owner:${owner}');
    final address = await kgcPro.address;
    print('${widget.coin['name_k']}:address:${address}');
    if (this.mounted) {
      setState(() {
        lockupBalance = lock;
        if (lockupBalance == BigInt.from(0)) {
          releaseBalance = BigInt.from(0);
        } else {
          releaseBalance = release;
        }
        totalBalance = balance;
        addr = address;
        if (owner == kgcPro!.address) {
          isOwner = true;
        } else {
          isOwner = false;
        }
        isok = true;
      });
    }
  }
*/
  @override
  void initState() {
    super.initState();
    if (widget.coinModel.owner == widget.coinModel.address) {
      isOwner = true;
    } else {
      isOwner = false;
    }
    //_getLockupBalance();
  }

  @override
  Widget build(BuildContext context) {
    if (!send) {
      return Card(
          elevation: 0.0,
          child: InkWell(
              onTap: () => _changeWidget(context),
              child: Column(
                children: [
                  ProtfolioItem(
                    widget.coinModel.coin,
                    widget.coinModel.coinPrice,
                    widget.coinModel.percentage,
                      toEther(
                          EtherAmount.inWei(widget.coinModel.balance).getInWei.toString()),
                    mainLabel: widget.coinModel.coin['changeIndex'],
                  ),
                  Divider(
                    height: ScreenUtil.getInstance().setWidth(2.0),
                    indent: ScreenUtil.getInstance().setWidth(40.0),
                    endIndent: ScreenUtil.getInstance().setWidth(40.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(54.0),
                      top: ScreenUtil.getInstance().setWidth(30.0),
                      bottom: ScreenUtil.getInstance().setWidth(30.0),
                    ), //only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            bottom: ScreenUtil.getInstance().setWidth(12.0),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10.0),),
                                child: Image.asset('assets/img/suo.png',
                                  width:ScreenUtil.getInstance().setWidth(30.0),
                                  height:ScreenUtil.getInstance().setWidth(30.0),
                                ),
                              ),
                              Text(
                                  "${S.of(context).g_key_30}:${oCcy.format(toEther(EtherAmount.inWei(widget.coinModel.lockupBalance).getInWei.toString()))}",
                                  style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(26.0),
                                    color: Theme.of(context).textTheme.headline2!.color,
                                  ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            bottom: ScreenUtil.getInstance().setWidth(12.0),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10.0),),
                                child: Image.asset('assets/img/lianjie.png',
                                  width:ScreenUtil.getInstance().setWidth(30.0),
                                  height:ScreenUtil.getInstance().setWidth(30.0),
                                ),
                              ),
                              Text(
                                  "${S.of(context).g_key_31}:${oCcy.format(toEther(EtherAmount.inWei(widget.coinModel.releaseBalance).getInWei.toString()))}",
                                  style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(26.0),
                                    color: Theme.of(context).textTheme.headline2!.color,
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )));
    } else if (!isOwner) {
      return Card(
          elevation: 0.0,
          child: InkWell(
              onTap: () => _changeWidget(context),
              child: Column(
                children: [
                  ProtfolioItem(
                    widget.coinModel.coin,
                    widget.coinModel.coinPrice,
                    widget.coinModel.percentage,
                      toEther(
                          EtherAmount.inWei(widget.coinModel.balance).getInWei.toString()),
                    mainLabel: widget.coinModel.coin['changeIndex'],
                  ),
                  Divider(
                    height: ScreenUtil.getInstance().setWidth(2.0),
                    indent: ScreenUtil.getInstance().setWidth(40.0),
                    endIndent: ScreenUtil.getInstance().setWidth(40.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(54.0),
                      top: ScreenUtil.getInstance().setWidth(30.0),
                      bottom: ScreenUtil.getInstance().setWidth(30.0),
                    ), //only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            bottom: ScreenUtil.getInstance().setWidth(12.0),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10.0),),
                                child: Image.asset('assets/img/suo.png',
                                  width:ScreenUtil.getInstance().setWidth(30.0),
                                  height:ScreenUtil.getInstance().setWidth(30.0),
                                ),
                              ),
                              Text(
                                "${S.of(context).g_key_30}:${oCcy.format(toEther(EtherAmount.inWei(widget.coinModel.lockupBalance).getInWei.toString()))}",
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  color: Theme.of(context).textTheme.headline2!.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            bottom: ScreenUtil.getInstance().setWidth(12.0),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10.0),),
                                child: Image.asset('assets/img/lianjie.png',
                                  width:ScreenUtil.getInstance().setWidth(30.0),
                                  height:ScreenUtil.getInstance().setWidth(30.0),
                                ),
                              ),
                              Text(
                                "${S.of(context).g_key_31}:${oCcy.format(toEther(EtherAmount.inWei(widget.coinModel.releaseBalance).getInWei.toString()))}",
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  color: Theme.of(context).textTheme.headline2!.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(40.0),
                      right: ScreenUtil.getInstance().setWidth(40.0),
                      bottom: ScreenUtil.getInstance().setWidth(35.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: (){
                              _openSendTxDialog();
                            },
                            style: ButtonStyle(
                              backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.subtitle1!.color),
                              shape:MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(66.0))),
                              )),
                            ),
                            child: Text(
                              S.of(context).g_key_100,
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  color: Theme.of(context).textTheme.headline2!.color
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtil.getInstance().setWidth(20.0)),
                        Expanded(
                          flex: 1,
                          child:TextButton(
                            onPressed: (){
                              _goReceive();
                            },
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                BorderSide(
                                    color: Theme.of(context).textTheme.headline2!.color!,
                                    width: ScreenUtil.getInstance().setSp(1.0)),
                              ),
                              shape:MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(66.0))),
                              )),
                            ),
                            child: Text(
                              S.of(context).g_key_33,
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  color: Theme.of(context).textTheme.headline2!.color
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.orangeAccent)),
                          child: Text(S.of(context).g_key_32,
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54)),
                          onPressed: () {
                            _openSendTxDialog();
                          },
                        ),
                      ),
                      SizedBox(width: ScreenUtil.getInstance().setWidth(36.0),),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          child: Text(S.of(context).g_key_33,
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54)),
                          onPressed: () => _goReceive(),
                        ),
                      )
                    ],
                  )*/
                ],
              )));
    } else {
      return Card(
          elevation: 0.0,
          child: InkWell(
              onTap: () => _changeWidget(context),
              child: Column(
                children: [
                  ProtfolioItem(
                    widget.coinModel.coin,
                    widget.coinModel.coinPrice,
                    widget.coinModel.percentage,
                      toEther(
                          EtherAmount.inWei(widget.coinModel.balance).getInWei.toString()),
                    mainLabel: widget.coinModel.coin['changeIndex'],
                  ),
                  Divider(
                    height: ScreenUtil.getInstance().setWidth(2.0),
                    indent: ScreenUtil.getInstance().setWidth(40.0),
                    endIndent: ScreenUtil.getInstance().setWidth(40.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(54.0),
                      top: ScreenUtil.getInstance().setWidth(30.0),
                      bottom: ScreenUtil.getInstance().setWidth(30.0),
                    ), //only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            bottom: ScreenUtil.getInstance().setWidth(12.0),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10.0),),
                                child: Image.asset('assets/img/suo.png',
                                  width:ScreenUtil.getInstance().setWidth(30.0),
                                  height:ScreenUtil.getInstance().setWidth(30.0),
                                ),
                              ),
                              Text(
                                "${S.of(context).g_key_30}:${oCcy.format(toEther(EtherAmount.inWei(widget.coinModel.lockupBalance).getInWei.toString()))}",
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  color: Theme.of(context).textTheme.headline2!.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            bottom: ScreenUtil.getInstance().setWidth(12.0),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(10.0),),
                                child: Image.asset('assets/img/lianjie.png',
                                  width:ScreenUtil.getInstance().setWidth(30.0),
                                  height:ScreenUtil.getInstance().setWidth(30.0),
                                ),
                              ),
                              Text(
                                "${S.of(context).g_key_31}:${oCcy.format(toEther(EtherAmount.inWei(widget.coinModel.releaseBalance).getInWei.toString()))}",
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  color: Theme.of(context).textTheme.headline2!.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(40.0),
                      right: ScreenUtil.getInstance().setWidth(40.0),
                      bottom: ScreenUtil.getInstance().setWidth(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: (){
                              _openSendTxDialog();
                            },
                            style: ButtonStyle(
                              backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.subtitle1!.color),
                              shape:MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(66.0))),
                              )),
                            ),
                            child: Text(
                              S.of(context).g_key_100,
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  color: Theme.of(context).textTheme.headline2!.color
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtil.getInstance().setWidth(20.0)),
                        Expanded(
                          flex: 1,
                          child:TextButton(
                            onPressed: (){
                              _goReceive();
                            },
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                BorderSide(
                                    color: Theme.of(context).textTheme.headline2!.color!,
                                    width: ScreenUtil.getInstance().setSp(1.0)),
                              ),
                              shape:MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(66.0))),
                              )),
                            ),
                            child: Text(
                              S.of(context).g_key_33,
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  color: Theme.of(context).textTheme.headline2!.color
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(40.0),
                      right: ScreenUtil.getInstance().setWidth(40.0),
                      bottom: ScreenUtil.getInstance().setWidth(35.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: (){
                          _openLockTxDialog();
                        },
                        style: ButtonStyle(
                          backgroundColor:  MaterialStateProperty.all(Theme.of(context).textTheme.headline2!.color),
                          shape:MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(66.0))),
                          )),
                        ),
                        child: Text(
                          S.of(context).g_key_34,
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(26.0),
                              color: Theme.of(context).textTheme.headline3!.color
                          ),
                        ),
                      ),
                    ),
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.orangeAccent)),
                          child: Text(S.of(context).g_key_32,
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54)),
                          onPressed: () {
                            _openSendTxDialog();
                          },
                        ),
                      ),
                      SizedBox(width: ScreenUtil.getInstance().setWidth(18.0)),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          // icon: const Icon(Icons.download_outlined),
                          child: Text(S.of(context).g_key_33,
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54)),
                          onPressed: () => _goReceive(),
                        ),
                      ),
                      SizedBox(width: ScreenUtil.getInstance().setWidth(18.0)),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.redAccent)),
                          // icon: const Icon(Icons.download_outlined),
                          child: Text(S.of(context).g_key_34,
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26.0),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54)),
                          onPressed: () => _openLockTxDialog(),
                        ),
                      )
                    ],
                  )*/
                ],
              )));
    }
  }
}
