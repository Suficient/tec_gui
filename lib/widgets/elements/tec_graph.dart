import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:core';

import 'package:tec_gui/utils/pid_sim.dart';
import 'package:tec_gui/widgets/pages/dashboard_page.dart';


class TecGraph extends StatefulWidget {
  const TecGraph({super.key});

  @override
  State<TecGraph> createState() => _TecGraphState();
}

class _TecGraphState extends State<TecGraph> {

  int _setPoint = 25;
  bool _isTempDisplayed = true;
  bool _isTempDeviationDisplayed = true;
  bool _isCurrentDisplayed = true;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("WidgetsBinding");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Consumer<TecModel>(
              builder: (context, tec, child) {
              return SfCartesianChart(
                primaryXAxis: NumericAxis(autoScrollingDelta: 100,),
                title: ChartTitle(text: "TEC Sensor Data"),
                zoomPanBehavior: ZoomPanBehavior(
                  enableMouseWheelZooming: true,
                  zoomMode: ZoomMode.x,
                  enablePanning: true,                                            
                ), 
                series: <CartesianSeries>[
                  if (_isTempDisplayed) ...[LineSeries<ChartData, double>(
                    dataSource: tec.tempData,
                    xValueMapper: (ChartData data, _) => data.time,
                    yValueMapper: (ChartData data, _) => data.value,
                  )],
                  if (_isTempDeviationDisplayed) ...[LineSeries<ChartData, double>(
                    dataSource: tec.tempDeviationData,
                    xValueMapper: (ChartData data, _) => data.time,
                    yValueMapper: (ChartData data, _) => data.value,
                  )],
                  if (_isCurrentDisplayed) ...[LineSeries<ChartData, double>(
                    dataSource: tec.currentData,
                    xValueMapper: (ChartData data, _) => data.time,
                    yValueMapper: (ChartData data, _) => data.value,
                  )],
                ],
              );},
            ),
          ),
          Row(
            children: [
              Spacer(),
              Text("Temperature"),
              Checkbox(
                value: _isTempDisplayed,
                onChanged: (bool? value) {
                  setState(() {
                    _isTempDisplayed = value!;
                  });
                }
              ),
              Spacer(),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Text('Show Temperature Deviation'),
              Checkbox(
                value: _isTempDeviationDisplayed,
                onChanged: (bool? value) {
                  setState(() {
                    _isTempDeviationDisplayed = value!;
                  });
                }
              ),
              Spacer(),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Text('Show Current'),
              Checkbox(
                value: _isCurrentDisplayed,
                onChanged: (bool? value) {
                  setState(() {
                    _isCurrentDisplayed = value!;
                  });
                }
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}