import 'package:web3dart/web3dart.dart';
import 'package:sprintf/sprintf.dart';

//https://api.etherscan.io
// 以太坊
String ETHMainnetWs =
    "wss://mainnet.infura.io/ws/v3/b6bd1324a1b34545b1fdda886dd494f9";
String ETHMainnetRpc =
    "https://mainnet.infura.io/v3/b6bd1324a1b34545b1fdda886dd494f9";
String ETHRinkebyWs =
    "wss://rinkeby.infura.io/ws/v3/b6bd1324a1b34545b1fdda886dd494f9";
int ETHRinkebyChainID = 4;
String ETHRopstenRpc = "https://ropsten.infura.io/v3/b6bd1324a1b34545b1fdda886dd494f9";//"http://192.168.0.196:8545";
String ETHRopstenWs = "https://ropsten.infura.io/v3/b6bd1324a1b34545b1fdda886dd494f9";//"ws://192.168.0.196:8546";
int ETHRopstenChainID = 3;//1018;
/*
const ETHRopstenRpc =
    "https://ropsten.infura.io/v3/b6bd1324a1b34545b1fdda886dd494f9";
const ETHRopstenWs =
    "wss://ropsten.infura.io/ws/v3/b6bd1324a1b34545b1fdda886dd494f9";
const ETHRopstenChainID = 3;
*/
// 币安
String BSCMainnetRpc = "https://bsc-dataseed1.binance.org/";
String BSCMainnetWs = "https://bsc-dataseed1.binance.org/";
int BSCMainnetChainID = 56;
String BSCTestnetRpc = "https://data-seed-prebsc-1-s1.binance.org:8545";//"http://192.168.0.196:8588";
String BSCTestnetWs = "https://data-seed-prebsc-1-s1.binance.org:8545";
int BSCTestnetChainID = 97;//1218;
// mainnet addr
String BSCContractAddr = "0x502fBA0dcb132d3a5E93040b84c26823Bfd653C0";

String testAddr = "0xf7773bF1B690720520dba39bbC8d8Bd74e7808Dc";

// eth testnet
String testAddr2 = "0x8E9A30dCd5DE11883E8f0Cd27c5Fe97b1d2B7B83";

//bnb tesetnet addr
String bnbTestnetAddr = "0x1fCEC6a87d3F62E4BE1bC7685924731F93482682";//之前的"0xbcFf341F3537e58Af684b4767410b4C7599eb1A5";

String mETHTestnetAddr="0x8a62C0aB3b5d95c207c8722127ba8d4eca39D49E";//"0xCB7adfC832832607F13DeBB4BC3FBE5f36a66426";//合约地址
String mBNBTestnetAddr="0xFeB859F5F9c14Df3d334d44652a09dDc2b460e49";//"0x4F3114a73938787068772Be00Ed5EdDE7eEdB073";//合约地址
String mtkErc20TestnetAddr="0xbcFf341F3537e58Af684b4767410b4C7599eb1A5";//"0xa899Af105F55038a39C4c2f3483Ec9e5Af290141";

//"ethAddress text,"
//"mtkAddress text,"
//"bnbAddress text"
String ETHAddress="0x0ce9ce2479b71fbafb5b4d2eb699eb6ae8ead838";//"0x48ba0c65289f697407de6f66d0b866c091213281";
String MTKAddress="0x4ea857b68c7ab0d4dc9b1840aeab3d966121ef82";//0xbcFf341F3537e58Af684b4767410b4C7599eb1A5
String BNBAddress="0x0ce9ce2479b71fbafb5b4d2eb699eb6ae8ead838";//0xFeB859F5F9c14Df3d334d44652a09dDc2b460e49

//MTK
String MTKMainnetWs =
    "ws://192.168.0.196:8546";
String MTKMainnetRpc =
    "http://192.168.0.196:8545";
String MTKRinkebyWs =
    "ws://192.168.0.196:8546";
int MTKMainnetChainID = 1118;
String MTKTestnetRpc = "http://70.25.53.166:8545";//"http://192.168.0.196:8548";
String MTKTestnetWs = "ws://70.25.53.166:8546";//"ws://192.168.0.196:8549";
int MTKTestnetChainID = 25;//1118;



/*
//MTK
const MTKMainnetWs =
    "ws://192.168.0.196:8549";
const MTKMainnetRpc =
    "http://192.168.0.196:8548";
const MTKRinkebyWs =
    "ws://192.168.0.196:8549";
const MTKMainnetChainID = 1118;
const MTKTestnetRpc =
    "http://192.168.0.196:8548";
const MTKTestnetWs =
    "ws://192.168.0.196:8549";
const MTKTestnetChainID = 1118;
*/
/*
*   final _i1.EthereumAddress from;

  final _i1.EthereumAddress to;

  final BigInt value;
*
* */


typedef OnSuccessSub = void Function(
    String TxHash, EthereumAddress from, EthereumAddress to, BigInt value);

double toEther(String wei) {
  int l = wei.length;
  if (l <= 1) {
    return double.parse(wei);
  }

  if (l <= 18) {
    //String formatted = sprintf("0.%018s", [wei]);
    //return double.parse(formatted);
    return double.parse(wei)/1000000000000000000;
  } else {
    int fix = l - 18;
    // String formatted = '${wei.substring(0, fix)}.${wei.substring(fix+1, fix+6)}';
    String formatted =
        sprintf("%s.%s", [wei.substring(0, fix), wei.substring(fix, fix + 6)]);
    return double.parse(formatted);
  }
}

double toGWei(String wei) {
  int l = wei.length;
  if (l <= 1) {
    return double.parse(wei);
  }

  if (l <= 9) {
    String formatted = sprintf("0.%018s", [wei]);
    return double.parse(formatted);
  } else {
    int fix = l - 9;
    // String formatted = '${wei.substring(0, fix)}.${wei.substring(fix+1, fix+6)}';
    String formatted =
        sprintf("%s.%s", [wei.substring(0, fix), wei.substring(fix, l)]);
    return double.parse(formatted);
  }
}

BigInt ethToWeiString(String eth) {
  List<String> list = eth.split('.');
  if (list.length > 2) {
    return BigInt.from(0);
  }
  BigInt prix = BigInt.parse(list[0]);
  EtherAmount a = EtherAmount.fromUnitAndValue(EtherUnit.ether, prix);
  if (list.length == 1) {
    return a.getInWei;
  }

  int len = list[1].length;
  int diff = 18 - len;
  BigInt bDiff = BigInt.parse(list[1]);
  BigInt n = bDiff * BigInt.from(10).pow(diff);

  return a.getInWei + n;
}
