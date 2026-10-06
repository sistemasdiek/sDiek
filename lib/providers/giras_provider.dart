import 'package:flutter/material.dart';
import '../models/gira_model.dart';
import '../core/services/supabase_service.dart';

class GirasProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  List<GiraModel> _giras = [];
  bool _isLoading = false;

  List<GiraModel> get giras => _giras;
  bool get isLoading => _isLoading;

  GirasProvider() {
    fetchGiras();
  }

  Future<void> fetchGiras() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_supabaseService.isReady) {
        final List<dynamic> response = await _supabaseService.client
            .from('giras')
            .select('*, gira_incidencias(*)')
            .order('created_at', ascending: false);

        _giras = response.map((json) {
          final incList = (json['gira_incidencias'] as List<dynamic>?)
                  ?.map((i) => GiraIncidenciaModel.fromJson(i))
                  .toList() ??
              [];
          return GiraModel.fromJson(json, incidencias: incList);
        }).toList();

        if (_giras.isNotEmpty) {
          _isLoading = false;
          notifyListeners();
          return;
        }
      }
    } catch (e) {
      print('Error fetching giras from Supabase: $e');
    }

    _loadSampleGiras();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addIncidencia(String giraId, String motorista, String tipo, String descripcion) async {
    try {
      if (_supabaseService.isReady) {
        await _supabaseService.client.from('gira_incidencias').insert({
          'gira_id': giraId,
          'motorista': motorista,
          'tipo': tipo,
          'descripcion': descripcion,
        });
        await fetchGiras();
        return;
      }
    } catch (e) {
      print('Error adding incidencia: $e');
    }

    final index = _giras.indexWhere((g) => g.id == giraId);
    if (index != -1) {
      final nuevaIncidencia = GiraIncidenciaModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        giraId: giraId,
        motorista: motorista,
        tipo: tipo,
        descripcion: descripcion,
        creadoEn: DateTime.now(),
      );
      _giras[index].incidencias.insert(0, nuevaIncidencia);
      notifyListeners();
    }
  }
}
