import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;

  static List<LineSeries<SalesData, num>> getDefaultData() {
    final List<SalesData> chartData = [
      SalesData('Jan', 35),
      SalesData('Feb', 28),
      SalesData('Mar', 34),
      SalesData('Apr', 32),
      SalesData('May', 40),
    ];

    return [
      LineSeries<SalesData, num>(
        enableTooltip: true,
        dataSource: chartData,
        xValueMapper: (SalesData sales, _) => sales.yearIndex(),
        yValueMapper: (SalesData sales, _) => sales.sales,
        markerSettings: MarkerSettings(
          isVisible: true,
          height: 4,
          width: 4,
          shape: DataMarkerType.circle,
          borderWidth: 3,
          borderColor: Colors.red,
        ),
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelAlignment: ChartDataLabelAlignment.auto,
        ),
      ),
    ];
  }
}

extension on SalesData {
  int yearIndex() {
    switch (year) {
      case 'Jan':
        return 1;
      case 'Feb':
        return 2;
      case 'Mar':
        return 3;
      case 'Apr':
        return 4;
      case 'May':
        return 5;
      default:
        return 0;
    }
  }
}





/* import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.year, this.sales);
 List<SalesData> data = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40)
  ];
  final String year;
  final double sales;
  
  get y => null;
  
  get y4 => null;
  
  get y3 => null;

  static List<LineSeries<SalesData, num>> getDefaultData() {
    final bool isDataLabelVisible = true,
        isMarkerVisible = true,
        isTooltipVisible = true;
    double? lineWidth, markerWidth, markerHeight;
    final List<SalesData> chartData = <SalesData>[
      SalesData(DateTime(2005, 0, 1), 'India', 1.5, 21, 28, 680, 760),
      SalesData(DateTime(2006, 0, 1), 'China', 2.2, 24, 44, 550, 880),
      SalesData(DateTime(2007, 0, 1), 'USA', 3.32, 36, 48, 440, 788),
      SalesData(DateTime(2008, 0, 1), 'Japan', 4.56, 38, 50, 350, 560),
      SalesData(DateTime(2009, 0, 1), 'Russia', 5.87, 54, 66, 444, 566),
      SalesData(DateTime(2010, 0, 1), 'France', 6.8, 57, 78, 780, 650),
      SalesData(DateTime(2011, 0, 1), 'Germany', 8.5, 70, 84, 450, 800)
    ];
    return <LineSeries<SalesData, num>>[
      LineSeries<SalesData, num>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (SalesData sales, _) => sales.y,
          yValueMapper: (SalesData sales, _) => sales.y4,
          width: lineWidth ?? 2,
          markerSettings: MarkerSettings(
              isVisible: isMarkerVisible,
              height: markerWidth ?? 4,
              width: markerHeight ?? 4,
              shape: DataMarkerType.circle,
              borderWidth: 3,
              borderColor: Colors.red),
          dataLabelSettings: DataLabelSettings(
              isVisible: isDataLabelVisible,
              labelAlignment: ChartDataLabelAlignment.auto)),
      LineSeries<SalesData, num>(
          enableTooltip: isTooltipVisible,
          dataSource: chartData,
          width: lineWidth ?? 2,
          xValueMapper: (SalesData sales, _) => sales.y,
          yValueMapper: (SalesData sales, _) => sales.y3,
          markerSettings: MarkerSettings(
              isVisible: isMarkerVisible,
              height: markerWidth ?? 4,
              width: markerHeight ?? 4,
              shape: DataMarkerType.circle,
              borderWidth: 3,
              borderColor: Colors.black),
          dataLabelSettings: DataLabelSettings(
              isVisible: isDataLabelVisible,
              labelAlignment: ChartDataLabelAlignment.auto))
    ];
  }
}
 */