import 'package:crypto1_app/View/home.dart';
import 'package:crypto1_app/View/navBar.dart';
import 'package:crypto1_app/model/chartModel.dart';
import 'package:crypto1_app/model/coinModel';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syncfusion_flutter_charts/charts.dart';

class SelectedItem extends StatefulWidget {
  var selectItem;

  SelectedItem({
    required this.selectItem,
  });

  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  late TrackballBehavior trackballBehavior;

  @override
  void initState() {
    getChart();
    trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var orientation = MediaQuery.of(context).orientation;
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    //Tablet ve web için if kısmı açılacak
    //  if (orientation == Orientation.portrait) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: myHeight,
        width: myWidth,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: myWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                        height: myHeight * 0.07,
                        child: Image.network(widget.selectItem.image ?? '')),
                    SizedBox(
                      width: myWidth * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectItem.id.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: myHeight * 0.01,
                        ),
                        Text(
                          widget.selectItem.symbol.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          '\$' +
                              widget.selectItem.currentPrice!
                                  .toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black)),
                      SizedBox(
                        height: myHeight * 0.01,
                      ),
                      Text(
                        widget.selectItem.marketCapChangePercentage24H!
                                .toStringAsFixed(3) +
                            '%',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: widget.selectItem
                                        .marketCapChangePercentage24H! >=
                                    0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),

            Expanded(
                child: Container(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('Low',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(widget.selectItem.low24H!.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)),
                          ],
                        ),
                        Column(
                          children: [
                            Text('High',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                                '\$' +
                                    widget.selectItem.high24H!
                                        .toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Vol',
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.grey)),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                                widget.selectItem.totalVolume!
                                        .toStringAsFixed(2) +
                                    'M',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.005,
                  ),
                  //Bu container de Sayfanın Grafik kısmı
                  Container(
                    height: myHeight * 0.32,
                    width: myWidth,
                    child: Refresh == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffdddd00),
                            ),
                          )
                        : itemChart == null
                            ? Padding(
                                padding: EdgeInsets.all(myHeight * 0.06),
                                child: Center(
                                  child: Text(
                                    'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )
                            : SfCartesianChart(
                                trackballBehavior: trackballBehavior,
                                zoomPanBehavior: ZoomPanBehavior(
                                  enablePinching: true,
                                  zoomMode: ZoomMode.x,
                                ),
                                series: <CandleSeries>[
                                  CandleSeries<ChartModel, int>(
                                    enableSolidCandles: true,
                                    enableTooltip: true,
                                    bullColor: Colors.green,
                                    bearColor: Colors.red,
                                    dataSource: itemChart!,
                                    xValueMapper: (ChartModel sales, _) =>
                                        sales.time,
                                    lowValueMapper: (ChartModel sales, _) =>
                                        sales.low,
                                    highValueMapper: (ChartModel sales, _) =>
                                        sales.high,
                                    openValueMapper: (ChartModel sales, _) =>
                                        sales.open,
                                    closeValueMapper: (ChartModel sales, _) =>
                                        sales.close,
                                    animationDuration: 55,
                                  ),
                                ],
                              ),
                  ),
                  SizedBox(
                    height: myHeight * 0.001,
                  ),
                  //Bu container sayfanın D,W,M,3M vs liste kısmı Olan kısım
                  Center(
                    child: Container(
                      height: myHeight * 0.04,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: text.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: myWidth * 0.03),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    textBool = [
                                      false,
                                      false,
                                      false,
                                      false,
                                      false,
                                      false,
                                    ];

                                    textBool[index] = true;
                                  });
                                  setDays(text[index]);
                                  getChart();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: myWidth * 0.03,
                                      vertical: myHeight * 0.003),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: textBool[index] == true
                                          ? Colors.amber.withOpacity(0.5)
                                          : Colors.transparent),
                                  child: Text(
                                    text[index],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),

                  //Bu Container kısım Sayfanı News haber kısmı

                  Scrollbar(
                    thickness: 10,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: myWidth * 0.25,
                                    child: CircleAvatar(
                                      radius: myHeight * 0.05,
                                      backgroundImage: AssetImage(
                                          'assets/image/bitcoin.jpeg'),
                                    ),
                                  ),
                                  Text(
                                    'News',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ]),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: myWidth * 0.03,
                                        vertical: myHeight * 0.01),
                                    child: const Text(
                                      'Trumps speeches at the Bitcoin 2024 conference certainly made their mark this month. All these developments and much more contributed to volatility in the price of BitcoinTrumps speeches at the Bitcoin 2024 conference certainly made their mark this month. All these developments and much more contributed to volatility in the price of BitcoinTrumps speeches at the Bitcoin 2024 conference certainly made their mark this month. All these developments and much more contributed to volatility in the price of BitcoinTrumps speeches at the Bitcoin 2024 conference certainly made their mark this month. All these developments and much more contributed to volatility in the price of BitcoinTrumps speeches at the Bitcoin 2024 conference certainly made their mark this month. All these developments and much more contributed to volatility in the price of BitcoinTrumps speeches at the Bitcoin 2024 conference certainly made their mark this month. All these developments and much more contributed to volatility in the price of Bitcoin',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            )),

            //sayfanın en altında ki Add to portfolio ve icon container kısmı
            Container(
              height: myHeight * 0.09,
              width: myWidth,
              child: Column(
                children: [
                  Divider(
                    thickness: 1,
                  ),
                  /*   SizedBox(
                    height: myHeight * 0.01, 
                  ), */
                  Row(
                    children: [
                      SizedBox(
                        width: myWidth * 0.05,
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2)),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                Colors.grey.withOpacity(0.8),
                              )),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Navbar()));
                              },
                              child: Text(
                                'Home',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: myWidth * 0.05,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: myHeight * 0.01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey,
                          ),
                          child: Image.asset(
                            'assets/icons/3.1.png',
                            height: myHeight * 0.025,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: myWidth * 0.05,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
    // }
    /*   Row(
                    children: [
                      SizedBox(
                        width: myWidth * 0.05,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: myHeight * 0.01),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amber),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 20),
                              Text(
                                'Add to portfolio',
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: myWidth * 0.05,
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: myHeight * 0.01),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child: Image.asset(
                              'assets/icons/3.1.png',
                              height: myHeight * 0.025,
                              color: Colors.black,
                            ),
                          )),
                      SizedBox(
                        width: myWidth * 0.05,
                      ),
                    ],
                  )************************************************** */
    //Tabletler de ve webde bu kısmı açarsın
    /*    else {
      return SafeArea(
        child: Scaffold(
            body: Container(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: myWidth * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(children: [
                      Container(
                          color: Colors.greenAccent,
                          height: myHeight * 0.09,
                          child: Image.network(widget.selectItem.image ?? '')),
                      SizedBox(
                        width: myWidth * 0.06,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectItem.id.toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: myHeight * 0.001,
                          ),
                          Text(
                            widget.selectItem.symbol.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            '\$' +
                                widget.selectItem.currentPrice!
                                    .toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black)),
                        SizedBox(
                          height: myHeight * 0.01,
                        ),
                        Text(
                          widget.selectItem.marketCapChangePercentage24H!
                                  .toStringAsFixed(3) +
                              '%',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: widget.selectItem
                                          .marketCapChangePercentage24H! >=
                                      0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),

              Expanded(
                  child: Container(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: myWidth * 0.03,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Low',
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                              SizedBox(
                                height: myHeight * 0.001,
                              ),
                              Text(widget.selectItem.low24H!.toStringAsFixed(1),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('High',
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                              SizedBox(
                                height: myHeight * 0.001,
                              ),
                              Text(
                                  '\$' +
                                      widget.selectItem.high24H!
                                          .toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Vol',
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.grey)),
                              SizedBox(
                                height: myHeight * 0.001,
                              ),
                              Text(
                                  widget.selectItem.totalVolume!
                                          .toStringAsFixed(2) +
                                      'M',
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.005,
                    ),
                    //Bu container de Sayfanın Grafik kısmı
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: myWidth * 0.008),
                      child: Container(
                        height: myHeight * 0.5,
                        width: myWidth,
                        child: Refresh == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffdddd00),
                                ),
                              )
                            : itemChart == null
                                ? Padding(
                                    padding: EdgeInsets.all(myHeight * 0.06),
                                    child: Center(
                                      child: Text(
                                        'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                : SfCartesianChart(
                                    trackballBehavior: trackballBehavior,
                                    zoomPanBehavior: ZoomPanBehavior(
                                      enablePinching: true,
                                      zoomMode: ZoomMode.x,
                                    ),
                                    series: <CandleSeries>[
                                      CandleSeries<ChartModel, int>(
                                        enableSolidCandles: true,
                                        enableTooltip: true,
                                        bullColor: Colors.green,
                                        bearColor: Colors.red,
                                        dataSource: itemChart!,
                                        xValueMapper: (ChartModel sales, _) =>
                                            sales.time,
                                        lowValueMapper: (ChartModel sales, _) =>
                                            sales.low,
                                        highValueMapper:
                                            (ChartModel sales, _) => sales.high,
                                        openValueMapper:
                                            (ChartModel sales, _) => sales.open,
                                        closeValueMapper:
                                            (ChartModel sales, _) =>
                                                sales.close,
                                        animationDuration: 55,
                                      ),
                                    ],
                                  ),
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.01,
                    ),
                    //Bu container sayfanın D,W,M,3M vs liste kısmı Olan kısım
                    Center(
                      child: Container(
                        height: myHeight * 0.06,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: text.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: myWidth * 0.03),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      textBool = [
                                        false,
                                        false,
                                        false,
                                        false,
                                        false,
                                        false,
                                      ];

                                      textBool[index] = true;
                                    });
                                    setDays(text[index]);
                                    getChart();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: myWidth * 0.03,
                                        vertical: myHeight * 0.003),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: textBool[index] == true
                                            ? Colors.amber.withOpacity(0.5)
                                            : Colors.transparent),
                                    child: Text(
                                      text[index],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.03,
                    ),

                    //Bu Container kısım Sayfanı News haber kısmı
                    Expanded(
                      child: Container(
                        height: myHeight * 0.6,
                        child: Scrollbar(
                          thickness: 10,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: myWidth * 0.06),
                                    child: Center(
                                      child: Text(
                                        'News',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: myWidth * 0.03,
                                              vertical: myHeight * 0.01),
                                          child: Expanded(
                                            child: Text(
                                              'Trumps speeches at the Bitcoin 2024 conference certainly made their mark this month. All these developments and much more contributed to volatility in the price of Bitcoin Trumps speeches at the Bitcoin 2024 conference certainly made their mark this month. All these developments and much more contributed to volatility in the price of BitcoinTrumps speeches at the Bitcoin 2024 conference certainly made their mark this month. All these developments and much more contributed to volatility in the price of BitcoinTrumps speeches at the Bitcoin 2024 conference certainly made their mark this month. All these developments and much more contributed to volatility in the price of Bitcoin',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: myWidth * 0.35,
                                        child: CircleAvatar(
                                          radius: myHeight * 0.09,
                                          backgroundImage:
                                              AssetImage('assets/image/11.PNG'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              )),

              //sayfanın en altında ki Add to portfolio ve icon container kısmı
            ],
          ),
        )),
      ) ;
    }*/
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textBool = [true, false, false, false, false, false];

  int days = 1;

  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'W') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;

  bool Refresh = false;

  Future<void> getChart() async {
    String url = 'https://api.coingecko.com/api/v3/coins/' +
        widget.selectItem.id +
        '/ohlc?vs_currency=usd&days=' +
        days.toString();

    setState(() {
      Refresh = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      Refresh = false;
    });
    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      debugPrint(response.statusCode.toString());
    }
  }
}

/*  SizedBox(
                  height: myHeight * 0.04,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: myWidth * 0.06),
                      child: Text(
                        'News',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: myWidth * 0.06,
                          vertical: myHeight * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                              textAlign: TextAlign.justify,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                            ),
                          ),
                          Container(
                            width: myWidth * 0.25,
                            child: CircleAvatar(
                              radius: myHeight * 0.04,
                              backgroundImage:
                                  AssetImage('assets/image/11.PNG'),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ))
              ],
            )),
            Container(
              height: myHeight * 0.1,
              width: myWidth,
              // color: Colors.amber,
              child: Column(
                children: [
                  Divider(),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: myWidth * 0.05,
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: myHeight * 0.015),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffFBC700)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: myHeight * 0.02,
                              ),
                              Text(
                                'Add to portfolio',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: myWidth * 0.05,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: myHeight * 0.012),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey.withOpacity(0.2)),
                          child: Image.asset(
                            'assets/icons/3.1.png',
                            height: myHeight * 0.03,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: myWidth * 0.05,
                      ),  */
