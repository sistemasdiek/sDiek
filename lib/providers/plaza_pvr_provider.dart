import 'package:flutter/material.dart';
import '../models/pvr_inquilino_model.dart';

class PlazaPvrProvider extends ChangeNotifier {
  List<PvrInquilinoModel> _inquilinos = [];
  bool _isLoading = false;

  List<PvrInquilinoModel> get inquilinos => _inquilinos;
  bool get isLoading => _isLoading;

  double get totalArrendamiento => _inquilinos.fold(0.0, (sum, i) => sum + i.arrendamiento);
  double get totalMantenimiento => _inquilinos.fold(0.0, (sum, i) => sum + i.mantenimiento);
  double get totalMensualidad => _inquilinos.fold(0.0, (sum, i) => sum + i.totalMensual);

  PlazaPvrProvider() {
    _loadSampleInquilinos();
  }

  void _loadSampleInquilinos() {
    _inquilinos = [
      PvrInquilinoModel(
        id: 'pvr-01',
        numero: 101,
        nombre: 'Farmacias Siman',
        razonSocial: 'Comercial Siman Hn S.A.',
        rtn: '08011995882190',
        local: 'Local A-1 (Planta Baja)',
        arrendamiento: 45000.0,
        mantenimiento: 8500.0,
        energiaDefault: 12000.0,
        saldoInicial: 0.0,
      ),
      PvrInquilinoModel(
        id: 'pvr-02',
        numero: 102,
        nombre: 'Expresso Americano',
        razonSocial: 'Cafe Gourmet de Honduras',
        rtn: '08011990443120',
        local: 'Kiosco K-02',
        arrendamiento: 28000.0,
        mantenimiento: 4200.0,
        energiaDefault: 6500.0,
        saldoInicial: 0.0,
      ),
      PvrInquilinoModel(
        id: 'pvr-03',
        numero: 103,
        nombre: 'Banco Ficohsa Agente Auto',
        razonSocial: 'Grupo Financiero Ficohsa',
        rtn: '08011994112098',
        local: 'Local B-4',
        arrendamiento: 62000.0,
        mantenimiento: 11000.0,
        energiaDefault: 15400.0,
        saldoInicial: 0.0,
      ),
    ];
  }
}
