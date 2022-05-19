import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:kingloryapp/src/setting/setService.dart';
import 'package:kingloryapp/src/state/cc_transaction_provider.dart';
import 'package:kingloryapp/util/chain_url.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bip39/bip39.dart' as bip39;

class WalletDb {
  String name = "";
  String password = "";
  String mnemonic = "";
  int id = 0;
  Map<String, dynamic> coins = GetCoins(0);
  /*{
    "ETH": {
      "path": "m/44'/60'/0'/0/0",
      "service": ETHMainnetRpc,
      "chainId": 1,
      "icon":
          "https://assets.coingecko.com/coins/images/12407/large/Unknown-5.png?1599624896",
      "canEdit":"true"
    },
    "BNB": {
      "path": "m/44'/60'/0'/0/0",
      "service": BSCMainnetRpc,
      "chainId": BSCMainnetChainID,
      "icon":
          "https://assets.coingecko.com/coins/images/825/large/binance-coin-logo.png?1547034615",
      "canEdit":"true",
    },
    "MTK": {
      "path": "m/44'/60'/0'/0/0",
      "service": BSCMainnetRpc,
      "chainId": BSCMainnetChainID,
      "contract": BSCContractAddr,
      "icon": "assets/image/kgc.png",
      "canEdit":"false"
    }
  }; // "BTC":"m/44'/0'/0'/0/0"
*/
  WalletDb(
      {required this.name, required this.password, required this.mnemonic
      });

  Map<String, dynamic> toMap() {
    String scoins = json.encode(coins);
    var map = <String, dynamic>{
      //"id":id,
      "name": name,
      "password": password,
      "mnemonic": mnemonic,
      //"coins": scoins,
    };
    return map;
  }
  Map<String, dynamic> toMap_all() {
    String scoins = json.encode(coins);
    var map = <String, dynamic>{
      "id":id,
      "name": name,
      "password": password,
      "mnemonic": mnemonic,
      //"coins": scoins,
    };
    return map;
  }

  WalletDb.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    password = map['password'];
    mnemonic = map['mnemonic'];
    //String scoins = map['coins'];
    //coins = json.decode(scoins);
  }
}
class AddressDb {
  String addressName = "";
  //String mnemonic = "";
  int isDefault=0;//是否是当前使用的地址，0不是1是
  int id = 0;
  int walletId=0;
  int state=1;//地址状态0删除，1正常
  Map<String, dynamic> coins = GetCoins(0);
 /* {
    "ETH": {
      "path": "m/44'/60'/0'/0/0",
      "service": ETHMainnetRpc,
      "chainId": 1,
      "icon":
      "https://assets.coingecko.com/coins/images/12407/large/Unknown-5.png?1599624896",
      "canEdit":true,
      "isSelect":true//是否选则到address列表中
    },
    "BNB": {
      "path": "m/44'/60'/0'/0/0",
      "service": BSCMainnetRpc,
      "chainId": BSCMainnetChainID,
      "icon":
      "https://assets.coingecko.com/coins/images/825/large/binance-coin-logo.png?1547034615",
      "canEdit":true,
      "isSelect":true//是否选则到address列表中
    },
    "MTK": {
      "path": "m/44'/60'/0'/0/0",
      "service": BSCMainnetRpc,
      "chainId": BSCMainnetChainID,
      "contract": BSCContractAddr,
      "icon": "assets/image/kgc.png",
      "canEdit":false,
      "isSelect":true//是否选则到address列表中
    }
  }; // "BTC":"m/44'/0'/0'/0/0"
*/
  AddressDb(
      {required this.addressName, required this.isDefault, required this.walletId});
  AddressDb.coin(
      {required this.addressName, required this.isDefault, required this.walletId,required this.coins});

  Map<String, dynamic> toMap() {
    String scoins = json.encode(coins);
    var map = <String, dynamic>{
      "id":id,
      "walletId":walletId,
      "addressName": addressName,
      "state": state,
      "coins": scoins,
      "isDefault":isDefault,
    };
    return map;
  }
  Map<String, dynamic> toMap_DB() {
    String scoins = json.encode(coins);
    var map = <String, dynamic>{
      "walletId":walletId,
      "addressName": addressName,
      "state": state,
      "coins": scoins,
      "isDefault":isDefault,
    };
    return map;
  }

  AddressDb.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    walletId=map['walletId'];
    addressName = map['addressName'];
    isDefault = map['isDefault'];
    String scoins = map['coins'];
    coins = json.decode(scoins);
    state=map['state'];
  }
}


class WalletsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<WalletDb> _wallets = [];
  Map<String, dynamic> defaultWallet = {};

  WalletsProvider();

  void setWallets(List<WalletDb> wallets) {
    _wallets = wallets;
  }

  Map<String, dynamic> getWalletByName(String name) {
    Map<String, dynamic> value = {};
    _wallets.forEach((element) {
      if (element.name == name) {
        value = element.toMap();
      }
    });
    return value;
  }

  Map<String, dynamic> getDefaultWallet() {
    return defaultWallet;
  }

  void saveWallet(WalletDb wallet) async {
    await WalletDatabaseProvider.dbProvider
        .addWalletToDatabase(wallet)
        .then((value) => value)
        .onError((error, stackTrace) => 0);
  }

  void updateWallet(Map<String, dynamic> map) {
    WalletDb wdb = WalletDb.fromMap(map);
    WalletDatabaseProvider.dbProvider.updateWallet(wdb);
  }

  String generateMnemonic() {
    return bip39.generateMnemonic();
  }
}

class WalletDatabaseProvider {
  WalletDatabaseProvider._();
  static final WalletDatabaseProvider dbProvider = WalletDatabaseProvider._();
  late Database _database;

  Future<Database> get database async {
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    var directory = await getDatabasesPath();
    String path = join(directory, "wallet.db");
    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
          /*await db.execute("CREATE TABLE Wallet ("
              "id Integer primary key autoincrement,"
              "name TEXT,"
              "password TEXT,"
              "mnemonic TEXT,"
              "coins TEXT"
              ")");*/
          await db.execute("Create table Address ("
              "id INTEGER primary key autoincrement,"//账号id
              "walletId INTEGER,"//账号id
              "addressName Text,"//钱包地址名
              "coins TEXT,"//币json
              "state INTEGER,"//0删除，1正常
              "isDefault INTEGER"//是否是当前使用的地址
              ")");
          await db.execute("CREATE TABLE Wallet ("
              "id INTEGER PRIMARY KEY autoincrement,"
              "name TEXT,"
              "password TEXT,"
              "mnemonic TEXT"
              //"coins TEXT"
              ")");
          await db.execute("create table CrossChainTransaction("
              "id integer primary key autoincrement,"
              "coinName text,"
              "coin text,"
              "from1 text,"
              "to1 text,"
              "to_coinName text,"
              "to_coin text,"
              "value REAL,"
              "receive text,"
              "returnHash text,"
              "state text,"
              "time text"
              ")");
          await db.execute("create table ServiceConfige("
              "ethMainnerRpc text,"
              "ethTextnetRpc text,"
              "ethMainnetWs text,"
              "ethTextnetWs text,"
              "ethMainnetChainID integer,"
              "ethTextnetChainID integer,"
              "bnbMainnerRpc text,"
              "bnbTextnetRpc text,"
              "bnbMainnetWs text,"
              "bnbTextnetWs text,"
              "bnbMainnetChainID integer,"
              "bnbTextnetChainID integer,"
              "mtkMainnerRpc text,"
              "mtkTextnetRpc text,"
              "mtkMainnetWs text,"
              "mtkTextnetWs text,"
              "mtkMainnetChainID integer,"
              "mtkTextnetChainID integer,"
              "eth_eMainnerRpc text,"
              "eth_eTextnetRpc text,"
              "eth_eMainnetWs text,"
              "eth_eTextnetWs text,"
              "eth_eMainnetChainID integer,"
              "eth_eTextnetChainID integer,"
              "eth_eMainnetAddr text,"
              "eth_eTestnetAddr text,"
              "bnb_eMainnerRpc text,"
              "bnb_eTextnetRpc text,"
              "bnb_eMainnetWs text,"
              "bnb_eTextnetWs text,"
              "bnb_eMainnetChainID integer,"
              "bnb_eTextnetChainID integer,"
              "bnb_eMainnetAddr text,"
              "bnb_eTestnetAddr text,"
              "mtk_eMainnerRpc text,"
              "mtk_eTextnetRpc text,"
              "mtk_eMainnetWs text,"
              "mtk_eTextnetWs text,"
              "mtk_eMainnetChainID integer,"
              "mtk_eTextnetChainID integer,"
              "mtk_eMainnetAddr text,"
              "mtk_eTestnetAddr text,"
              "apiMain text,"
              "apiTest text,"
              "ethAddress text,"
              "mtkAddress text,"
              "bnbAddress text"
              ")");
        },
        onUpgrade: (Database db, int oldVersion, int newVersion)async{
          var res=await db.query("WalletDefault");
          WalletDb? walletDb=res.isNotEmpty ? WalletDb.fromMap(res.first) : null;
          db.execute("drop table WalletDefault");
          db.execute("drop table Wallet");
          db.execute("CREATE TABLE Wallet ("
              "id Integer primary key autoincrement,"
              "name TEXT,"
              "password TEXT,"
              "mnemonic TEXT"
              ")");
          await db.execute("Create table Address ("
              "id INTEGER primary key autoincrement,"//账号id
              "walletId INTEGER,"//账号id
              "addressName Text,"//钱包地址名
              "coins TEXT,"//币json
              "state INTEGER,"//0删除，1正常
              "isDefault INTEGER"//是否是当前使用的地址
              ")");
          await db.execute("create table CrossChainTransaction("
              "id integer primary key autoincrement,"
              "coinName text,"
              "coin text,"
              "from1 text,"
              "to1 text,"
              "to_coinName text,"
              "to_coin text,"
              "value REAL,"
              "receive text,"
              "returnHash text,"
              "state text,"
              "time text"
              ")");
          await db.execute("create table ServiceConfige("
              "ethMainnerRpc text,"
              "ethTextnetRpc text,"
              "ethMainnetWs text,"
              "ethTextnetWs text,"
              "ethMainnetChainID integer,"
              "ethTextnetChainID integer,"
              "bnbMainnerRpc text,"
              "bnbTextnetRpc text,"
              "bnbMainnetWs text,"
              "bnbTextnetWs text,"
              "bnbMainnetChainID integer,"
              "bnbTextnetChainID integer,"
              "mtkMainnerRpc text,"
              "mtkTextnetRpc text,"
              "mtkMainnetWs text,"
              "mtkTextnetWs text,"
              "mtkMainnetChainID integer,"
              "mtkTextnetChainID integer,"
              "eth_eMainnerRpc text,"
              "eth_eTextnetRpc text,"
              "eth_eMainnetWs text,"
              "eth_eTextnetWs text,"
              "eth_eMainnetChainID integer,"
              "eth_eTextnetChainID integer,"
              "eth_eMainnetAddr text,"
              "eth_eTestnetAddr text,"
              "bnb_eMainnerRpc text,"
              "bnb_eTextnetRpc text,"
              "bnb_eMainnetWs text,"
              "bnb_eTextnetWs text,"
              "bnb_eMainnetChainID integer,"
              "bnb_eTextnetChainID integer,"
              "bnb_eMainnetAddr text,"
              "bnb_eTestnetAddr text,"
              "mtk_eMainnerRpc text,"
              "mtk_eTextnetRpc text,"
              "mtk_eMainnetWs text,"
              "mtk_eTextnetWs text,"
              "mtk_eMainnetChainID integer,"
              "mtk_eTextnetChainID integer,"
              "mtk_eMainnetAddr text,"
              "mtk_eTestnetAddr text,"
              "apiMain text,"
              "apiTest text,"
              "ethAddress text,"
              "mtkAddress text,"
              "bnbAddress text"
              ")");
          if(walletDb!=null){
            int res=await db.rawInsert('insert into Wallet(name,password,mnemonic) values(?,?,?)',[walletDb.name,walletDb.password,walletDb.mnemonic]);
            await db.rawInsert("insert into Address(walletId,addressName,coins,state,isDefault) values(?,?,?,1,1)",[res,"Address 1",json.encode(GetCoins(0))]);
          }
        },
    );

  }

  //检查数据库是否存在
  databaseIsExists()async{
    var directory = await getDatabasesPath();
    String path = join(directory, "wallet.db");
    return await databaseExists(path);
  }
  //检测数据是否完整
  checkData()async{
    try{
      if(await tableIsExits('Address')){
        return true;
      }else{
        final db = await database;
        var response = await db.query("WalletDefault",);
        WalletDb? walletdb=response.isNotEmpty ? WalletDb.fromMap(response.first) : null;
        if(walletdb==null){
          return true;
        }
        else{
          await db.execute("delete table ");
        }
      }
      var directory = await getDatabasesPath();
      String path = join(directory, "wallet.db");
      bool isExist=await databaseExists(path);
      if(isExist){
        Database oldDatabase=await openDatabase(path,version: 1);
        var response = await oldDatabase.query("WalletDefault",);
        WalletDb? walletdb=response.isNotEmpty ? WalletDb.fromMap(response.first) : null;
        if(walletdb==null){
          return;
        }else{
          //钱包id
          int walletId= await addWalletToDatabase(WalletDb(name: walletdb.name,password: walletdb.password,mnemonic: walletdb.mnemonic));
          addAddress(AddressDb(addressName: 'Address 1', isDefault: 1,walletId: walletId));
        }
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }

  }

  //判断表是否存在
  tableIsExits(String tableName)async{
    var sql="select * from sqlite_master where type='table' and name='$tableName'";
    final db = await database;
    var response=await db.rawQuery(sql);
    return response!=null && response.length>0;
  }

  Future<int> addWalletToDatabase(WalletDb wallet) async {
    final db = await database;
    var raw = await db.insert("Wallet", wallet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.rollback);
    return raw;
  }


  updateWallet(WalletDb wallet) async {
    final db = await database;
    var response = await db.update("Wallet", wallet.toMap(),
        where: "name = ?", whereArgs: [wallet.name]);
    return response;
  }
  //修改钱包，条件为id
  updateWalletWithId(WalletDb wallet) async {
    final db = await database;
    var response = await db.update("Wallet", wallet.toMap(),
        where: "id = ?", whereArgs: [wallet.id]);
    return response;
  }

  Future<WalletDb?> getDefaultWallet() async {
    final db = await database;
    var response =
        await db.query("WalletDefault",);
    return response.isNotEmpty ? WalletDb.fromMap(response.first) : null;
  }

  updateDefaultWallet(WalletDb wallet,int id) async {
    final db = await database;
    var response = await db.update("WalletDefault", wallet.toMap(),
        where: "id = ?", whereArgs: [id]);
    return response;
  }

  Future<int> addDefaultWallet(WalletDb wallet) async {
    final db = await database;
    var map = wallet.toMap();
    //map['id'] = 0;
    var raw = await db.insert("WalletDefault", map,
        conflictAlgorithm: ConflictAlgorithm.rollback);
    return raw;
  }

  Future<WalletDb?> getWalletWithName(String name) async {
    final db = await database;
    var response =
        await db.query("Wallet", where: "name = ?", whereArgs: [name]);
    return response.isNotEmpty ? WalletDb.fromMap(response.first) : null;
  }

  Future<WalletDb?> getAllWallet() async {
    final db = await database;
    var response = await db.query("Wallet");
    return response.isNotEmpty ? WalletDb.fromMap(response.first) : null;
  }

  deleteWalletWithId(String name) async {
    final db = await database;
    return db.delete("Wallet", where: "name = ?", whereArgs: [name]);
  }

  deleteAllWallet() async {
    final db = await database;
    db.delete("Wallet");
  }

  Future<int> addAddress(AddressDb address) async {
    final db = await database;
    var map = address.toMap_DB();
    //map['id'] = 0;
    var raw = await db.insert("Address", map,
        conflictAlgorithm: ConflictAlgorithm.rollback);
    return raw;
  }
  //返回地址，条件id
  Future<AddressDb?> getAddressWithId(int id) async {
    final db = await database;
    var response =
    await db.query("Address", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? AddressDb.fromMap(response.first) : null;
  }
  //返回默认地址，条件isDefault
  Future<AddressDb?> getAddressDefault() async {
    final db = await database;
    var response =
    await db.query("Address", where: "isDefault = 1 and state=1", );
    return response.isNotEmpty ? AddressDb.fromMap(response.first) : null;
  }
  //返回全部地址
  Future<List<AddressDb>> getAllAddress() async {
    final db = await database;
    var response =
    await db.query("Address",where: "state=1");
    List<AddressDb> list = response.map((c) => AddressDb.fromMap(c)).toList();
    return list;
  }
  //删除地址，对地址做修改处理
  deleteAddressWithId(int id) async {
    final db = await database;
    return db.rawUpdate("Update Address set state=0 where id=?",[id]);
  }
  //修改地址，条件id
  updateAddress(AddressDb address,int id) async {
    final db = await database;
    var response = await db.update("Address", address.toMap_DB(),
        where: "id = ?", whereArgs: [id]);
    return response;
  }
  //修改地址，取消当亲默认地址
  updateAddress_isDefault_0() async {
    final db = await database;
    var response = await db.execute("update Address set isDefault=0 where isDefault=1");
    return response;
  }
  //获取地址表的数据条数
  Future<dynamic> getAddress_DataRows()async{
    final db=await database;
    var response =await db.rawQuery('select count(*) as rows from Address');
    return response.first['rows'];
  }

  //添加跨链转账记录
  Future<int> addCrossChainTransaction(TransactionData1 td)async{
    final db = await database;
    var map = td.toMap_db();
    var raw = await db.insert("CrossChainTransaction", map,
    conflictAlgorithm: ConflictAlgorithm.rollback);
    return raw;
  }
  //修改跨链转账记录
  updateCrossChainTransaction(String state,String returnHash)async{
    final db = await database;
    var response = await db.execute("update CrossChainTransaction set state='${state}' where returnHash='${returnHash}'");
    return response;
  }
  updateCrossChainTransaction_all(String state)async{
    final db = await database;
    var response = await db.execute("update CrossChainTransaction set state='${state}'");
    return response;
  }
  //查询跨链转账记录,单个
  Future<List<TransactionData1>>getCrossChainTransactionByReturnHash(String returnHash)async{
    final db = await database;
    var response =
    await db.query("CrossChainTransaction",where: "returnHash=${returnHash}");
    List<TransactionData1> list = response.map((c) => TransactionData1.fromMap(c)).toList();
    return list;
  }
  //查询跨链转账记录,全部
  Future<List<TransactionData1>>getCrossChainTransaction(int limit,int offset)async{
    final db = await database;
    var response =
    await db.query("CrossChainTransaction",orderBy: 'id desc',limit: limit,offset: offset);
    List<TransactionData1> list = response.map((c) => TransactionData1.fromMap(c)).toList();
    return list;
  }
  //查询跨链转账记录，state!=pendding的
  Future<List<TransactionData1>>getCrossChainTransactionByState(String state)async{
    final db = await database;
    var response =
    await db.query("CrossChainTransaction",orderBy: 'id',where: "state !='$state'");
    List<TransactionData1> list = response.map((c) => TransactionData1.fromMap(c)).toList();
    return list;
  }
  //查询服务地址设置
  Future<ServiceModel?> getServiceConfig()async{
    final db = await database;
    var response =
    await db.query("ServiceConfige",);
    return response.isNotEmpty ? ServiceModel.fromMap(response.first) : null;
  }
  //添加服务地址设置
  insertServiceConfig(ServiceModel sm)async{
    final db = await database;
    //map['id'] = 0;
    var raw = await db.insert("ServiceConfige", sm.getMap(),
        conflictAlgorithm: ConflictAlgorithm.rollback);
    return raw;
  }
  //修改服务地址设置
  updateServiceConfig(ServiceModel sm)async{
    final db = await database;
    var response = await db.update("ServiceConfige", sm.getMap());
    return response;
  }
}
bool useTestAddress=true;
GetCoins(int pathId){
  Map<String, dynamic> coins = {
    "ETH": {
      "index":1,
      "name_k":"ETH",
      "name":"ETH",
      "name_m":"eth",
      "path": "m/44'/60'/0'/0/${pathId}",
      "service": useTestAddress?ETHRopstenRpc:ETHMainnetRpc,
      "chainId": useTestAddress?ETHRopstenChainID:ETHRinkebyChainID,
      "contract": "",
      "icon":
      "https://assets.coingecko.com/coins/images/12407/large/Unknown-5.png?1599624896",
      "canEdit":true,
      "isSelect":false,//是否选则到address列表中
      "isERC20":false,//是否是erc20
      "changeIndex":'',
      "lockup":false,//是否可以锁仓
    },
    "BNB": {
      "index":2,
      "name_k":"BNB",
      "name":"BNB",
      "name_m":"bnb",
      "path": "m/44'/60'/0'/0/${pathId}",
      "service": useTestAddress?BSCTestnetRpc:BSCMainnetRpc,
      "chainId": useTestAddress?BSCTestnetChainID:BSCMainnetChainID,
      "contract": "",
      "icon":
      "https://assets.coingecko.com/coins/images/825/large/binance-coin-logo.png?1547034615",
      "canEdit":true,
      "isSelect":false,//是否选则到address列表中
      "isERC20":false,//是否是erc20
      "changeIndex":'',
      "lockup":false,//是否可以锁仓
    },
    "MTK": {
      "index":3,
      "name_k":"MTK",
      "name":"MTK",
      "name_m":"mtk",
      "path": "m/44'/60'/0'/0/${pathId}",
      "service": useTestAddress?MTKTestnetRpc:MTKMainnetRpc,
      "chainId": useTestAddress?MTKTestnetChainID:MTKMainnetChainID,
      "contract": "",
      "icon":"assets/image/mtk.png",
      "canEdit":false,
      "isSelect":false,//是否选则到address列表中
      "isERC20":false,//是否是erc20
      "changeIndex":'',
      "lockup":false,//是否可以锁仓
    },
    "MTK_E": {
      "index":4,
      "name_k":"MTK_E",
      "name":"MTK",
      "name_m":"mtk",
      "path": "m/44'/60'/0'/0/${pathId}",
      "service": useTestAddress?BSCTestnetRpc:BSCMainnetRpc,
      "chainId": useTestAddress?BSCTestnetChainID:BSCMainnetChainID,
      "contract": useTestAddress?mtkErc20TestnetAddr:BSCContractAddr,
      "icon": "assets/image/mtk.png",
      "canEdit":false,
      "isSelect":false,//是否选则到address列表中
      "isERC20":true,//是否是erc20
      "changeIndex":'b',//2
      "lockup":true,//是否可以锁仓
    },
    "ETH_E": {
      "index":5,
      "name_k":"ETH_E",
      "name":"ETH",
      "name_m":"eth",
      "path": "m/44'/60'/0'/0/${pathId}",
      "service": useTestAddress?MTKTestnetRpc:ETHMainnetRpc,
      "chainId": useTestAddress?MTKTestnetChainID:ETHRinkebyChainID,
      "contract": useTestAddress?mETHTestnetAddr:BSCContractAddr,
      "icon":"https://assets.coingecko.com/coins/images/12407/large/Unknown-5.png?1599624896",
      "canEdit":true,
      "isSelect":false,//是否选则到address列表中
      "isERC20":true,//是否是erc20
      "changeIndex":'m',//1
      "lockup":false,//是否可以锁仓
    },
    "BNB_E": {
      "index":5,
      "name_k":"BNB_E",
      "name":"BNB",
      "name_m":"bnb",
      "path": "m/44'/60'/0'/0/${pathId}",
      "service": useTestAddress?MTKTestnetRpc:BSCMainnetRpc,
      "chainId": useTestAddress?MTKTestnetChainID:BSCMainnetChainID,
      "contract": useTestAddress?mBNBTestnetAddr:BSCContractAddr,
      "icon": "https://assets.coingecko.com/coins/images/825/large/binance-coin-logo.png?1547034615",
      "canEdit":true,
      "isSelect":false,//是否选则到address列表中
      "isERC20":true,//是否是erc20
      "changeIndex":'m',//2
      "lockup":false,//是否可以锁仓
    }
  };
  return coins;
}
enum CoinType{
  BNB,
  ETH,
  MTK
}
//测试钱包助记词trade achieve waste jump exchange winter swear want ankle moral noble focus
//jyw *12 0x7906 88e5 0bde 81b1 0b30 bd6b cb01 43d8 c3f5 19b0
/*
Map<String, dynamic> coins = {
  "ETH": {
    "path": "m/44'/60'/0'/0/0",
    "service": ETHMainnetRpc,
    "chainId": 1,
    "icon":
    "https://assets.coingecko.com/coins/images/12407/large/Unknown-5.png?1599624896",
    "canEdit":true,
    "isSelect":false//是否选则到address列表中
  },
  "BNB": {
    "path": "m/44'/60'/0'/0/0",
    "service": BSCMainnetRpc,
    "chainId": BSCMainnetChainID,
    "icon":
    "https://assets.coingecko.com/coins/images/825/large/binance-coin-logo.png?1547034615",
    "canEdit":true,
    "isSelect":false//是否选则到address列表中
  },
  "KGC": {
    "path": "m/44'/60'/0'/0/0",
    "service": BSCMainnetRpc,
    "chainId": BSCMainnetChainID,
    "contract": BSCContractAddr,
    "icon": "assets/image/kgc.png",
    "canEdit":false,
    "isSelect":false//是否选则到address列表中
  }
};
*/