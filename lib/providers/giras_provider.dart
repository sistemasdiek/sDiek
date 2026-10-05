import 'package:flutter/material.dart';
import '../models/gira_model.dart';

class GirasProvider extends ChangeNotifier {
  List<GiraModel> _giras = [];
  bool _isLoading = false;

  List<GiraModel> get giras => _giras;
  bool get isLoading => _isLoading;

  GirasProvider() {
    _loadSampleGiras();
  }

  void _loadSampleGiras() {
    _giras = [
      GiraModel(
        id: 'gira-101',
        numero: 'GIRA-2026-041',
        numRemision: 'REM-9921',
        ayudante: 'Roberto Gomez',
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        estado: 'activa',
        incidencias: [
          GiraIncidenciaModel(
            id: 'inc-1',
            giraId: 'gira-101',
            motorista: 'Juan Perez',
            tipo: 'Tráfico San Pedro Sula',
            descripcion: 'Retraso de 30 min por construcción en Bulevar del Norte.',
            creadoEn: DateTime.now().subtract(const Duration(hours: 1)),
          ),
        ],
      ),
      GiraModel(
        id: 'gira-102',
        numero: 'GIRA-2026-042',
        numRemision: 'REM-9925',
        ayudante: 'Jose Martinez',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        estado: 'activa',
      ),
      GiraModel(
        id: 'gira-103',
        numero: 'GIRA-2026-039',
        numRemision: 'REM-9880',
        ayudante: 'Pedro Ramos',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        estado: 'completada',
      ),
    ];
  }

  void addIncidencia(String giraId, String motorista, String tipo, String descripcion) {
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
