import 'package:flutter/material.dart';
import '../models/empleado_model.dart';
import '../core/services/supabase_service.dart';

class AsistenciaProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  List<EmpleadoModel> _empleados = [];
  bool _isLoading = false;

  List<EmpleadoModel> get empleados => _empleados;
  bool get isLoading => _isLoading;

  AsistenciaProvider() {
    fetchEmpleados();
  }

  Future<void> fetchEmpleados() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_supabaseService.isReady) {
        final List<dynamic> response = await _supabaseService.client
            .from('empleados')
            .select()
            .order('nombre_completo', ascending: true);

        _empleados = response.map((json) => EmpleadoModel.fromJson(json)).toList();

        if (_empleados.isNotEmpty) {
          _isLoading = false;
          notifyListeners();
          return;
        }
      }
    } catch (e) {
      print('Error fetching empleados from Supabase: $e');
    }

    _loadSampleEmpleados();
    _isLoading = false;
    notifyListeners();
  }
}
