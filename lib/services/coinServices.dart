import 'package:crypto1_app/model/coinModel';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CoinService {
  Future<List<CoinModel>> getCoinMarket() async {
    const url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body) as List;
      return jsonData.map((coin) => CoinModel.fromJson(coin)).toList();
    } else {
      throw Exception('Failed to load coins');
    }
  }
}



