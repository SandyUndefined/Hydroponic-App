import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControlsTab extends StatefulWidget {
  const ControlsTab({super.key});

  @override
  _ControlsTabState createState() => _ControlsTabState();
}

class _ControlsTabState extends State<ControlsTab> {
  int _temperature = 22; // Initial temperature for AC control
  int _humidity = 90;
  int _selectedWaterAmount = 5; // Initial selected water amount
  String _selectedChemical = "Ammonia";

  void _increaseTemperature() {
    setState(() {
      _temperature++;
    });
  }

  void _decreaseTemperature() {
    setState(() {
      _temperature--;
    });
  }

  void _increaseHumidity() {
    setState(() {
      _humidity++;
    });
  }

  void _decreaseHumidity() {
    setState(() {
      _humidity--;
    });
  }




  void _selectWaterAmount(int amount) {
    setState(() {
      _selectedWaterAmount = amount;
    });
  }

  void _selectChemical(String chemical) {
    setState(() {
      _selectedChemical = chemical;
    });
  }

  void _addWater() {
    // Handle the "Add" button press, e.g., send the selected amount to an IoT device
    print('Adding $_selectedWaterAmount ml of water');
  }

  double _intensity = 50; // Initial intensity in lumens

  void _increaseIntensity() {
    setState(() {
      if (_intensity < 100) {
        _intensity += 10; // Increase by 10 lumens
      }
    });
  }

  void _decreaseIntensity() {
    setState(() {
      if (_intensity > 0) {
        _intensity -= 10; // Decrease by 10 lumens
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // AC Control Card
          Card(
            elevation: 5,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Temperature',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _decreaseTemperature,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        '$_temperature°C',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _increaseTemperature,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),


          Card(
            elevation: 5,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Humidity',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _decreaseHumidity,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        '$_humidity%',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _increaseHumidity,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),



          // Water Plants Card
          Card(
            elevation: 5,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Water Plants',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildWaterBadge(5),
                      const SizedBox(width: 10),
                      _buildWaterBadge(10),
                      const SizedBox(width: 10),
                      _buildWaterBadge(20),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addWater,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),


          Card(
            elevation: 5,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add Chemicals',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildChemicalBadge("Ammonia"),
                      const SizedBox(width: 10),
                      _buildChemicalBadge("Nitrogen"),
                      const SizedBox(width: 10),
                      _buildChemicalBadge("Phosphorus"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addWater,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),



          Card(
            elevation: 5,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'pH',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _addWater,
                    child: const Text('Add a drop of neutralizer'),
                  ),
                ],
              ),
            ),
          ),


          Card(
            elevation: 5,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Lighting',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _decreaseIntensity,
                      ),
                      Text(
                        '${_intensity.toStringAsFixed(0)} lum',
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _increaseIntensity,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: LinearProgressIndicator(
                      value: _intensity / 100,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green.shade200,
                    ),
                  ),
                ],
              ),
            ),
          ),





        ],
      ),
    );
  }

  Widget _buildWaterBadge(int amount) {
    final bool isSelected = _selectedWaterAmount == amount;
    return ElevatedButton(
      onPressed: () => _selectWaterAmount(amount),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green.shade200 : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text('$amount ml'),
    );
  }

  Widget _buildChemicalBadge(String chemical) {
    final bool isSelected = _selectedChemical == chemical;
    return ElevatedButton(
      onPressed: () => _selectChemical(chemical),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green.shade200 : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text('$chemical'),
    );
  }
}

