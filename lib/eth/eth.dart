import 'dart:math';
import 'dart:typed_data';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hex/hex.dart';
import "package:ed25519_hd_key/ed25519_hd_key.dart";
import 'package:flutter/foundation.dart';

class EthCoin {
  String url = "";
  var address;
  var privateKey;
  //
  // static Future<String> getETHPrivateFromMnemonic(String mnemonic, String path) async {
  //   // String aaa = "nice catalog wish beauty file twice valid inch sausage job fitness custom";
  //   // String seed = bip39.mnemonicToSeedHex(aaa);
  //   String seed = bip39.mnemonicToSeedHex(mnemonic);
  //   List<int> seedBytes = HEX.decode(seed);
  //   KeyData master = await ED25519_HD_KEY.derivePath("m/44'/60'/0'/0001", seedBytes);
  //   String privateKey = HEX.encode(master.key);
  //   Credentials fromHex = EthPrivateKey.fromHex(privateKey);
  //   print(privateKey);
  //   var address = await fromHex.extractAddress();
  //   print(address);
  //
  //   return privateKey;
  // }
}