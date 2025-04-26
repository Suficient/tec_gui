import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tec_gui/widgets/pages/dashboard_page.dart';

class TecValuesCard extends StatefulWidget {
  const TecValuesCard({super.key});

  @override
  State<TecValuesCard> createState() => _TecValuesCardState();
}

class _TecValuesCardState extends State<TecValuesCard> {
  final List<ChartData> chartData = [ChartData('David', 25)];

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Row(
        children: [
          Spacer(),
          Card.outlined(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Consumer<TecModel>(
                    builder: (context, tec, child) {
                      return SfCircularChart(
                        series: <CircularSeries>[
                          RadialBarSeries<ChartData, double>(
                            dataSource: chartData,
                            xValueMapper:
                                (ChartData data, _) => tec.currentTemp,
                            yValueMapper: (ChartData data, _) => data.y,
                            cornerStyle: CornerStyle.bothCurve,
                            maximumValue: 50,
                            innerRadius: '70%',
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text("Temperature"),
              ],
            ),
          ),
          Card.outlined(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Consumer<TecModel>(
                    builder: (context, tec, child) {
                      return SfCircularChart(
                        series: <CircularSeries>[
                          RadialBarSeries<ChartData, double>(
                            dataSource: chartData,
                            xValueMapper:
                                (ChartData data, _) =>
                                    tec.currentTemp - tec.setpoint,
                            yValueMapper: (ChartData data, _) => data.y,
                            cornerStyle: CornerStyle.bothCurve,
                            maximumValue: 50,
                            innerRadius: '70%',
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text("Temp Deviation"),
              ],
            ),
          ),
          Card.outlined(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Consumer<TecModel>(
                    builder: (context, tec, child) {
                      return SfCircularChart(
                        series: <CircularSeries>[
                          RadialBarSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            cornerStyle: CornerStyle.bothCurve,
                            maximumValue: 50,
                            innerRadius: '70%',
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text("Current"),
              ],
            ),
          ),
          Card.outlined(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: SfCircularChart(
                    series: <CircularSeries>[
                      RadialBarSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        cornerStyle: CornerStyle.bothCurve,
                        maximumValue: 50,
                        innerRadius: '70%',
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
                Text("Voltage"),
              ],
            ),
          ),
          Card.outlined(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: SfCircularChart(
                    series: <CircularSeries>[
                      RadialBarSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        cornerStyle: CornerStyle.bothCurve,
                        maximumValue: 50,
                        innerRadius: '70%',
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
                Text("Power"),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
