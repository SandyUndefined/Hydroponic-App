import 'package:flutter/material.dart';
import 'package:hydrophonic/components/widgets/statistics_card.dart';
import 'package:hydrophonic/models/structure.dart';

final List<Structure> structures = [
  Structure(name: 'Structure A', fields: {
    'Water Temperature': 'field5',
    'TDS': 'field6',
    'EC': 'field7',
    'Temperature': 'field1',
    'CO2': 'field4',
    'Humidity': 'field2',
    'Light Intensity': 'field3',
    'Water Level': 'field8',
  }),
  Structure(name: 'Structure B', fields: {
    'Water Temperature': 'field9',
    'TDS': 'field10',
    'EC': 'field11',
    'Temperature': 'field12',
    'CO2': 'field13',
    'Humidity': 'field14',
    'Light Intensity': 'field15',
    'Water Level': 'field16',
  }),
  // Add more structures as needed
];

class StatisticsDetailScreen extends StatelessWidget {
  final Structure structure;

  const StatisticsDetailScreen({required this.structure, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(structure.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: structure.fields.entries.map((entry) {
            return StatisticsCard(title: entry.key, field: entry.value);
          }).toList(),
        ),
      ),
    );
  }
}
