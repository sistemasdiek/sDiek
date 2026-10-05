class BodegaEntregaModel {
  final String id;
  final String numeroPedido;
  final String? giraId;
  final String estado; // 'pendiente', 'entregado', 'devuelto'
  final String? motorista;
  final String? notas;
  final DateTime marcadoEn;
  final String? formaPago;
  final double? montoPago;

  BodegaEntregaModel({
    required this.id,
    required this.numeroPedido,
    this.giraId,
    required this.estado,
    this.motorista,
    this.notas,
    required this.marcadoEn,
    this.formaPago,
    this.montoPago,
  });

  factory BodegaEntregaModel.fromJson(Map<String, dynamic> json) {
    return BodegaEntregaModel(
      id: json['id'] ?? '',
      numeroPedido: json['numero_pedido'] ?? '',
      giraId: json['gira_id'],
      estado: json['estado'] ?? 'pendiente',
      motorista: json['motorista'],
      notas: json['notas'],
      marcadoEn: DateTime.tryParse(json['marcado_en'] ?? '') ?? DateTime.now(),
      formaPago: json['forma_pago'],
      montoPago: json['monto_pago'] != null ? (json['monto_pago'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero_pedido': numeroPedido,
      'gira_id': giraId,
      'estado': estado,
      'motorista': motorista,
      'notas': notas,
      'marcado_en': marcadoEn.toIso8601String(),
      'forma_pago': formaPago,
      'monto_pago': montoPago,
    };
  }
}
