import 'package:flutter/material.dart';
import '../models/pvr_inquilino_model.dart';
import '../core/services/supabase_service.dart';

class PlazaPvrProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  List<PvrInquilinoModel> _inquilinos = [];
  bool _isLoading = false;

  List<PvrInquilinoModel> get inquilinos => _inquilinos;
  bool get isLoading => _isLoading;

  double get totalArrendamiento => _inquilinos.fold(0.0, (sum, i) => sum + i.arrendamiento);
  double get totalMantenimiento => _inquilinos.fold(0.0, (sum, i) => sum + i.mantenimiento);
  double get totalMensualidad => _inquilinos.fold(0.0, (sum, i) => sum + i.totalMensual);

  PlazaPvrProvider() {
    fetchInquilinos();
  }

  Future<void> fetchInquilinos() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_supabaseService.isReady) {
        final List<dynamic> response = await _supabaseService.client
            .from('pvr_inquilinos')
            .select()
            .eq('activo', true)
            .order('numero', ascending: true);

        _inquilinos = response.map((json) => PvrInquilinoModel.fromJson(json)).toList();

        if (_inquilinos.isNotEmpty) {
          _isLoading = false;
          notifyListeners();
          return;
        }
      }
    } catch (e) {
      print('Error fetching pvr_inquilinos from Supabase: $e');
    }

    _loadSampleInquilinos();
    _isLoading = false;
    notifyListeners();
  }
}
