import 'package:flutter/material.dart';
import 'package:hydrophonic/components/widgets/status_card.dart';
import 'package:hydrophonic/services/thingspeak_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

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
                      top: 18.0, left: 18.0, right: 18.0, bottom: 0.0),
                  child: PageView(
                    controller: _pageController,
                    children: [
                      StatusCard(
                        title: 'Structure A',
                        statusData: currentStatusData,
                        updateTime: updateTime,
                        videoUrl:
                            'https://drive.google.com/uc?export=download&id=1XqtA1-_ZzKGB9wyaOy8O69_HWmqRq8fr',
                        photoFolder:
                            'https://drive.google.com/uc?export=view&id=1L6jyEkNgPI4dFneC9ERnxTpJkMhjsRMN',
                      ),
                      StatusCard(
                        title: 'Structure B',
                        statusData: currentStatusData,
                        updateTime: updateTime,
                        videoUrl:
                            'https://drive.google.com/uc?export=download&id=1XqtA1-_ZzKGB9wyaOy8O69_HWmqRq8fr',
                        photoFolder:
                            'https://drive.google.com/uc?export=view&id=1L6jyEkNgPI4dFneC9ERnxTpJkMhjsRMN',
                      ),
                      // Add StatusCard widgets for C, D, E, F similarly
                      StatusCard(
                        title: 'Structure C',
                        statusData: currentStatusData,
                        updateTime: updateTime,
                        videoUrl:
                            'https://drive.google.com/uc?export=download&id=1XqtA1-_ZzKGB9wyaOy8O69_HWmqRq8fr',
                        photoFolder:
                            'https://drive.google.com/uc?export=view&id=1L6jyEkNgPI4dFneC9ERnxTpJkMhjsRMN',
                      ), // Just reusing for example
                      StatusCard(
                        title: 'Structure D',
                        statusData: currentStatusData,
                        updateTime: updateTime,
                        videoUrl:
                            'https://drive.google.com/uc?export=download&id=1XqtA1-_ZzKGB9wyaOy8O69_HWmqRq8fr',
                        photoFolder:
                            'https://drive.google.com/uc?export=view&id=1L6jyEkNgPI4dFneC9ERnxTpJkMhjsRMN',
                      ), // Just reusing for example
                      StatusCard(
                        title: 'Structure E',
                        statusData: currentStatusData,
                        updateTime: updateTime,
                        videoUrl:
                            'https://drive.google.com/uc?export=download&id=1XqtA1-_ZzKGB9wyaOy8O69_HWmqRq8fr',
                        photoFolder:
                            'https://drive.google.com/uc?export=view&id=1L6jyEkNgPI4dFneC9ERnxTpJkMhjsRMN',
                      ), // Just reusing for example
                      StatusCard(
                        title: 'Structure F',
                        statusData: currentStatusData,
                        updateTime: updateTime,
                        videoUrl:
                            'https://drive.google.com/uc?export=download&id=1XqtA1-_ZzKGB9wyaOy8O69_HWmqRq8fr',
                        photoFolder:
                            'https://drive.google.com/uc?export=view&id=1L6jyEkNgPI4dFneC9ERnxTpJkMhjsRMN',
                      ), // Just reusing for example
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
