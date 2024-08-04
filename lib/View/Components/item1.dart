//Buda farklı gönderim

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final dynamic item;
  Item({this.item});

  

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: myWidth * 0.02, vertical: myHeight * 0.02),
      child: Container(
        child: Row(
          children: [
            Expanded(
                flex: 1, child: Column(children: [Image.network(item.image)])),
            SizedBox(
              width: myWidth * 0.03,
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.id,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: myWidth * 0.01,
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                     '\$' + item.currentPrice.toStringAsFixed(2), 
                    style: TextStyle(
                        fontSize: 16,
                       fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: myWidth * 0.01,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: item.marketCapChangePercentage24H >= 0
                            ? Colors.green
                            : Colors.red),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: myWidth * 0.01,
                      ),
                      child: Text(
                        item.marketCapChangePercentage24H.toStringAsFixed(1) +
                            '%',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
