import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cotizacion_model.dart';
import '../core/services/supabase_service.dart';

class CotizacionesProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  List<CotizacionModel> _cotizaciones = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CotizacionModel> get cotizaciones => _cotizaciones;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  CotizacionesProvider() {
    fetchCotizaciones();
  }

  Future<void> fetchCotizaciones() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (_supabaseService.isReady) {
        final List<dynamic> response = await _supabaseService.client
            .from('cotizaciones')
            .select('*, cotizacion_items(*)')
            .order('creado_en', ascending: false);

        _cotizaciones = response.map((json) {
          final itemsList = (json['cotizacion_items'] as List<dynamic>?)
                  ?.map((i) => CotizacionItemModel.fromJson(i))
                  .toList() ??
              [];
          return CotizacionModel.fromJson(json, items: itemsList);
        }).toList();

        if (_cotizaciones.isNotEmpty) {
          _isLoading = false;
          notifyListeners();
          return;
        }
      }
    } catch (e) {
      print('Error fetching cotizaciones from Supabase: $e');
      _errorMessage = e.toString();
    }

    _loadSampleCotizaciones();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addCotizacion(CotizacionModel cotizacion) async {
    try {
      if (_supabaseService.isReady) {
        final inserted = await _supabaseService.client
            .from('cotizaciones')
            .insert(cotizacion.toJson())
            .select()
            .single();

        final cotId = inserted['id'];

        if (cotizacion.items.isNotEmpty) {
          final itemsToInsert = cotizacion.items.map((item) {
            final json = item.toJson();
            json['cotizacion_id'] = cotId;
            json.remove('id');
            return json;
          }).toList();

          await _supabaseService.client.from('cotizacion_items').insert(itemsToInsert);
        }

        await fetchCotizaciones();
        return true;
      }
    } catch (e) {
      print('Error inserting cotizacion: $e');
    }

    _cotizaciones.insert(0, cotizacion);
    notifyListeners();
    return true;
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
    ];
  }
}
