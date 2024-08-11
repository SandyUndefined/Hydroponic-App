import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrophonic/components/widgets/status_card.dart';
import 'package:hydrophonic/components/widgets/statistics_card.dart';
import 'package:hydrophonic/services/thingspeak_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

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
    const StatisticsTab(),
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
              title: const Text('Statistics')),
          FlashyTabBarItem(
              icon: const Icon(Icons.notifications),
              title: const Text('Alerts')),
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
  late Timer _timer;
  final PageController _pageController = PageController();

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
    _pageController.dispose();
    super.dispose();
  }

  void _fetchData() {
    setState(() {
      _data = _thingSpeakService.fetchCurrentData();
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
          final updateTime =
              data['Water Temperature']['time']; // Extract common update time
          final currentStatusData = [
            {
              'value': '${data['Water Temperature']['value']}°C',
              'label': 'Water Temperature'
            },
            {'value': '${data['TDS']['value']} PPM', 'label': 'TDS'},
            {'value': '${data['EC']['value']} uS/cm', 'label': 'EC'},
            {
              'value': '${data['Temperature']['value']}°C',
              'label': 'Temperature'
            },
            {
              'value': '${data['CO2 Concentration']['value']} PPM',
              'label': 'CO2'
            },
            {'value': '${data['Humidity']['value']}%', 'label': 'Humidity'},
            {
              'value': '${data['Light Intensity']['value']} Lux',
              'label': 'Light Intensity'
            },
            {
              'value': '${data['Water Level']['value']}%',
              'label': 'Water Level'
            },
          ];

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 18.0, left: 18.0, right: 18.0, bottom: 46.0),
                  child: PageView(
                    controller: _pageController,
                    children: [
                      StatusCard(
                          title: 'Structure A',
                          statusData: currentStatusData,
                          updateTime: updateTime),
                      StatusCard(
                          title: 'Structure B',
                          statusData: currentStatusData,
                          updateTime: updateTime),
                      // Add StatusCard widgets for C, D, E, F similarly
                      StatusCard(
                          title: 'Structure C',
                          statusData: currentStatusData,
                          updateTime: updateTime), // Just reusing for example
                      StatusCard(
                          title: 'Structure D',
                          statusData: currentStatusData,
                          updateTime: updateTime), // Just reusing for example
                      StatusCard(
                          title: 'Structure E',
                          statusData: currentStatusData,
                          updateTime: updateTime), // Just reusing for example
                      StatusCard(
                          title: 'Structure F',
                          statusData: currentStatusData,
                          updateTime: updateTime), // Just reusing for example
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SmoothPageIndicator(
                controller: _pageController,
                count: 6,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }
      },
    );
  }
}

class StatisticsTab extends StatelessWidget {
  const StatisticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          StatisticsCard(title: 'Water Temperature', field: 'field5'),
          StatisticsCard(title: 'TDS', field: 'field6'),
          StatisticsCard(title: 'EC', field: 'field7'),
          StatisticsCard(title: 'Temperature', field: 'field1'),
          StatisticsCard(title: 'CO2', field: 'field4'),
          StatisticsCard(title: 'Humidity', field: 'field2'),
          StatisticsCard(title: 'Light Intensity', field: 'field3'),
          StatisticsCard(title: 'Water Level', field: 'field8'),
        ],
      ),
    );
  }
}
