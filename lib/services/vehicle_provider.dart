import 'package:flutter/material.dart';
import 'api_service.dart';

class VehicleProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<dynamic> _vehicles = [];

  List<dynamic> get vehicles => _vehicles;

  Future<void> fetchVehicles() async {
    try {
      _vehicles = await _apiService.getVehicles();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createVehicle(Map<String, String> vehicleData) async {
    try {
      await _apiService.createVehicle(vehicleData);
      await fetchVehicles();
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getVehicleDetails(int vehicleId) async {
    try {
      return await _apiService.getVehicleDetails(vehicleId);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteVehicle(int vehicleId) async {
    try {
      await _apiService.deleteVehicle(vehicleId);
      await fetchVehicles();
    } catch (error) {
      rethrow;
    }
  }
}
