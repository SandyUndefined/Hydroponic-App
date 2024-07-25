import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:hydrophonic/components/widgets/status_card.dart';
import 'package:hydrophonic/services/thingspeak_service.dart';
import 'dart:async'; // Import the dart:async package for Timer

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabItems = [
    const HomeTab(),
    const Center(child: Text("Plants")),
    const Center(child: Text("Statistics")),
    const Center(child: Text("Alerts"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydroponic'),
      ),
      body: _tabItems[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        iconSize: 30,
        showElevation: false, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.local_florist),
            title: const Text('Plants'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.bar_chart),
            title: const Text('Statistics'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.notifications),
            title: const Text('Alerts'),
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final ThingSpeakService _thingSpeakService = ThingSpeakService();
  late Future<Map<String, dynamic>> _data;
  late Timer _timer; // Timer to refresh data

  @override
  void initState() {
    super.initState();
    _fetchData();
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      _fetchData();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _fetchData() {
    setState(() {
      _data = _thingSpeakService.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          final data = snapshot.data!;
          final currentStatusData = [
            {
              'value': '${data['Water Temperature']['value']}°C',
              'label': 'Water Temperature\n${data['Water Temperature']['time']}'
            },
            {
              'value': '${data['TDS']['value']}',
              'label': 'TDS\n${data['TDS']['time']}'
            },
            {
              'value': '${data['EC']['value']}',
              'label': 'EC\n${data['EC']['time']}'
            },
            {
              'value': '${data['Temperature']['value']}°C',
              'label': 'Temperature\n${data['Temperature']['time']}'
            },
            {
              'value': '${data['CO2 Concentration']['value']}',
              'label': 'CO2\n${data['CO2 Concentration']['time']}'
            },
            {
              'value': '${data['Humidity']['value']}%',
              'label': 'Humidity\n${data['Humidity']['time']}'
            },
            {
              'value': '${data['Light Intensity']['value']} lux',
              'label': 'Light Intensity\n${data['Light Intensity']['time']}'
            },
            {
              'value': '${data['Water Level']['value']}%',
              'label': 'Water Level\n${data['Water Level']['time']}'
            },
          ];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                StatusCard(
                  title: 'Current Status',
                  statusData: currentStatusData,
                ),
                // Add more StatusCard widgets or other widgets here
              ],
            ),
          );
        }
      },
    );
  }
}
