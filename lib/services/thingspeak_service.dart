import 'dart:convert';
import 'package:http/http.dart' as http;

class ThingSpeakService {
  final String baseUrl =
      'https://api.thingspeak.com/channels/2596664/feeds.json?api_key=0VF39GO8MHRYPGZC&results=1';

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final feeds = data['feeds'][0];
      return {
        'Temperature': {
          'value': feeds['field1'],
          'time': feeds['created_at'],
        },
        'Humidity': {
          'value': feeds['field2'],
          'time': feeds['created_at'],
        },
        'Light Intensity': {
          'value': feeds['field3'],
          'time': feeds['created_at'],
        },
        'CO2 Concentration': {
          'value': feeds['field4'],
          'time': feeds['created_at'],
        },
        'Water Temperature': {
          'value': feeds['field5'],
          'time': feeds['created_at'],
        },
        'TDS': {
          'value': feeds['field6'],
          'time': feeds['created_at'],
        },
        'EC': {
          'value': feeds['field7'],
          'time': feeds['created_at'],
        },
        'Water Level': {
          'value': feeds['field8'],
          'time': feeds['created_at'],
        },
      };
    } else {
      throw Exception('Failed to load data');
    }
  }
}
