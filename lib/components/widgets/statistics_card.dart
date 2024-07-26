import 'package:flutter/material.dart';
import 'package:hydrophonic/services/thingspeak_service.dart';
import 'package:hydrophonic/components/widgets/statistics_table.dart';
import 'package:hydrophonic/components/widgets/gauge_widget.dart';
import 'package:hydrophonic/utils/color_palette.dart';

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
            color: ColorPalette.secondaryColor,
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
                return GaugeWidget(value: value, title: widget.title);
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
