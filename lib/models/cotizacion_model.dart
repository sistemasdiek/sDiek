class CotizacionItemModel {
  final String id;
  final String cotizacionId;
  final int orden;
  final String itemCode;
  final String itemName;
  final double cantidad;
  final double precioUnitario;
  final bool gravado;

  CotizacionItemModel({
    required this.id,
    required this.cotizacionId,
    this.orden = 0,
    required this.itemCode,
    required this.itemName,
    required this.cantidad,
    required this.precioUnitario,
    this.gravado = true,
  });

  double get subtotal => cantidad * precioUnitario;

  factory CotizacionItemModel.fromJson(Map<String, dynamic> json) {
    return CotizacionItemModel(
      id: json['id'] ?? '',
      cotizacionId: json['cotizacion_id'] ?? '',
      orden: json['orden'] ?? 0,
      itemCode: json['item_code'] ?? '',
      itemName: json['item_name'] ?? '',
      cantidad: (json['cantidad'] ?? 0.0).toDouble(),
      precioUnitario: (json['precio_unitario'] ?? 0.0).toDouble(),
      gravado: json['gravado'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cotizacion_id': cotizacionId,
      'orden': orden,
      'item_code': itemCode,
      'item_name': itemName,
      'cantidad': cantidad,
      'precio_unitario': precioUnitario,
      'gravado': gravado,
    };
  }
}

class CotizacionModel {
  final String id;
  final String numero;
  final String nombreCliente;
  final String? cardCode;
  final String? rtn;
  final String? direccion;
  final String? telefono;
  final String? departamento;
  final String? municipio;
  final String creadoPor;
  final DateTime creadoEn;
  final double tasaIsv;
  final List<CotizacionItemModel> items;

  CotizacionModel({
    required this.id,
    required this.numero,
    required this.nombreCliente,
    this.cardCode,
    this.rtn,
    this.direccion,
    this.telefono,
    this.departamento,
    this.municipio,
    required this.creadoPor,
    required this.creadoEn,
    this.tasaIsv = 0.15,
    this.items = const [],
  });

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.subtotal);
  double get isv => items.where((i) => i.gravado).fold(0.0, (sum, item) => sum + (item.subtotal * tasaIsv));
  double get total => subtotal + isv;

  factory CotizacionModel.fromJson(Map<String, dynamic> json, {List<CotizacionItemModel>? items}) {
    return CotizacionModel(
      id: json['id'] ?? '',
      numero: json['numero'] ?? '',
      nombreCliente: json['nombre_cliente'] ?? '',
      cardCode: json['card_code'],
      rtn: json['rtn'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      departamento: json['departamento'],
      municipio: json['municipio'],
      creadoPor: json['creado_por'] ?? '',
      creadoEn: DateTime.tryParse(json['creado_en'] ?? '') ?? DateTime.now(),
      tasaIsv: (json['tasa_isv'] ?? 0.15).toDouble(),
      items: items ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'nombre_cliente': nombreCliente,
      'card_code': cardCode,
      'rtn': rtn,
      'direccion': direccion,
      'telefono': telefono,
      'departamento': departamento,
      'municipio': municipio,
      'creado_por': creadoPor,
      'creado_en': creadoEn.toIso8601String(),
      'tasa_isv': tasaIsv,
    };
  }
}
