// import 'package:kingloryapp/src/http/http.dart';
// class MarketsServer {
//   List<dynamic> coins = [];
//   Map<String, dynamic> globalMarkets = {};
  
//   void InitMarkets() {
//     dio.get("/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false").then((response) => {
//       coins = response.data
//     }, onError: (err) => print("[$err]"));

//     dio.get("/global").then((response) => {
//       globalMarkets = response.data
//     }, onError: (err) => print("[$err]"));
//   }
// }

// var ms = MarketsServer();