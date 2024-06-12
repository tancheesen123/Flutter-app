import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../resources/app_resources.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ClickInsightLineChart extends StatefulWidget {
  const ClickInsightLineChart({Key? key}) : super(key: key);

  @override
  _ClickInsightLineChartState createState() => _ClickInsightLineChartState();
}

class _ClickInsightLineChartState extends State<ClickInsightLineChart> {
  String? _tappedBarValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clicks Bar Chart Example'),
      ),
      body: Center(
        child: SfCartesianChart(
          // Rotate the axes for vertical bars
          isTransposed: true,
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          series: <BarSeries<SalesData, String>>[
            BarSeries<SalesData, String>(
              // Bind dataSource
              dataSource: <SalesData>[
                SalesData('Jan', 35),
                SalesData('Feb', 28),
                SalesData('Mar', 34),
                SalesData('Apr', 32),
                SalesData('May', 40),
              ],
              // Map data properties
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.sales,
              // Enable data labels
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);
  final String month;
  final double sales;
}
