class GiraUbicacionModel {
  final int id;
  final String giraId;
  final double lat;
  final double lng;
  final double? precisionM;
  final DateTime capturadoEn;

  GiraUbicacionModel({
    required this.id,
    required this.giraId,
    required this.lat,
    required this.lng,
    this.precisionM,
    required this.capturadoEn,
  });

  factory GiraUbicacionModel.fromJson(Map<String, dynamic> json) {
    return GiraUbicacionModel(
      id: json['id'] ?? 0,
      giraId: json['gira_id'] ?? '',
      lat: (json['lat'] ?? 0.0).toDouble(),
      lng: (json['lng'] ?? 0.0).toDouble(),
      precisionM: json['precision_m'] != null ? (json['precision_m'] as num).toDouble() : null,
      capturadoEn: DateTime.tryParse(json['capturado_en'] ?? '') ?? DateTime.now(),
    );
  }
}

class GiraIncidenciaModel {
  final String id;
  final String giraId;
  final String motorista;
  final String tipo;
  final String descripcion;
  final DateTime creadoEn;

  GiraIncidenciaModel({
    required this.id,
    required this.giraId,
    required this.motorista,
    required this.tipo,
    required this.descripcion,
    required this.creadoEn,
  });

  factory GiraIncidenciaModel.fromJson(Map<String, dynamic> json) {
    return GiraIncidenciaModel(
      id: json['id'] ?? '',
      giraId: json['gira_id'] ?? '',
      motorista: json['motorista'] ?? '',
      tipo: json['tipo'] ?? 'general',
      descripcion: json['descripcion'] ?? '',
      creadoEn: DateTime.tryParse(json['creado_en'] ?? '') ?? DateTime.now(),
    );
  }
}

class GiraModel {
  final String id;
  final String numero;
  final String? numRemision;
  final String? ayudante;
  final DateTime createdAt;
  final String estado; // 'activa', 'completada'
  final List<GiraIncidenciaModel> incidencias;

  GiraModel({
    required this.id,
    required this.numero,
    this.numRemision,
    this.ayudante,
    required this.createdAt,
    this.estado = 'activa',
    this.incidencias = const [],
  });

  factory GiraModel.fromJson(Map<String, dynamic> json, {List<GiraIncidenciaModel>? incidencias}) {
    return GiraModel(
      id: json['id'] ?? '',
      numero: json['numero'] ?? '',
      numRemision: json['num_remision'],
      ayudante: json['ayudante'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      estado: json['estado'] ?? 'activa',
      incidencias: incidencias ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'num_remision': numRemision,
      'ayudante': ayudante,
      'created_at': createdAt.toIso8601String(),
      'estado': estado,
    };
  }
}
