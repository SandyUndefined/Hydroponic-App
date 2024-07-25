import 'package:flutter/material.dart';
import 'package:hydrophonic/utils/color_palette.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final List<Map<String, String>> statusData;

  const StatusCard({
    Key? key,
    required this.title,
    required this.statusData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: ColorPalette.secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: statusData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio:
                    2.0, // Adjusted the aspect ratio to increase height
              ),
              itemBuilder: (context, index) {
                final data = statusData[index];
                final labelParts = data['label']!.split('\n');
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        data['value']!,
                        style: const TextStyle(
                          color: ColorPalette.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Flexible(
                      child: Text(
                        labelParts[0], // The label part
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: ColorPalette.secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold, // Bold the label
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        labelParts[1], // The time part
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: ColorPalette.secondaryColor,
                          fontSize: 14,
                          fontWeight:
                              FontWeight.normal, // Normal weight for time
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
