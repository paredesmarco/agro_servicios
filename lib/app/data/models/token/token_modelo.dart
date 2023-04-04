class TokenModelo {
  TokenModelo({
    this.estado,
    this.mensaje,
    this.token,
    this.expiraEn,
    this.estatusCode,
  });

  String? estado;
  String? mensaje;
  String? token;
  int? expiraEn;
  int? estatusCode;

  factory TokenModelo.fromJson(Map<String, dynamic> json) => TokenModelo(
        estado: json["estado"],
        mensaje: json["mensaje"],
        token: json["token"],
        expiraEn: json["expiraEn"],
        estatusCode: json["estatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "mensaje": mensaje,
        "token": token,
        "expiraEn": expiraEn,
        "estatusCode": estatusCode,
      };

  @override
  String toString() {
    return '''{
        estado: $estado,
        mensaje: $mensaje,
        token: $token,
        expiraEn: $expiraEn,
        estatusCode: $estatusCode,
      }''';
  }
}
