import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:hydrophonic/components/widgets/status_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabItems = [
    HomeTab(),
    const Center(child: Text("Plants")),
    const Center(child: Text("Statistics")),
    const Center(child: Text("Alerts"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydroponic Plant Data'),
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

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStatusData = [
      {'value': '22°C', 'label': 'Water Temperature\n2:15 PM Today'},
      {'value': '750', 'label': 'TDS\n2:20 PM Today'},
      {'value': '1.5', 'label': 'EC\n2:25 PM Today'},
      {'value': '25°C', 'label': 'Temperature\n2:30 PM Today'},
      {'value': '400', 'label': 'CO2\n2:35 PM Today'},
      {'value': '60%', 'label': 'Humidity\n2:40 PM Today'},
      {'value': '1000 lux', 'label': 'Light Intensity\n2:45 PM Today'},
      {'value': '75%', 'label': 'Water Level\n2:50 PM Today'},
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
}
