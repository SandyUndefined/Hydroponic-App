import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatelessWidget {
  final double value;
  final String title;

  const GaugeWidget({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      title: GaugeTitle(
        text: title,
        textStyle: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 40,
          ranges: <GaugeRange>[
            GaugeRange(startValue: 0, endValue: 15, color: Colors.red),
            GaugeRange(startValue: 15, endValue: 25, color: Colors.green),
            GaugeRange(startValue: 25, endValue: 30, color: Colors.yellow),
            GaugeRange(startValue: 30, endValue: 40, color: Colors.red),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(value: value),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }
}
