import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrophonic/components/widgets/statistics_card.dart';

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
