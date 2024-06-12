import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../resources/app_resources.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ApplyInsightLineChart extends StatefulWidget {
  const ApplyInsightLineChart({Key? key}) : super(key: key);

  @override
  _ApplyInsightLineChartState createState() => _ApplyInsightLineChartState();
}

class _ApplyInsightLineChartState extends State<ApplyInsightLineChart> {
  String? _tappedBarValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Bar Chart Example'),
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
                SalesData('Jan', 0),
                SalesData('Feb', 4),
                SalesData('Mar', 1),
                SalesData('Apr', 100),
                SalesData('May', 32),
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
