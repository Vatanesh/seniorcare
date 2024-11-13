import 'package:flutter/material.dart';
import 'package:smarttrack/services/fitness_api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? fitnessData;

  @override
  void initState() {
    super.initState();
    fetchFitnessData();
  }

  Future<void> fetchFitnessData() async {
    final data = await FitnessApiService().getFitnessData();
    setState(() {
      fitnessData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 145, 130),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(177, 16, 236, 229),
        title: const Text(
          'Statistics',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: fitnessData == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchFitnessData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 69),
                    _buildVitalSignsCard(),
                    const SizedBox(height: 16),
                    _buildFallDetectionCard(),
                    const SizedBox(height: 16),
                    _buildLocationTrackingCard(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildVitalSignsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vital Signs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildVitalSignItem(Icons.directions_run, 'Acceleration',
                    '${fitnessData?['acceleration'] ?? '---'} m/s²'),
                _buildVitalSignItem(Icons.favorite, 'Heart Rate',
                    '${fitnessData?['heartRate'] ?? '---'} BPM', Colors.red),
                _buildVitalSignItem(
                    Icons.air, 'SpO₂', '${fitnessData?['spo2'] ?? '---'}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalSignItem(IconData icon, String label, String value,
      [Color? valueColor]) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.blueAccent),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildFallDetectionCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fall Detection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.shield, size: 32, color: Colors.green),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fitnessData?['fallDetected'] == 0
                            ? 'No fall detected'
                            : 'Fall detected',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: fitnessData?['fallDetected'] == 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Last updated: ${fitnessData?['lastUpdated'] ?? '---'}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationTrackingCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Location Tracking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLocationItem(
                    'Latitude', '${fitnessData?['latitude'] ?? '---'}'),
                _buildLocationItem(
                    'Longitude', '${fitnessData?['longitude'] ?? '---'}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
