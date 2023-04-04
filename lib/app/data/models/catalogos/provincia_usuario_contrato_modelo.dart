class ProvinciaUsuarioContratoModelo {
  ProvinciaUsuarioContratoModelo({
    this.identificador,
    this.provincia,
  });

  String? identificador;
  String? provincia;

  factory ProvinciaUsuarioContratoModelo.fromJson(Map<String, dynamic> json) =>
      ProvinciaUsuarioContratoModelo(
        identificador: json["identificador"],
        provincia: json["provincia"],
      );

  Map<String, dynamic> toJson() => {
        "identificador": identificador,
        "provincia": provincia,
      };
}
