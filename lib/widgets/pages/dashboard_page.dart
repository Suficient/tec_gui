import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tec_gui/utils/pid_sim.dart';
import 'package:tec_gui/widgets/elements/tec_graph.dart';
import 'package:tec_gui/widgets/elements/tec_settings_card.dart';
import 'package:tec_gui/widgets/elements/tec_values_card.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TecModel(),
      child: Consumer<TecModel>(
        builder: (context, tecModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: TecGraph()),
                    TecSettingsCard(),
                  ],
                ),
              ),
              SizedBox(height: 160, child: TecValuesCard())
            ],
          );
        },
      ),
    );
  }
}

class TecModel extends ChangeNotifier{
  List<ChartData> tempData = [
    ChartData(1, 1),
  ];
  List<ChartData> tempDeviationData = [
    ChartData(1, 1),
  ];
  List<ChartData> currentData = [
    ChartData(1, 1),   
  ];
  double Kp = 100;
  double Ki = 20.0;
  double Kd = 20.0;
  double setpoint = 20;
  double max = 500;
  double min = -500;

  double dt = 1.0;
  double currentTime = 0;
  double currentTemp = 25; //starting temp for simulation

  double thermalMass = 500;
  double h = 8.0;
  double A = 0.3;
  double P = 150;
  double tAmbient = 35;
  double tau = 0.5;

  double tempWindow = 10;
  double critGain = 0;

  int axisRange = 50;

  late PIDController pid = PIDController(Kp, Ki, Kd, setpoint, maxOutput: max, minOutput: min);

  TecModel() {
    // Start timer in constructor
    Timer.periodic(Duration(milliseconds: 100), (Timer t) => update());
  }

  update() {
    // Create new lists instead of modifying existing ones
    pid.setpoint = setpoint;
    pid.Kp = Kp;
    pid.Ki = Ki;
    pid.Kd = Kd;
    List<ChartData> newTempData = List.from(tempData);
    List<ChartData> newTempDeviationData = List.from(tempDeviationData);
    List<ChartData> newCurrentData = List.from(currentData);

    Map<String, dynamic> result = calcTemperatureChange(
      dt: dt, 
      pid: pid, 
      thermalMass: thermalMass,
      h: h,
      A: A,
      P: P,
      tAmbient: tAmbient,
      tau: tau,
      currentTemp: currentTemp,
      currentTime: currentTime,
      qCooler: 1.0);

    currentTime += 1;
    currentTemp = result['currentTemp'];

    newTempData.add(ChartData(currentTime, currentTemp));
    newTempDeviationData.add(ChartData(currentTime, setpoint - currentTemp));

    tempData = newTempData;
    tempDeviationData = newTempDeviationData;
    currentData = newCurrentData;


    notifyListeners();
  }
}

class ChartData {
  ChartData(this.time, this.value);
  final double time;
  final double value;
}
