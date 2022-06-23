class AlertAuxModel {
  AlertAuxModel({
    required this.latitud,
    required this.longitud,
    required this.tipoIncidente,
    required this.estado,
  });

  double latitud;
  double longitud;
  int tipoIncidente;
  String estado;

  factory AlertAuxModel.fromJson(Map<String, dynamic> json) => AlertAuxModel(
    latitud: json["latitud"],
    longitud: json["longitud"],
    tipoIncidente: json["tipoIncidente"],
    estado: json["estado"],
  );

  Map<String, dynamic> toJson() => {
    "latitud": latitud,
    "longitud": longitud,
    "tipoIncidente": tipoIncidente,
    "estado": estado,
  };
}