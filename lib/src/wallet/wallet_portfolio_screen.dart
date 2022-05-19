import 'package:flutter/material.dart';
import 'package:kingloryapp/generated/l10n.dart';
import 'package:kingloryapp/src/state/coins.dart';
import 'package:kingloryapp/src/state/wallet.dart';
import 'package:kingloryapp/src/wallet/wallet_protfolio_item.dart';
import 'package:kingloryapp/src/wallet/wallet_receive_qr.dart';
import 'package:kingloryapp/src/wallet/wallet_send_tx.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:kingloryapp/util/screen_adapter/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class PortfolioScreen extends StatefulWidget {
  CoinModel coinModel;
  PortfolioScreen(this.coinModel,
      {Key? key})
      : super(key: key);

  @override
  PortfolioScreenState createState() => PortfolioScreenState();
}

class PortfolioScreenState extends State<PortfolioScreen> {
  bool send = false;
  //BigInt totalBalance = BigInt.from(0);
  //BigInt gasPrice = BigInt.from(0);
  //String iconUrl = "assert/image";
  late EthereumAddress addr;
  _changeWidget() {
    setState(() {
      if (send) {
        send = false;
      } else {
        send = true;
      }
    });
  }

  void _openAddEntryDialog() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return SendTransaction(
              name: widget.coinModel.coin['name'],
              usableBalance:
                  toEther(EtherAmount.inWei(widget.coinModel.balance).getInWei.toString()));
        },
        fullscreenDialog: true));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getLockupBalance();
  }

  _goReceive() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ReceiveQr(addr: widget.coinModel.address);
      },
      // fullscreenDialog: true
    ));
  }
/*
  _getLockupBalance() async {
    final balance;
    final gasprice;
    final address;
    if(widget.coin['contract']==''){
      EthProvider? ethPro = Provider.of<WalletsProviderDefault>(context, listen: false)
          .coinByName(widget.coin['name_k']);
      balance = await ethPro!.balance();
      print('${widget.coin['name_k']}:balance:${balance}');
      gasprice = await ethPro.gasPrice();
      print('${widget.coin['name_k']}:gasprice:${gasprice}');
      address = await ethPro.address;
      print('${widget.coin['name_k']}:address:${address}');
    }else{
      if(widget.coin['name_k']=="BNB"){
        EthProvider? ethPro = Provider.of<WalletsProviderDefault>(context, listen: false)
            .coinByName(widget.coin['name_k']);
        balance = await ethPro!.balance();
        print('${widget.coin['name_k']}:balance:${balance}');
        gasprice = await ethPro.gasPrice();
        print('${widget.coin['name_k']}:gasprice:${gasprice}');
        address = await ethPro.address;
        print('${widget.coin['name_k']}:address:${address}');
      }
      else{
        KGCProvider? ethPro = Provider.of<WalletsProviderDefault>(context, listen: false)
            .coinByName_kgc(widget.coin['name_k']);
        balance = await ethPro!.getBalance();
        print('${widget.coin['name_k']}:balance:${balance}');
        gasprice = await ethPro.gasPrice();
        print('${widget.coin['name_k']}:gasprice:${gasprice}');
        address = await ethPro.address;
        print('${widget.coin['name_k']}:address:${address}');
      }
    }


    if (this.mounted) {
      setState(() {
        totalBalance = balance;
        gasPrice = gasprice;
        addr = address;
      });
    }

    // if (widget.name == "ETH" ) {
    //
    //
    // } else {
    //   final ethPro = Provider.of<WalletsProviderDefault>(context, listen: false).bscCoin();
    //   final balance = await ethPro.balance();
    //   final gasprice = await ethPro.gasPrice();
    //   if (this.mounted) {
    //     setState(() {
    //       totalBalance = balance;
    //       gasPrice = gasprice;
    //     });
    //   }
    // }
  }
*/
  @override
  Widget build(BuildContext context) {
    if (!send) {
      return Card(
          elevation: 0.0,
          child: Column(
            children: [
              InkWell(
                onTap: () => _changeWidget(),
                child: ProtfolioItem(
                  widget.coinModel.coin,
                  widget.coinModel.coinPrice,
                  widget.coinModel.percentage,
                    toEther(
                        EtherAmount.inWei(widget.coinModel.balance).getInWei.toString()),
                  mainLabel: widget.coinModel.coin['changeIndex'],
                ),
              ),
            ],
          ));
    } else {
      return Card(
          elevation: 0.0,
          child: InkWell(
              onTap: () => _changeWidget(),
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
                              _openAddEntryDialog();
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
                ],
              )));
    }
  }
}