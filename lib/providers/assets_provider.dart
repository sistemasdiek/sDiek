import 'package:flutter/material.dart';
import '../models/asset_models.dart';
import '../core/services/supabase_service.dart';

class AssetsProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  List<DispositivoModel> _dispositivos = [];
  List<TintaModel> _tintas = [];
  List<CamionModel> _camiones = [];
  bool _isLoading = false;

  List<DispositivoModel> get dispositivos => _dispositivos;
  List<TintaModel> get tintas => _tintas;
  List<CamionModel> get camiones => _camiones;
  bool get isLoading => _isLoading;

  AssetsProvider() {
    fetchAssets();
  }

  Future<void> fetchAssets() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_supabaseService.isReady) {
        final List<dynamic> dispRes = await _supabaseService.client.from('dispositivos').select();
        _dispositivos = dispRes.map((json) => DispositivoModel.fromJson(json)).toList();

        final List<dynamic> tintRes = await _supabaseService.client.from('tintas').select();
        _tintas = tintRes.map((json) => TintaModel.fromJson(json)).toList();

        final List<dynamic> camRes = await _supabaseService.client.from('camiones').select();
        _camiones = camRes.map((json) => CamionModel.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error fetching assets from Supabase: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
