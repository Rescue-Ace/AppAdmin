import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddAlatScreen extends StatefulWidget {
  const AddAlatScreen({super.key});

  @override
  State<AddAlatScreen> createState() => _AddAlatScreenState();
}

class _AddAlatScreenState extends State<AddAlatScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  final TextEditingController _namaPic1Controller = TextEditingController();
  final TextEditingController _telpPic1Controller = TextEditingController();
  final TextEditingController _namaPic2Controller = TextEditingController();
  final TextEditingController _telpPic2Controller = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _telpAlatController = TextEditingController();
  final TextEditingController _linkMapController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  


  bool _isSubmitting = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      Map<String, dynamic> alatData = {
        "nama_pic1": _namaPic1Controller.text,
        "telp_pic1": _telpPic1Controller.text,
        "nama_pic2": _namaPic2Controller.text,
        "telp_pic2": _telpPic2Controller.text,
        "alamat": _alamatController.text,
        "telp": _telpAlatController.text,
        "link_maps": _linkMapController.text,
        "longitude": double.tryParse(_longitudeController.text),
        "latitude": double.tryParse(_latitudeController.text),
      };

      try {
        await _apiService.addAlat(alatData);
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Berhasil"),
              content: const Text("Alat berhasil ditambahkan."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text("Gagal menambahkan alat: $e"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF4872B1)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo2.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    "Tambah Alat",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4872B1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(_namaPic1Controller, "Nama PIC 1"),
                const SizedBox(height: 10),
                _buildTextField(_telpPic1Controller, "Nomor Telepon PIC 1"),
                const SizedBox(height: 10),
                _buildTextField(_namaPic2Controller, "Nama PIC 2"),
                const SizedBox(height: 10),
                _buildTextField(_telpPic2Controller, "Nomor Telepon PIC 2"),
                const SizedBox(height: 10),
                _buildTextField(_alamatController, "Alamat Alat"),
                const SizedBox(height: 10),
                _buildTextField(_telpAlatController, "Nomor Telepon Alat"),
                const SizedBox(height: 10),
                _buildTextField(_linkMapController, "Link Map"),
                const SizedBox(height: 10),
                _buildTextField(_longitudeController, "Longitude"),
                const SizedBox(height: 10),
                _buildTextField(_latitudeController, "Latitude"),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4872B1),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: _isSubmitting
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                        : const Text(
                            "Konfirmasi",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String labelText,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFF4872B1)),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA1BED6)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA1BED6), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$labelText wajib diisi";
        }
        return null;
      },
    );
  }
}
