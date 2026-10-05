class TintaModel {
  final String id;
  final String? grupo;
  final String nombre;
  final int cantidadNueva;
  final int cantidadAbierta;
  final int necesito;

  TintaModel({
    required this.id,
    this.grupo,
    required this.nombre,
    this.cantidadNueva = 0,
    this.cantidadAbierta = 0,
    this.necesito = 0,
  });

  factory TintaModel.fromJson(Map<String, dynamic> json) {
    return TintaModel(
      id: json['id'] ?? '',
      grupo: json['grupo'],
      nombre: json['nombre'] ?? '',
      cantidadNueva: json['cantidad_nueva'] ?? 0,
      cantidadAbierta: json['cantidad_abierta'] ?? 0,
      necesito: json['necesito'] ?? 0,
    );
  }
}

class DispositivoModel {
  final String id;
  final String estado;
  final String? empleadoNombre;
  final String? departamento;
  final String? modelo;
  final String? numeroTelefono;
  final String? imei;
  final String? notas;

  DispositivoModel({
    required this.id,
    required this.estado,
    this.empleadoNombre,
    this.departamento,
    this.modelo,
    this.numeroTelefono,
    this.imei,
    this.notas,
  });

  factory DispositivoModel.fromJson(Map<String, dynamic> json) {
    return DispositivoModel(
      id: json['id'] ?? '',
      estado: json['estado'] ?? 'asignado',
      empleadoNombre: json['empleado_nombre'],
      departamento: json['departamento'],
      modelo: json['modelo'],
      numeroTelefono: json['numero_telefono'],
      imei: json['imei'],
      notas: json['notas'],
    );
  }
}

class CamionModel {
  final String id;
  final String? placa;
  final String placaNueva;
  final int? anio;
  final String? marca;
  final String? descripcion;
  final String? empresa;
  final double? capacidadCargaLb;
  final bool activo;

  CamionModel({
    required this.id,
    this.placa,
    required this.placaNueva,
    this.anio,
    this.marca,
    this.descripcion,
    this.empresa,
    this.capacidadCargaLb,
    this.activo = true,
  });

  factory CamionModel.fromJson(Map<String, dynamic> json) {
    return CamionModel(
      id: json['id'] ?? '',
      placa: json['placa'],
      placaNueva: json['placa_nueva'] ?? '',
      anio: json['anio'],
      marca: json['marca'],
      descripcion: json['descripcion'],
      empresa: json['empresa'],
      capacidadCargaLb: json['capacidad_carga_lb'] != null ? (json['capacidad_carga_lb'] as num).toDouble() : null,
      activo: json['activo'] ?? true,
    );
  }
}
