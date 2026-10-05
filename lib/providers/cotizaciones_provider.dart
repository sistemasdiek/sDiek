import 'package:flutter/material.dart';
import '../models/cotizacion_model.dart';

class CotizacionesProvider extends ChangeNotifier {
  List<CotizacionModel> _cotizaciones = [];
  bool _isLoading = false;

  List<CotizacionModel> get cotizaciones => _cotizaciones;
  bool get isLoading => _isLoading;

  CotizacionesProvider() {
    _loadSampleCotizaciones();
  }

  void _loadSampleCotizaciones() {
    _cotizaciones = [
      CotizacionModel(
        id: 'cot-001',
        numero: 'COT-2026-0842',
        nombreCliente: 'Comercial La Economica S.A.',
        cardCode: 'C100452',
        rtn: '08011990123456',
        creadoPor: 'Carlos Mendoza (Vendedor)',
        creadoEn: DateTime.now().subtract(const Duration(hours: 3)),
        items: [
          CotizacionItemModel(
            id: 'item-1',
            cotizacionId: 'cot-001',
            itemCode: 'TRAM-001',
            itemName: 'Juego de Herramientas Tramontina Pro 42 Pzs',
            cantidad: 10,
            precioUnitario: 1250.0,
          ),
          CotizacionItemModel(
            id: 'item-2',
            cotizacionId: 'cot-001',
            itemCode: 'FANAL-800',
            itemName: 'Cerradura de Alta Seguridad Fanal Cromada',
            cantidad: 25,
            precioUnitario: 480.0,
          ),
        ],
      ),
      CotizacionModel(
        id: 'cot-002',
        numero: 'COT-2026-0843',
        nombreCliente: 'Ferretería El Sol',
        cardCode: 'C100889',
        rtn: '05011985678912',
        creadoPor: 'Ana Lucia Torres',
        creadoEn: DateTime.now().subtract(const Duration(hours: 8)),
        items: [
          CotizacionItemModel(
            id: 'item-3',
            cotizacionId: 'cot-002',
            itemCode: 'GATO-300',
            itemName: 'Gato Hidráulico Tipo Causal 3 Toneladas',
            cantidad: 5,
            precioUnitario: 2100.0,
          ),
        ],
      ),
    ];
  }

  void addCotizacion(CotizacionModel cotizacion) {
    _cotizaciones.insert(0, cotizacion);
    notifyListeners();
  }
}
