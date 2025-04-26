import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tec_gui/main.dart';
import 'package:tec_gui/widgets/pages/dashboard_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                Text("Use Dark Mode"),
                Padding(padding: EdgeInsets.symmetric(horizontal: 120)),
                Switch(value: _darkMode, onChanged:(value) {
                  _darkMode = !_darkMode;
                  if (_darkMode) {
                    MyApp.of(context).changeTheme(ThemeMode.dark);
                  }
                  if (!_darkMode) {
                    MyApp.of(context).changeTheme(ThemeMode.light);
                  }
                },),
                Spacer()
              ],
            ),
            Divider(),
            Row(
              children: [
                Spacer(),
                Text("Change Temperature Unit:"),
                Padding(padding: EdgeInsets.symmetric(horizontal: 12)),
                MenuBar(children: [MenuItemButton(child: Text("Celcius (°C)"),), MenuItemButton(child: Text("Farenheit (°F)"),)]),
                Spacer(),
              ],
            ),
            Padding(padding: EdgeInsets.all(8)),
            Row(
              children: [
                Spacer(),
                Text("Graph X Axis Range:"),
                Padding(padding: EdgeInsets.symmetric(horizontal: 120)),
                SizedBox(width: 150,child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => Provider.of<TecModel>(context, listen: false).axisRange = int.parse(value),),),
                Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }
}