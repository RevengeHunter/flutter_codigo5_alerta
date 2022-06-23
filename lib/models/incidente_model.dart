import 'package:flutter_codigo5_alerta/models/incidente_tipo_model.dart';

class IncidenteModel {
  IncidenteModel({
    required this.id,
    required this.tipoIncidente,
    required this.longitud,
    required this.latitud,
    required this.fecha,
    required this.hora,
    required this.ciudadanoNombre,
    required this.fechaCreacion,
    required this.datosCiudadano,
    required this.estadoDisplay,
    required this.tipoOrigenDisplay,
    this.personalDisplay,
    this.unidadDisplay,
    this.usuarioDisplay,
    required this.estado,
    required this.tipoOrigen,
    required this.atendido,
    required this.atendidoSerenazgo,
    required this.calificacion,
    required this.calificacionCiudadano,
    this.observacion,
    this.nombres,
    this.dni,
    this.telefono,
    this.imagen,
    required this.ciudadano,
    this.usuario,
    this.unidad,
    this.personalSeguridad,
  });

  int id;
  IncidenteTipoModel tipoIncidente;
  double longitud;
  double latitud;
  String fecha;
  String hora;
  String ciudadanoNombre;
  String fechaCreacion;
  DatosCiudadano datosCiudadano;
  String estadoDisplay;
  String tipoOrigenDisplay;
  String? personalDisplay;
  String? unidadDisplay;
  String? usuarioDisplay;
  String estado;
  String tipoOrigen;
  bool atendido;
  bool atendidoSerenazgo;
  int calificacion;
  int calificacionCiudadano;
  String? observacion;
  String? nombres;
  String? dni;
  String? telefono;
  String? imagen;
  int ciudadano;
  String? usuario;
  String? unidad;
  String? personalSeguridad;

  factory IncidenteModel.fromJson(Map<String, dynamic> json) => IncidenteModel(
    id: json["id"],
    tipoIncidente: IncidenteTipoModel.fromJson(json["tipoIncidente"]),
    longitud: json["longitud"].toDouble(),
    latitud: json["latitud"].toDouble(),
    fecha: json["fecha"],
    hora: json["hora"],
    ciudadanoNombre: json["ciudadanoNombre"],
    fechaCreacion: json["fechaCreacion"],
    datosCiudadano: DatosCiudadano.fromJson(json["datosCiudadano"]),
    estadoDisplay: json["estado_display"],
    tipoOrigenDisplay: json["tipoOrigen_display"],
    personalDisplay: json["personal_display"],
    unidadDisplay: json["unidad_display"],
    usuarioDisplay: json["usuario_display"],
    estado: json["estado"],
    tipoOrigen: json["tipoOrigen"],
    atendido: json["atendido"],
    atendidoSerenazgo: json["atendidoSerenazgo"],
    calificacion: json["calificacion"],
    calificacionCiudadano: json["calificacionCiudadano"],
    observacion: json["observacion"],
    nombres: json["nombres"],
    dni: json["dni"],
    telefono: json["telefono"],
    imagen: json["imagen"],
    ciudadano: json["ciudadano"],
    usuario: json["usuario"],
    unidad: json["unidad"],
    personalSeguridad: json["personalSeguridad"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tipoIncidente": tipoIncidente.toJson(),
    "longitud": longitud,
    "latitud": latitud,
    "fecha": fecha,
    "hora": hora,
    "ciudadanoNombre": ciudadanoNombre,
    "fechaCreacion": fechaCreacion,
    "datosCiudadano": datosCiudadano.toJson(),
    "estado_display": estadoDisplay,
    "tipoOrigen_display": tipoOrigenDisplay,
    "personal_display": personalDisplay,
    "unidad_display": unidadDisplay,
    "usuario_display": usuarioDisplay,
    "estado": estado,
    "tipoOrigen": tipoOrigen,
    "atendido": atendido,
    "atendidoSerenazgo": atendidoSerenazgo,
    "calificacion": calificacion,
    "calificacionCiudadano": calificacionCiudadano,
    "observacion": observacion,
    "nombres": nombres,
    "dni": dni,
    "telefono": telefono,
    "imagen": imagen,
    "ciudadano": ciudadano,
    "usuario": usuario,
    "unidad": unidad,
    "personalSeguridad": personalSeguridad,
  };
}

class DatosCiudadano {
  DatosCiudadano({
    required this.nombres,
    required this.dni,
    required this.telefono,
  });

  String nombres;
  String dni;
  String telefono;

  factory DatosCiudadano.fromJson(Map<String, dynamic> json) => DatosCiudadano(
    nombres: json["nombres"],
    dni: json["dni"],
    telefono: json["telefono"],
  );

  Map<String, dynamic> toJson() => {
    "nombres": nombres,
    "dni": dni,
    "telefono": telefono,
  };
}
