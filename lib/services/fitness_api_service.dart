import 'dart:convert';
import 'package:http/http.dart' as http;

class FitnessApiService {
  final String baseUrl =
      'https://api.fitness-tracker.com/data'; // Replace with the actual URL

  Future<Map<String, dynamic>> getFitnessData() async {
    // final response = await http.get(Uri.parse('$baseUrl/fitness'));

    // if (response.statusCode == 200) {
    //   return json.decode(response.body);
    // } else {
    //   throw Exception('Failed to load fitness data');
    // }
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return {
      'acceleration': 10.69,
      'heartRate': 69,
      'spo2': 99.69,
      'fallDetected': 0,
      // 'latitude': 69.214202,
      // 'longitude': 6.921420,
      'lastUpdated': "16:09"
    };
  }
}
