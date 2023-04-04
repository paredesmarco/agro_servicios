class SesionTokenModelo {
  final String? token;
  final int? expiraEn;
  final DateTime? fechaCreacion;

  SesionTokenModelo({
    required this.token,
    required this.expiraEn,
    required this.fechaCreacion,
  });

  static SesionTokenModelo fromJson(Map<String, dynamic> json) {
    return SesionTokenModelo(
      token: json['token'],
      expiraEn: json['expiraEn'],
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "expiraEn": expiraEn,
      "fechaCreacion": fechaCreacion!.toIso8601String(),
    };
  }
}
