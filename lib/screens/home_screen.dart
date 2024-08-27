import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:hydrophonic/screens/home_tab.dart';
import 'package:hydrophonic/screens/plants_tab.dart';
import 'package:hydrophonic/screens/statistics_tab.dart';

import 'controls_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabItems = [
    const HomeTab(),
    const PlantsTab(),
    const StatisticsTab(),
    const ControlsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydroponic'),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
              icon: const Icon(Icons.games_outlined),
              title: const Text('Controls')),
        ],
      ),
    );
  }
}
