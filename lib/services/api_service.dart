import 'dart:convert';
import 'package:http/http.dart' as http;
 

class ApiService {
  final String baseUrl = "https://app.guliva.io/api/v1";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return _processResponse(response);
  }

  Future<Map<String, dynamic>> signup(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    return _processResponse(response);
  }

  Future<Map<String, dynamic>> createVehicle(Map<String, String> vehicleData) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/vehicle/create'));
    vehicleData.forEach((key, value) {
      request.fields[key] = value;
    });
    var response = await request.send();
    return _processStreamedResponse(response);
  }

  Future<List<dynamic>> getVehicles() async {
    final response = await http.get(
      Uri.parse('$baseUrl/vehicle/all'),
      headers: {'Content-Type': 'application/json'},
    );
    return _processResponse(response)['data'];
  }

  Future<Map<String, dynamic>> getVehicleDetails(int vehicleId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/vehicle/id/$vehicleId'),
      headers: {'Content-Type': 'application/json'},
    );
    return _processResponse(response);
  }

  Future<void> deleteVehicle(int vehicleId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/vehicle/delete/id/$vehicleId'),
      headers: {'Content-Type': 'application/json'},
    );
    _processResponse(response);
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> _processStreamedResponse(http.StreamedResponse response) async {
    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      return jsonDecode(respStr);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
