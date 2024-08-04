import 'package:crypto1_app/View/selected_Item.dart';
import 'package:crypto1_app/model/coinModel';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final CoinModel item;

  Item({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: myWidth * 0.02, vertical: myHeight * 0.02),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectedItem(selectItem: item)));
        },
        child: Container(
          child: Row(
            children: [
         


              Expanded(
                flex: 1,
                child: Column(
                  children: [Image.network(item.image ?? '')],
                ),
              ),
              SizedBox(
                width: myWidth * 0.03,
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.id ?? '',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      '\$' + item.currentPrice.toString(),
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
                          color: item.marketCapChangePercentage24H! >= 0
                              ? Colors.green
                              : Colors.red
                              ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: myWidth * 0.01,
                        ),
                        child: Text(
                          item.marketCapChangePercentage24H.toString() + '%',
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
      ),
    );
  }
}



