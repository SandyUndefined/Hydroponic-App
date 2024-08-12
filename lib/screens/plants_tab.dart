import 'package:flutter/material.dart';
import 'package:hydrophonic/models/plants.dart';
import 'package:hydrophonic/screens/plants_details.dart';

final List<Plant> plants = [
  Plant(
    name: 'Basil',
    imagePath: 'assets/images/basil.jpg',
    optimalConditions: 'Temperature: 20-25°C, Humidity: 50-60%',
    additionalData: {
      'Light Intensity': '1500-2000 lux',
      'pH Level': '5.5-6.5',
    },
  ),
  Plant(
    name: 'Lettuce',
    imagePath: 'assets/images/lettuce.jpg',
    optimalConditions: 'Temperature: 16-18°C, Humidity: 60-70%',
    additionalData: {
      'Light Intensity': '1200-1800 lux',
      'pH Level': '6.0-7.0',
    },
  ),
  // Add more plants as needed
];

class PlantsTab extends StatelessWidget {
  const PlantsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    PlantDetailScreen(plant: plant),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                // Background Image
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(plant.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Overlay with plant name
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.black54,
                    child: Text(
                      plant.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
