import 'dart:convert';

MinadorProductorModelo newResponseFromJson(String str) =>
    MinadorProductorModelo.fromJson(json.decode(str));

class MinadorProductorModelo {
  String? identificador;
  String? nombre;

  MinadorProductorModelo({this.identificador, this.nombre});

  factory MinadorProductorModelo.fromJson(Map<String, dynamic> json) =>
      MinadorProductorModelo(
        identificador: json['identificador'],
        nombre: json['nombre'],
      );

  Map<String, dynamic> toJson() =>
      {'identificador': identificador, 'nombre': nombre};
}
