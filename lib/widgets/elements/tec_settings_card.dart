import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tec_gui/widgets/pages/dashboard_page.dart';

class TecSettingsCard extends StatefulWidget {
  const TecSettingsCard({super.key});

  @override
  State<TecSettingsCard> createState() => _TecSettingsCardState();
}

class _TecSettingsCardState extends State<TecSettingsCard> {
  double _setPoint = 0;
  double _Pshare = 0;
  double _Ishare = 0;
  double _Dshare = 0;

  void updateSimulation() {
    Provider.of<TecModel>(context, listen: false).setpoint = _setPoint;
    Provider.of<TecModel>(context, listen: false).Kp = _Pshare;
    Provider.of<TecModel>(context, listen: false).Ki = _Ishare;
    Provider.of<TecModel>(context, listen: false).Kd = _Dshare;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 400,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                children: [
                  Text("Set Temperature:"),
                  Spacer(),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {_setPoint = double.parse(value);},
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 15))
                ],
              ),
              Row(
                children: [
                  Text("Temperature Window:"),
                  Spacer(),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      onChanged: (value) => Provider.of<TecModel>(context, listen: false).tempWindow = double.parse(value),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 15))
                ],
              ),
              Row(
                children: [
                  Text("P Share:"),
                  Spacer(),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _Pshare = double.parse(value),
                    ),

                  ),
                  Padding(padding: EdgeInsets.only(left: 15))
                ],
              ),
              Row(
                children: [
                  Text("I Share:"),
                  Spacer(),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _Ishare = double.parse(value),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 15))
                ],
              ),
              Row(
                children: [
                  Text("D Share:"),
                  Spacer(),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _Dshare = double.parse(value),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 15))
                ],
              ),
              Row(
                children: [
                  Text("Critical Gain:"),
                  Spacer(),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      onChanged: (value) => Provider.of<TecModel>(context, listen: false).critGain = double.parse(value),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 15))
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Row(
                children: [
                  Spacer(),
                  ActionChip(label: const Text("Save Settings"), onPressed: updateSimulation,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  ActionChip(label: const Text("Set Default"), onPressed: () {}),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  ActionChip(label: const Text("Reset Settings"), onPressed: () {}),
                  Spacer(),
                ],
              ),
              Spacer()
            ],
          ),
      ),
    );
  }
}