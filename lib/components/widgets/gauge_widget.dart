import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatelessWidget {
  final double value;
  final String title;
  final ranges;
  final min;
  final max;

  const GaugeWidget({
    Key? key,
    required this.value,
    required this.title,
    this.ranges,
    this.min,
    this.max,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Set the desired width
      height: 200, // Set the desired height
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: min,
            maximum: max,
            ranges: ranges,
            pointers: <GaugePointer>[
              NeedlePointer(
                value: value,
                needleLength: 0.5, // Adjust the length of the needle
                needleStartWidth: 2, // Adjust the width of the needle
                needleEndWidth: 4, // Adjust the width of the needle
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Container(
                  child: Text(
                    value.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 20,
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
      ),
    );
  }
}
