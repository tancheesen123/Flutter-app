import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../resources/app_resources.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:workwise/Controller/PostInsightController.dart';

class ApplyInsightLineChart extends StatefulWidget {
  final Map<String, dynamic> postInsightData;
  final Map<String, int> totalValues;

  const ApplyInsightLineChart({
    Key? key,
    required this.postInsightData,
    required this.totalValues,
  }) : super(key: key);

  @override
  _ApplyInsightLineChartState createState() => _ApplyInsightLineChartState();
}

class _ApplyInsightLineChartState extends State<ApplyInsightLineChart> {
  final PostInsightController postInsightController =
      Get.put(PostInsightController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('7-Day Apply Bar Chart'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future:
            postInsightController.getLast7DaysApplyData(widget.postInsightData),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading clicks data"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No clicks data available"));
          } else {
            List<Map<String, dynamic>> clickData = snapshot.data!;
            List<SalesData> salesData = clickData.map((data) {
              return SalesData(data['date'], data['value'].toDouble());
            }).toList();
            return Center(
              child: SfCartesianChart(
                isTransposed: true,
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                series: <BarSeries<SalesData, String>>[
                  BarSeries<SalesData, String>(
                    dataSource: salesData,
                    xValueMapper: (SalesData sales, _) => sales.month,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);
  final String month;
  final double sales;
}
