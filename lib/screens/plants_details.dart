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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(plant.optimalConditions),
            const SizedBox(height: 20),
            const Text(
              'Additional Data:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: plant.additionalData.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text('${entry.key}: ${entry.value}'),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
