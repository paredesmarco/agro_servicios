import 'dart:convert';

UsuarioModelo newResponseFromJson(String str) =>
    UsuarioModelo.fromJson(json.decode(str));

class UsuarioModelo {
  int? id;
  String? identificador;
  String? nombre;
  String? tipo;
  String? foto;
  String? pin;
  String? fechaCaducidad;

  UsuarioModelo(
      {this.id,
      this.identificador,
      this.nombre,
      this.tipo,
      this.foto,
      this.pin,
      this.fechaCaducidad});

  factory UsuarioModelo.fromJson(Map<String, dynamic> json) => UsuarioModelo(
        id: json['id'],
        identificador: json['identificador'],
        nombre: json['nombre'],
        tipo: json['tipo'],
        foto: json['foto'],
        pin: json['pin'],
        fechaCaducidad: json['fecha_caducidad'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'identificador': identificador,
        'nombre': nombre,
        'tipo': tipo,
        'foto': foto,
        'pin': pin,
        'fecha_caducidad': fechaCaducidad
      };
}
