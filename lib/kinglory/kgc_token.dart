import 'package:web3dart/web3dart.dart' as _i1;
import 'kgc.dart';
final _contractAbi = _i1.ContractAbi.fromJson(erc20,'Token');

class Token extends _i1.GeneratedContract {
  _i1.BlockNum? atBlock;
  Token({required _i1.EthereumAddress address, required _i1.Web3Client client, int? chainId}) : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  Future<String> sendTransfer(_i1.EthereumAddress receiver, BigInt amount, {required _i1.Credentials credentials, _i1.Transaction? transaction}) async {
    final function = self.function('transfer');
    final params = [receiver, amount];
    return write(credentials, transaction, function, params);
  }

  Future<String> sendLockupTransfer(_i1.EthereumAddress receiver, BigInt amount, BigInt lockupAmount, BigInt releaseInterval, BigInt releaseAmount, BigInt startTime,{required _i1.Credentials credentials, _i1.Transaction? transaction}) async {
    final function = self.function('transfertoLocked');
    final params = [receiver, amount, lockupAmount, releaseInterval, releaseAmount, startTime];
    return write(credentials, transaction, function, params);
  }

  Stream<Transfer> transferEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('Transfer');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      // print(result);
      final decoded = event.decodeResults(result.topics!, result.data!);
      // print(decoded);
      return Transfer(result.transactionHash!, decoded);
    });
  }

  Future<BigInt> decimals({_i1.BlockNum? atBlock, _i1.EthereumAddress? sender}) async {
    final function = self.function('decimals');
    final params = [];
    final response = await read(function, params, sender, atBlock);
    return (response[0] as BigInt);
  }

  Future<String> symbol({_i1.BlockNum? atBlock, _i1.EthereumAddress? sender}) async {
    final function = self.function('symbol');
    final params = [];
    final response = await read(function, params, sender, atBlock);
    return (response[0] as String);
  }

  Future<String> name({_i1.BlockNum? atBlock, _i1.EthereumAddress? sender}) async {
    final function = self.function('name');
    final params = [];
    final response = await read(function, params, sender, atBlock);
    return (response[0] as String);
  }

  Future<BigInt> totalSupply({_i1.BlockNum? atBlock, _i1.EthereumAddress? sender}) async {
    final function = self.function('totalSupply');
    final params = [];
    final response = await read(function, params, sender, atBlock);
    return (response[0] as BigInt);
  }

  Future<BigInt> getBalance(_i1.EthereumAddress addr, {_i1.BlockNum? atBlock, _i1.EthereumAddress? sender}) async {
    final function = self.function('balanceOf');
    final params = [addr];
    final response = await read(function, params, sender,atBlock);
    return (response[0] as BigInt);
  }

  Future<BigInt> getLockBalance({_i1.BlockNum? atBlock, _i1.EthereumAddress? sender}) async {
    final function = self.function('lockedBalance');
    final params = [];
    final response = await read(function, params, sender,atBlock);
    // print("lockedBalance");
    // print(response);
    return (response[0] as BigInt);
  }

  Future<BigInt> getReleaseAmount({_i1.BlockNum? atBlock, _i1.EthereumAddress? sender}) async {
    final function = self.function('releaseAmount');
    final params = [];
    final response = await read(function, params, sender, atBlock);
    return (response[0] as BigInt);
  }

  Future<BigInt> getReleaseStart({_i1.BlockNum? atBlock, _i1.EthereumAddress? sender}) async {
    final function = self.function('releaseStart');
    final params = [];
    final response = await read(function, params, sender, atBlock);
    return (response[0] as BigInt);
  }

  Future<BigInt> getReleaseInterval({_i1.BlockNum? atBlock, _i1.EthereumAddress? sender}) async {
    final function = self.function('releaseInterval');
    final params = [];
    final response = await read(function, params, sender,atBlock);
    return (response[0] as BigInt);
  }

  Future<_i1.EthereumAddress> getOwner({_i1.BlockNum? atBlock,_i1.EthereumAddress? sender}) async {
    final function = self.function('owner');
    final params = [];
    final response = await read(function, params, sender, atBlock);
    return (response[0] as _i1.EthereumAddress);
  }
}

class Transfer {
  Transfer(String txHash, List<dynamic> response): from = (response[0] as _i1.EthereumAddress), to = (response[1] as _i1.EthereumAddress), value = (response[2] as BigInt), TxHash = txHash;

  final _i1.EthereumAddress from;

  final _i1.EthereumAddress to;

  final BigInt value;

  final String TxHash;
}
