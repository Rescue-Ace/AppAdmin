import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _alatLocations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAlatLocations();
  }

  Future<void> _fetchAlatLocations() async {
    try {
      final alatList = await _apiService.getAlatLocations();
      setState(() {
        _alatLocations = alatList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint("Error fetching alat locations: $e");
    }
  }

  void _showAlatDetails(Map<String, dynamic> alat) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Detail Alat: ${alat['id_alat']}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Alamat: ${alat['alamat']}"),
              Text("PIC 1: ${alat['nama_pic1']} (${alat['telp_pic1']})"),
              if (alat['nama_pic2'] != null)
                Text("PIC 2: ${alat['nama_pic2']} (${alat['telp_pic2']})"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAddAlatPage() {
    Navigator.pushNamed(context, '/add_alat');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hi ${widget.user['nama']}'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/editprofile');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.75, // 75% untuk peta
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox.expand(
                      child: FlutterMap(
                          options: const MapOptions(
                            initialCenter: LatLng(-7.282219, 112.794676), // Default center
                            initialZoom: 13.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token={accessToken}",
                              additionalOptions: const {
                                'accessToken': 'pk.eyJ1IjoibmFmaXNhcnlhZGkzMiIsImEiOiJjbTNoZTFqNjIwZDdhMmpxenhwNjR4d3drIn0.oqCkTqILhSAP5qNjKCkV2g',
                              },
                            ),
                            MarkerLayer(
                              markers: _alatLocations.map((alat) {
                                return Marker(
                                  point: LatLng(alat['latitude'], alat['longitude']),
                                  width: 30,
                                  height: 30,
                                  child: GestureDetector(
                                    onTap: () => _showAlatDetails(alat),
                                    child: Transform.translate(
                                      offset: const Offset(0, -10),
                                          child: const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 30,
                                      ),
                                    )
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                    ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _navigateToAddAlatPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4872B1),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Tambah Alat",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
