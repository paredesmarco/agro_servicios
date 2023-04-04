class EnvaseModelo {
  EnvaseModelo({
    this.idEnvase,
    this.nombreEnvase,
    this.idArea,
  });

  int? idEnvase;
  String? nombreEnvase;
  String? idArea;

  factory EnvaseModelo.fromJson(Map<String, dynamic> json) => EnvaseModelo(
        idEnvase: json["id_envase"],
        nombreEnvase: json["nombre_envase"],
        idArea: json["id_area"],
      );

  Map<String, dynamic> toJson() => {
        "id_envase": idEnvase,
        "nombre_envase": nombreEnvase,
        "id_area": idArea,
      };
}
