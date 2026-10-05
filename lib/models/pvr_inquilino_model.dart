class PvrInquilinoModel {
  final String id;
  final int numero;
  final String nombre;
  final String? razonSocial;
  final String? rtn;
  final String? local;
  final double arrendamiento;
  final double mantenimiento;
  final double energiaDefault;
  final double saldoInicial;
  final DateTime? fechaCorte;
  final bool activo;
  final String? notas;

  PvrInquilinoModel({
    required this.id,
    required this.numero,
    required this.nombre,
    this.razonSocial,
    this.rtn,
    this.local,
    this.arrendamiento = 0.0,
    this.mantenimiento = 0.0,
    this.energiaDefault = 0.0,
    this.saldoInicial = 0.0,
    this.fechaCorte,
    this.activo = true,
    this.notas,
  });

  double get totalMensual => arrendamiento + mantenimiento + energiaDefault;

  factory PvrInquilinoModel.fromJson(Map<String, dynamic> json) {
    return PvrInquilinoModel(
      id: json['id'] ?? '',
      numero: json['numero'] ?? 0,
      nombre: json['nombre'] ?? '',
      razonSocial: json['razon_social'],
      rtn: json['rtn'],
      local: json['local'],
      arrendamiento: (json['arrendamiento'] ?? 0.0).toDouble(),
      mantenimiento: (json['mantenimiento'] ?? 0.0).toDouble(),
      energiaDefault: (json['energia_default'] ?? 0.0).toDouble(),
      saldoInicial: (json['saldo_inicial'] ?? 0.0).toDouble(),
      fechaCorte: json['fecha_corte'] != null ? DateTime.tryParse(json['fecha_corte']) : null,
      activo: json['activo'] ?? true,
      notas: json['notas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'nombre': nombre,
      'razon_social': razonSocial,
      'rtn': rtn,
      'local': local,
      'arrendamiento': arrendamiento,
      'mantenimiento': mantenimiento,
      'energia_default': energiaDefault,
      'saldo_inicial': saldoInicial,
      'fecha_corte': fechaCorte?.toIso8601String(),
      'activo': activo,
      'notas': notas,
    };
  }
}
