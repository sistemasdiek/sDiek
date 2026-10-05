class EmpleadoModel {
  final String id;
  final String nombreCompleto;
  final String? codigoAsistencia;
  final String? identidad;
  final String? puesto;
  final String? departamento;
  final DateTime? fechaIngreso;
  final double salarioBase;
  final String estado; // 'activo', 'inactivo'
  final String? tipoPago;
  final String? cuentaBanco;

  EmpleadoModel({
    required this.id,
    required this.nombreCompleto,
    this.codigoAsistencia,
    this.identidad,
    this.puesto,
    this.departamento,
    this.fechaIngreso,
    this.salarioBase = 0.0,
    this.estado = 'activo',
    this.tipoPago,
    this.cuentaBanco,
  });

  factory EmpleadoModel.fromJson(Map<String, dynamic> json) {
    return EmpleadoModel(
      id: json['id'] ?? '',
      nombreCompleto: json['nombre_completo'] ?? '',
      codigoAsistencia: json['codigo_asistencia'],
      identidad: json['identidad'],
      puesto: json['puesto'],
      departamento: json['departamento'],
      fechaIngreso: json['fecha_ingreso'] != null ? DateTime.tryParse(json['fecha_ingreso']) : null,
      salarioBase: (json['salario_base'] ?? 0.0).toDouble(),
      estado: json['estado'] ?? 'activo',
      tipoPago: json['tipo_pago'],
      cuentaBanco: json['cuenta_banco'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre_completo': nombreCompleto,
      'codigo_asistencia': codigoAsistencia,
      'identidad': identidad,
      'puesto': puesto,
      'departamento': departamento,
      'fecha_ingreso': fechaIngreso?.toIso8601String(),
      'salario_base': salarioBase,
      'estado': estado,
      'tipo_pago': tipoPago,
      'cuenta_banco': cuentaBanco,
    };
  }
}
