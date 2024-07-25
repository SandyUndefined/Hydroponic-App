import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ThingSpeakService {
  final String baseUrl =
      'https://api.thingspeak.com/channels/2596664/feeds.json?api_key=0VF39GO8MHRYPGZC';

  Future<Map<String, dynamic>> fetchCurrentData() async {
    final response = await http.get(Uri.parse('$baseUrl&results=1'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final feeds = data['feeds'][0];
      return {
        'Temperature': _processField(feeds['field1'], feeds['created_at']),
        'Humidity': _processField(feeds['field2'], feeds['created_at']),
        'Light Intensity': _processField(feeds['field3'], feeds['created_at']),
        'CO2 Concentration':
            _processField(feeds['field4'], feeds['created_at']),
        'Water Temperature':
            _processField(feeds['field5'], feeds['created_at']),
        'TDS': _processField(feeds['field6'], feeds['created_at']),
        'EC': _processField(feeds['field7'], feeds['created_at']),
        'Water Level': _processField(feeds['field8'], feeds['created_at']),
      };
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Map<String, String>>> fetchHistoricalData(String field) async {
    final response =
        await http.get(Uri.parse('$baseUrl&results=20&average=5minutes'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final feeds = data['feeds'];
      return feeds.map<Map<String, String>>((feed) {
        final dateTime = DateTime.parse(feed['created_at'])
            .toUtc()
            .add(const Duration(hours: 5, minutes: 30));
        final formattedTime = DateFormat('h:mm a').format(dateTime);
        final value = double.tryParse(feed[field])?.toStringAsFixed(1) ?? '0.0';
        return {'time': formattedTime, 'value': value};
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Map<String, String> _processField(String value, String timestamp) {
    final doubleValue = double.tryParse(value) ?? 0.0;
    final roundedValue = doubleValue.toStringAsFixed(1);

    final dateTime = DateTime.parse(timestamp)
        .toUtc()
        .add(const Duration(hours: 5, minutes: 30));
    final formattedTime = DateFormat('h:mm a').format(dateTime);
    return {'value': roundedValue, 'time': '$formattedTime Today'};
  }
}
