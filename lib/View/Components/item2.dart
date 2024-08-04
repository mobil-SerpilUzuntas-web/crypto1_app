import 'package:flutter/material.dart';
import 'package:http/http.dart';

//Re
class Item2 extends StatelessWidget {
  final dynamic item;

  Item2({super.key, this.item});
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: myWidth * 0.03, vertical: myHeight * 0.02),
      child: Container(
        //Sliderlerin bulundugu Container
        padding: EdgeInsets.only(
            left: myWidth * 0.02,
            right: myWidth * 0.02,
            top: myHeight * 0.01,
            bottom: myHeight * 0.01),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                // Resmin yüksekliğini buradan ayarlayabilirsiniz
                width: myWidth * 0.06,
                decoration: BoxDecoration(
                  // İsteğe bağlı: köşeleri yuvarlatmak için
                  image: DecorationImage(
                    image: NetworkImage(item.image),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: myWidth * 0.2,
              height: myHeight * 0.01,
            ),
            Text(
              item.id,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            /*   Row(
              children: [
                Text(
                  item.priceChange24H.toString().contains('-')
                      ? "-\$" +
                          item.priceChange24H
                              .toStringAsFixed(2)
                              .toString()
                              .replaceAll('-', '')
                      : "\$" + item.priceChange24H.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
                SizedBox( 
                  width: myWidth * 0.03,
                ),
                Text(
                  item.marketCapChangePercentage24H.toStringAsFixed(3) + '%',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: item.marketCapChangePercentage24H >= 0
                          ? Colors.green
                          : Colors.red),
                ),
              ],
            ) */
          ],
        ),
      ),
    );
  }
}
