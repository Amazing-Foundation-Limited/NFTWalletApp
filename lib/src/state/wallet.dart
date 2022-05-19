
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:kingloryapp/kinglory/kgc_token.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hex/hex.dart';
import 'package:flutter/foundation.dart';
import 'package:kingloryapp/src/sqlite/wallet.dart';
import 'package:http/http.dart';

import '../../util/chain_url.dart';

class WalletsProviderDefault with ChangeNotifier, DiagnosticableTreeMixin {
  late WalletDb _wallet;
  final Map<String, dynamic> _coins = {};
  late AddressDb _addressInfo;
  AddressDb get addressInfo_get=>_addressInfo;
  bool _isOk = false;
  bool send = false;

  WalletsProviderDefault();

  Map<String, dynamic> coins() {
    return _coins;
  }

  EthProvider? ethCoin() {
    return _coins['ETH'];
  }

  get isSend => send;

  EthProvider? bscCoin() {
    return _coins['BNB'];
  }

  EthProvider? mtkCoin() {
    return _coins['MTK'];
  }

  KGCProvider? mtk_eCoin() {
    return _coins['MTK_E'];
  }
  KGCProvider? eth_eCoin() {
    return _coins['ETH_E'];
  }
  KGCProvider? bnb_eCoin() {
    return _coins['BNB_E'];
  }
  //切换币种的服务地址，isTest是否使用测试地址
  changeCoinsServiceUrl(bool isTest){
    List<String> keys=_coins.keys.toList();
    for(String k in keys){
      Map<String,dynamic> c=_coins[k];
      switch(k){
        case 'ETH':
          //EthProvider ep=_coins[k];
          //ep.info[]
          c['service']=isTest?ETHRopstenRpc:ETHMainnetRpc;
          c['chainId']=isTest?ETHRopstenChainID:ETHRinkebyChainID;
          break;
        case 'BNB':
          c['service']=isTest?BSCTestnetRpc:BSCMainnetRpc;
          c['chainId']=isTest?BSCTestnetChainID:BSCMainnetChainID;
          break;
        case 'MTK':
          c['service']=isTest?MTKTestnetRpc:MTKMainnetRpc;
          c['chainId']=isTest?MTKTestnetChainID:MTKMainnetChainID;
          break;
        case 'MTE_E':
          c['service']=isTest?BSCTestnetRpc:BSCMainnetRpc;
          c['chainId']=isTest?BSCTestnetChainID:BSCMainnetChainID;
          c['contract']=isTest?mtkErc20TestnetAddr:BSCContractAddr;
          break;
        case 'ETH_E':
          c['service']=isTest?ETHRopstenRpc:ETHMainnetRpc;
          c['chainId']=isTest?ETHRopstenChainID:ETHRinkebyChainID;
          c['contract']=isTest?mETHTestnetAddr:BSCContractAddr;
          break;
        case 'BNB_E':
          c['service']=isTest?MTKTestnetRpc:BSCMainnetRpc;
          c['chainId']=isTest?MTKTestnetChainID:BSCMainnetChainID;
          c['contract']=isTest?mBNBTestnetAddr:BSCContractAddr;
          break;
      }

    }
  }

  //修改钱包信息钱 name包名称，password钱包密码,id钱包id
  updatteWalletInfo(int id,Map<String, dynamic> coins,{String name="",String password="",})async{
    final walletInfo=_wallet.toMap();
    if(name!=""){
      walletInfo["name"]=name;
    }
    if(password!=""){
      walletInfo['password'] = password;
    }

    await WalletDatabaseProvider.dbProvider.updateDefaultWallet(WalletDb.fromMap(walletInfo),id);
  }
  //修改地址信息id 地址id，addressName地址名称，mnemonic地址助记词，coins地址币种
  updateAddressInfo(int id,Map<String, dynamic> coins,{String addressName=""})async{

    if(coins!=null){
      _addressInfo.coins=coins;
    }
    if(addressName!=""){
      _addressInfo.addressName=addressName;
    }
    await WalletDatabaseProvider.dbProvider.updateAddress(_addressInfo, id);
  }
  updatePassword(String password) {
    _wallet.password = password;
  }
  updateName(String name){
    _wallet.name=name;
    notifyListeners();
  }

  EthProvider? coinByName(String name) {
    return _coins[name];
  }
  KGCProvider? coinByName_kgc(String name){
    return _coins[name];
  }

  balance(String coinName) {
    if (_coins.isEmpty) {
      return 0;
    }
    var balance = 0;
    switch (coinName.toUpperCase()) {
      case 'ETH':
      case 'BNB':
        {
          EthProvider eth = _coins[coinName];
          return eth.balance();
        }
        break;
      case 'MTK':
        {
          EthProvider kgc = _coins[coinName];
          return kgc.balance();
        }
        break;
      case 'MTK_E':
        {
          KGCProvider kgc = _coins[coinName];
          return kgc.getBalance();
        }
      case 'ETH_E':
        {
          KGCProvider kgc = _coins[coinName];
          return kgc.getBalance();
        }
      case 'BNB_E':
        {
          KGCProvider kgc = _coins[coinName];
          return kgc.getBalance();
        }
    }
  }

  Map<String, dynamic> wallet() {
    if (_isOk) {
      return _wallet.toMap_all();
    }
    return {};
  }
  Map<String, dynamic> addressInfo(){
    if (_isOk) {
      return _addressInfo.toMap();
    }
    return {};
  }


  Future init(WalletDb wallet,address) async {
    _wallet = wallet;
    _addressInfo=address;
    _isOk = true;
    _addressInfo.coins.forEach((key, value) {
      switch (key.toUpperCase()) {
        case 'BNB':
        case 'ETH':
        case 'MTK':
          {
            final eth = EthProvider(info: value);
            eth.init(_wallet.mnemonic,
                value['path'], _wallet.password,
                chainId: value['chainId']);
            _coins[key.toUpperCase()] = eth;
          }
          break;
        /*case 'MTK':
          {
            final kgc = KGCProvider(kgcInfo: value);
            kgc.init(_wallet.mnemonic, value['path'], _wallet.password, chainId: value['chainId']);
            // kgc.init(_wallet.mnemonic, value['path'], _wallet.password,
            //     chainId: value['chainId'], socketConnector: () {
            //   return IOWebSocketChannel.connect(ETHRopstenWs).cast<String>();
            // });
            _coins[key.toUpperCase()] = kgc;
          }
          break;*/
        case 'MTK_E':
        case 'ETH_E':
        case 'BNB_E':
          {
            final kgc = KGCProvider(kgcInfo: value);
            kgc.init(_wallet.mnemonic, value['path'], _wallet.password, chainId: value['chainId']);
            // kgc.init(_wallet.mnemonic, value['path'], _wallet.password,
            //     chainId: value['chainId'], socketConnector: () {
            //   return IOWebSocketChannel.connect(ETHRopstenWs).cast<String>();
            // });
            _coins[key.toUpperCase()] = kgc;
          }
          break;
      }
    });
  }
}

class EthProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, dynamic> info;
  late Wallet _wallet;
  late Web3Client _client;
  late EthereumAddress _address;
  late int? _chainID;
  EthProvider({
    required this.info,
  });

  get iconURL => info['icon'] ?? "assets/images/eth.png";
  get service => info['service'] ?? "http://127.0.0.7";
  get address => _address;
  get private => _wallet.privateKey;
  get currentBlockNumber => _client.getBlockNumber();

  init(String mnemonic, String path, String password,
      {int? chainId, SocketConnector? socketConnector}) async {
    var priv = await GenETHPrivateFromMnemonic(mnemonic, path);
    _wallet = Wallet.createNew(priv, password, Random.secure());
    _address = await _wallet.privateKey.extractAddress();
    _chainID = chainId;
    _client =
        Web3Client(info['service'], Client(), socketConnector: socketConnector);

    // notifyListeners();
  }

  setClient(String serviceUrl) {
    info['service'] = serviceUrl;
    _client = Web3Client(serviceUrl, Client());
    notifyListeners();
  }

  balance() async {
    EtherAmount amount = await _client.getBalance(_address);
    return amount.getInWei.abs();
  }

  gasPrice() async {
    EtherAmount amount = await _client.getGasPrice();
    return amount.getInWei.abs();
  }

  Future<Map<String,dynamic>> sendTransaction(String to, BigInt value, BigInt gas) async {
    var tx = Transaction(
        from: _address,
        to: EthereumAddress.fromHex(to),
        value: EtherAmount.inWei(value),
        gasPrice: EtherAmount.inWei(gas));
    try{
      String r= await _client.sendTransaction(_wallet.privateKey, tx,
          chainId: _chainID);
      return {"error":false,"data":r};
    }catch(e){
      print(e);
      return {"error":true,"data":e.toString()};
    }

  }
  Future<Map<String,dynamic>> sendTransaction_1(String to, BigInt value) async {
    var tx=Transaction(
      from: _address,
      to: EthereumAddress.fromHex(to),
      value: EtherAmount.inWei(value),);
    try{
      String hashStr= await _client.sendTransaction(_wallet.privateKey, tx,
          chainId: _chainID);
      return {"error":false,"data":hashStr};
    }catch(e) {
      print(e);
      return {"error":true,"data":e.toString()};
    }
  }
  Future<String> sendTransaction_2(String to, BigInt value,BigInt gas,) async {
    Uint8List u8=new Uint8List(10);
    var tx = Transaction(
      from: _address,
      to: EthereumAddress.fromHex(to),
      value: EtherAmount.inWei(value),
      gasPrice: EtherAmount.inWei(gas),
      nonce:1,
      data: u8,
    );
    try{
      return await _client.sendTransaction(_wallet.privateKey, tx,
          chainId: _chainID);
    }catch(e) {
      print(e);
      return "error";
    }
  }

  // Stream<Transfer> transferEvents(
  //     {BlockNum? fromBlock, BlockNum? toBlock}) {
  //   // final event = self.event('Transfer');
  //   final filter = FilterOptions(fromBlock: fromBlock, toBlock: toBlock);
  //   return _client.events(filter).map((FilterEvent result) {
  //     // print(result);
  //     final decoded = event.decodeResults(result.topics!, result.data!);
  //     // print(decoded);
  //     return Transfer(result.transactionHash!, decoded);
  //   });
  // }

}

class KGCProvider extends EthProvider {
  Map<String, dynamic> kgcInfo;
  late final Token _token;
  KGCProvider({required this.kgcInfo}) : super(info: kgcInfo);

  @override
  init(String mnemonic, String path, String password,
      {int? chainId, SocketConnector? socketConnector}) async {
    await super.init(mnemonic, path, password,
        chainId: chainId, socketConnector: socketConnector);
    _token = Token(
        address: EthereumAddress.fromHex(kgcInfo['contract']),
        client: _client,
        chainId: chainId);
  }

  @override
  get iconURL => kgcInfo['icon'] ?? "assets/images/kgc.png";

  getName() {
    return _token.name();
  }

  getSymbol() {
    return _token.symbol();
  }

  getDecimals() {
    return _token.decimals();
  }

  getTotalSupply() {
    return _token.totalSupply();
  }

  getOwner() {
    return _token.getOwner();
  }

  getLockupBalance() {
    return _token.getLockBalance(sender: _address);
  }

  getBalance() {
    // var addr = EthereumAddress.fromHex("0x328EB01f221F3908c4fa9F3908CA7164Bd163c8C");
    return _token.getBalance(_address);
  }

  getReleaseTime() {
    return _token.getReleaseInterval(sender: _address);
  }

  getReleaseAmount() {
    return _token.getReleaseAmount(sender: _address);
  }

  getReleaseInterval() {
    return _token.getReleaseInterval(sender: _address);
  }

  Future<Map<String,dynamic>> sendTransfer(EthereumAddress receiver, BigInt amount,
      {required Credentials credentials, Transaction? transaction}) async{
    try{
      String hashStr =await _token.sendTransfer(receiver, amount, credentials: credentials,transaction: transaction);
      return {"error":false,"data":hashStr};
    }catch(e) {
      print(e);
      return {"error":true,"data":e.toString()};
    }

  }

  sendLockupTransfer(
      EthereumAddress receiver,
      BigInt amount,
      BigInt lockupAmount,
      BigInt releaseInterval,
      BigInt releaseAmount,
      BigInt startTime,
      {required Credentials credentials,
      Transaction? transaction}) {
    return _token.sendLockupTransfer(receiver, amount, lockupAmount,
        releaseInterval, releaseAmount, startTime,
        credentials: credentials);
  }

  subscriptionEvent(int cont,
      {OnSuccessSub? onCallback,
      BlockNum? fromBlock,
      BlockNum? toBlock}) async {
    final subscription = _token
        .transferEvents(fromBlock: fromBlock, toBlock: toBlock)
        .listen((event) {
      // print('${event.from} sent ${event.value} MetaCoins to ${event.to}!');
      if (onCallback != null) {
        onCallback(event.TxHash, event.from, event.to, event.value);
      }
    });

    await subscription.asFuture();
    subscription.cancel();
  }
  //发起合约交易
  Future<Map<String,dynamic>> sendTransaction_1(String to, BigInt value) async {
    var tx=Transaction(
      from: _address,
      to: EthereumAddress.fromHex(to),
      value: EtherAmount.inWei(value),);
    try{
      String hashStr= await _token.sendTransfer(EthereumAddress.fromHex(to), value, credentials: _wallet.privateKey,transaction: tx);
      return {"error":false,"data":hashStr};
    }catch(e) {
      print(e);
      return {"error":true,"data":e.toString()};
    }
  }
}

Future GenETHPrivateFromMnemonic(String mnemonic, String path) async {
// String aaa = "nice catalog wish beauty file twice valid inch sausage job fitness custom";
  String seed = bip39.mnemonicToSeedHex(mnemonic);
  var seedBytes = HEX.decode(seed);
  Uint8List seedUint = Uint8List.fromList(seedBytes);
  bip32.BIP32 root = bip32.BIP32.fromSeed(seedUint);
  bip32.BIP32 child = root.derivePath(path);
  var pp = child.privateKey;
  var ppp = pp?.toList();
  String privateKey = HEX.encode(ppp!);
  Credentials fromHex = EthPrivateKey.fromHex(privateKey);
  // print(privateKey);
  // var address = await fromHex.extractAddress();
  // print(address);
  return fromHex;
}
