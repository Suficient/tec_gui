import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:tec_gui/widgets/pages/dashboard_page.dart';
import 'package:tec_gui/widgets/pages/settings_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TecModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => 
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TEC Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent.shade400,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent.shade400,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _themeMode,
      home: const HomePage(title: 'TEC Dashboard'),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navbarIndex = 0;

  void changePage() {
    switch (_navbarIndex) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePage(title: "TEC Dashboard"),
          ),
        );

      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) => PopScope(
                  onPopInvokedWithResult: (didPop, result) => _navbarIndex = 1,
                  child: SettingsPage(),
                ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Row(
        children: [
          NavigationRail(
            onDestinationSelected: (int index) {
              setState(() {
                _navbarIndex = index;
                changePage();
              });
            },
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Iconsax.cpu4),
                selectedIcon: Icon(Iconsax.cpu5),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Iconsax.setting_2),
                selectedIcon: Icon(Iconsax.setting_2),
                label: Text("Settings"),
              ),
            ],
            selectedIndex: _navbarIndex,
            labelType: NavigationRailLabelType.all,
            groupAlignment: 0,
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: Dashboard()),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
