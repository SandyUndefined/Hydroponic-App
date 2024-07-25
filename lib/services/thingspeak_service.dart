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

  Map<String, String> _processField(String value, String timestamp) {
    final doubleValue = double.tryParse(value) ?? 0.0;
    final roundedValue = doubleValue.toStringAsFixed(1);

    final dateTime = DateTime.parse(timestamp)
        .toUtc()
        .add(const Duration(hours: 5, minutes: 30));
    final formattedTime =
        "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} AM Today";
    return {'value': roundedValue, 'time': formattedTime};
  }
}
