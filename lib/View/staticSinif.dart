import 'package:crypto1_app/model/coinModel';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class YardimciSinif extends StatefulWidget {
  const YardimciSinif({super.key});

  @override
  State<YardimciSinif> createState() => _YardimciSinifState();
}

class _YardimciSinifState extends State<YardimciSinif> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

bool isRefreshing = true;
List? coinMarket = [];

var coinMarketList;

 Future<List<CoinModel>?> getCoinMarket() async {
  const url =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';
  setState(() {
    isRefreshing = true;
  });

  var response = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
  });
  setState(() {
    isRefreshing = false;
  });
  if (response.statusCode == 200) {
    var x = response.body;
    coinMarketList = coinModelFromJson(x);
    setState(() {
      coinMarket = coinMarketList;
    });
  } else {
    print(response.statusCode);
  }
}


}

