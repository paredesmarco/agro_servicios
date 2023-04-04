import 'dart:convert';

TripsProductorModelo newResponseFromJson(String str) =>
    TripsProductorModelo.fromJson(json.decode(str));

class TripsProductorModelo {
  String? identificador;
  String? nombre;

  TripsProductorModelo({this.identificador, this.nombre});

  factory TripsProductorModelo.fromJson(Map<String, dynamic> json) =>
      TripsProductorModelo(
        identificador: json['identificador'],
        nombre: json['nombre'],
      );

  Map<String, dynamic> toJson() =>
      {'identificador': identificador, 'nombre': nombre};
}
