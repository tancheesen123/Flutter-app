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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clicks Bar Chart Example'),
      ),
      body: FutureBuilder<List<SalesData>>(
        future: postInsightController
            .getLast7DaysClicksData(widget.postInsightData),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading clicks data"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No clicks data available"));
          } else {
            List<SalesData> salesData = snapshot.data!;
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
