import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:workwise/Controller/PostInsightController.dart';

class ClickInsightLineChart extends StatefulWidget {
  final Map<String, dynamic> postInsightData;
  final Map<String, int> totalValues;

  const ClickInsightLineChart({
    Key? key,
    required this.postInsightData,
    required this.totalValues,
  }) : super(key: key);

  @override
  _ClickInsightLineChartState createState() => _ClickInsightLineChartState();
}

class _ClickInsightLineChartState extends State<ClickInsightLineChart> {
  final PostInsightController postInsightController =
      Get.put(PostInsightController());
  String? _tappedBarValue;

  @override
  Widget build(BuildContext context) {
    print("This is post Insight Data ${widget.postInsightData["clicks"]}");
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
                SalesData('Today', 40),
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
