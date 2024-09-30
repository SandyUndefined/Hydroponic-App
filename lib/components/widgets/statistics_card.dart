import 'package:flutter/material.dart';
import 'package:hydrophonic/services/thingspeak_service.dart';
import 'package:hydrophonic/components/widgets/statistics_table.dart';
import 'package:hydrophonic/components/widgets/gauge_widget.dart';
import 'package:hydrophonic/utils/color_palette.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StatisticsCard extends StatefulWidget {
  final String title;
  final String field;

  const StatisticsCard({
    Key? key,
    required this.title,
    required this.field,
  }) : super(key: key);

  @override
  _StatisticsCardState createState() => _StatisticsCardState();
}

class _StatisticsCardState extends State<StatisticsCard> {
  final ThingSpeakService _thingSpeakService = ThingSpeakService();
  bool _isExpanded = false;
  late Future<List<Map<String, String>>> _historicalData;
  late Future<Map<String, String>> _currentData;

  @override
  void initState() {
    super.initState();
    _historicalData = _thingSpeakService.fetchHistoricalData(widget.field);
    _currentData = _thingSpeakService.fetchCurrentDataField(widget.field);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: ExpansionTile(

        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          FutureBuilder<Map<String, String>>(
            future: _currentData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                final currentData = snapshot.data!;
                final value = double.parse(currentData['value']!);
                print(widget.field);

                List<GaugeRange> ranges = [];
                if (widget.field=="field5"){ //water temp
                  ranges = <GaugeRange>[
                    GaugeRange(startValue: 0, endValue: 10, color: Colors.red),
                    GaugeRange(startValue: 10, endValue: 15, color: Colors.yellow),
                    GaugeRange(startValue: 15, endValue: 25, color: Colors.green),
                    GaugeRange(startValue: 25, endValue: 30, color: Colors.yellow),
                    GaugeRange(startValue: 30, endValue: 40, color: Colors.red),
                  ];
                } else if (widget.field=="field6"){ //tds
                  ranges = <GaugeRange>[
                    GaugeRange(startValue: 500, endValue: 800, color: Colors.yellow),
                    GaugeRange(startValue: 800, endValue: 1500, color: Colors.green),
                    GaugeRange(startValue: 1500, endValue: 2000, color: Colors.yellow),
                  ];
                } else if (widget.field=="field7"){ //ec
                  ranges = <GaugeRange>[
                    GaugeRange(startValue: 0, endValue: 1, color: Colors.red),
                    GaugeRange(startValue: 1, endValue: 1.5, color: Colors.yellow),
                    GaugeRange(startValue: 1.5, endValue: 2, color: Colors.green),
                    GaugeRange(startValue: 2, endValue: 2.5, color: Colors.yellow),
                    GaugeRange(startValue: 2.5, endValue: 3, color: Colors.red),
                  ];
                } else if (widget.field=="field4"){ //co2
                  ranges = <GaugeRange>[
                    GaugeRange(startValue: 0, endValue: 300, color: Colors.red),
                    GaugeRange(startValue: 300, endValue: 500, color: Colors.yellow),
                    GaugeRange(startValue: 500, endValue: 800, color: Colors.green),
                    GaugeRange(startValue: 800, endValue: 1000, color: Colors.yellow),
                    GaugeRange(startValue: 1000, endValue: 1200, color: Colors.red),
                  ];
                } else if (widget.field=="field2"){ //humidity
                  ranges = <GaugeRange>[
                    GaugeRange(startValue: 0, endValue: 50, color: Colors.red),
                    GaugeRange(startValue: 50, endValue: 60, color: Colors.yellow),
                    GaugeRange(startValue: 60, endValue: 70, color: Colors.green),
                    GaugeRange(startValue: 70, endValue: 80, color: Colors.yellow),
                    GaugeRange(startValue: 80, endValue: 100, color: Colors.red),
                  ];
                } else if (widget.field=="field1"){ //temp
                  ranges = <GaugeRange>[
                    GaugeRange(startValue: 0, endValue: 10, color: Colors.red),
                    GaugeRange(startValue: 10, endValue: 15, color: Colors.yellow),
                    GaugeRange(startValue: 15, endValue: 25, color: Colors.green),
                    GaugeRange(startValue: 25, endValue: 30, color: Colors.yellow),
                    GaugeRange(startValue: 30, endValue: 40, color: Colors.red),
                  ];
                } else if (widget.field=="field3"){ //light
                  ranges = <GaugeRange>[
                    GaugeRange(startValue: 100, endValue: 200, color: Colors.red),
                    GaugeRange(startValue: 200, endValue: 300, color: Colors.yellow),
                    GaugeRange(startValue: 300, endValue: 450, color: Colors.green),
                    GaugeRange(startValue: 450, endValue: 500, color: Colors.yellow),
                    GaugeRange(startValue: 500, endValue: 700, color: Colors.red),
                  ];
                } else if (widget.field=="field8"){ //water level
                  ranges = <GaugeRange>[
                    GaugeRange(startValue: 0, endValue: 0.3, color: Colors.red),
                    GaugeRange(startValue: 0.3, endValue: 0.7, color: Colors.yellow),
                    GaugeRange(startValue: 0.7, endValue: 1, color: Colors.green),
                  ];
                }

                return GaugeWidget(value: value, title: widget.title, ranges: ranges, min: ranges[0].startValue, max: ranges.last.endValue,);
              }
            },
          ),
          FutureBuilder<List<Map<String, String>>>(
            future: _historicalData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                final data = snapshot.data!;
                return StatisticsTable(data: data, title: widget.title);
              }
            },
          ),
        ],
        onExpansionChanged: (isExpanded) {
          setState(() {
            _isExpanded = isExpanded;
          });
        },
      ),
    );
  }
}
