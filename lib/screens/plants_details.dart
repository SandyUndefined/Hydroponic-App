import 'package:flutter/material.dart';
import 'package:hydrophonic/models/plants.dart';

class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({required this.plant, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change back button color to white
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white, // Change title text color to white
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Image.asset(plant.imagePath, width: 100, height: 100),
            ),
            const SizedBox(height: 20),
            const Text(
              'Optimal Conditions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildGrowthStageTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthStageTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FlexColumnWidth(2.8),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(1.5),
        4: FlexColumnWidth(1.5),
        5: FlexColumnWidth(2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        _buildTableRow(
          'Stage',
          'Temp (°C)',
          'Humidity (%)',
          'pH',
          'EC (mS/cm)',
          'Light (µmol/m²/s)',
          isHeader: true,
        ),
        _buildTableRow('Germination', '15-20', '80-90', '5.5-6.0', '0.5-1.0',
            'Minimal, 100-200'),
        _buildTableRow('Early Seedling', '18-22', '70-80', '5.5-6.0', '0.8-1.2',
            '14-16 hrs, 100-200'),
        _buildTableRow('Late Seedling', '20', '50-60', '5.5-6.0', '1.2-1.8',
            '14-16 hrs, 100-200'),
        _buildTableRow('Vegetative', '18-24', '60-70', '5.5-6.0', '1.2-1.8',
            '14-16 hrs, 200-400'),
        _buildTableRow('Rapid Growth', '15-20', '50-70', '5.5-6.0', '1.5-2.0',
            '14-16 hrs, 300-450'),
        _buildTableRow('Maturation', '15-20', '50-70', '5.5-6.0', '1.5-2.0',
            '14-16 hrs, 300-450'),
        _buildTableRow(
            'Harvest', '15-20', '50-60', '5.5-6.0', '1.5-2.0', '14-16 hrs'),
      ],
    );
  }

  TableRow _buildTableRow(String stage, String temp, String humidity, String pH,
      String ec, String light,
      {bool isHeader = false}) {
    return TableRow(
      decoration: isHeader ? BoxDecoration(color: Colors.grey[300]) : null,
      children: [
        _buildTableCell(stage, isHeader: isHeader),
        _buildTableCell(temp, isHeader: isHeader),
        _buildTableCell(humidity, isHeader: isHeader),
        _buildTableCell(pH, isHeader: isHeader),
        _buildTableCell(ec, isHeader: isHeader),
        _buildTableCell(light, isHeader: isHeader),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.black : Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
