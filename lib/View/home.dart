import 'package:crypto1_app/View/Components/item1.dart';
import 'package:crypto1_app/View/selected_Item.dart';
import 'package:crypto1_app/model/coinModel';
import 'package:crypto1_app/services/coinServices.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<CoinModel>> currentCoin;
  late CoinService coinService;
  double previousPrice = 0.0;

  @override
  void initState() {
    super.initState();
    coinService = CoinService();
    currentCoin = coinService.getCoinMarket();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: myHeight,
        width: myWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 59, 139, 179), Colors.grey],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: myHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPortfolioOption(myWidth, myHeight, 'Main portfolio'),
                  _buildTextOption('Top 10 coins'),
                  _buildTextOption('Experimental'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<List<CoinModel>>(
                    future: currentCoin,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          previousPrice != 0.0
                              ? 'Loading...'
                              : '\$${previousPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 23,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        previousPrice = snapshot.data![0].currentPrice ?? 0.0;

                        return Text(
                          '\$${snapshot.data![0].currentPrice!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 23,
                          ),
                        );
                      } else {
                        return const Text('No Data');
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(myWidth * 0.015),
                    height: myHeight * 0.05,
                    width: myWidth * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/icons/5.1.png',
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '+162% all time',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: myWidth,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent,
                      blurRadius: 4,
                      spreadRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: FutureBuilder<List<CoinModel>>(
                  future: currentCoin,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error'),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var item = snapshot.data![index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SelectedItem(selectItem: item)));
                              },
                              child: Item(item: item));
                        },
                      );
                    } else {
                      return Center(
                        child: Text('No Data'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioOption(double width, double height, String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildTextOption(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }
}
