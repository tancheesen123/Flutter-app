import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:workwise/Controller/PostInsightController.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Title Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '7-Day Click Bar Chart',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Chart Section
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
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
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
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
