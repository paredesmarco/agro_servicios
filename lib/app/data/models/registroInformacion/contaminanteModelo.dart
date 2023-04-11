import 'dart:ffi';

class ContaminanteModelo {
  ContaminanteModelo(
      {this.id,
      this.nombre,
      this.unidad,
      this.resultado,
      this.codex,
      this.ue,
      this.eeuu,
      this.positivo});

  ContaminanteModelo copy({
    int? id,
    String? nombre,
    String? unidad,
    String? resultado,
    String? codex,
    String? ue,
    String? eeuu,
    String? positivo,
  }) =>
      ContaminanteModelo(
          id: id ?? this.id,
          nombre: nombre ?? this.nombre,
          unidad: unidad ?? this.unidad,
          resultado: resultado ?? this.resultado,
          codex: codex ?? this.codex,
          ue: ue ?? this.ue,
          eeuu: eeuu ?? this.eeuu,
          positivo: positivo ?? this.positivo);
  int? id;
  String? nombre;
  String? unidad;
  String? resultado;
  String? codex;
  String? ue;
  String? eeuu;
  String? positivo;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContaminanteModelo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nombre == other.nombre &&
          unidad == other.unidad &&
          resultado == other.resultado &&
          codex == other.codex &&
          ue == other.ue &&
          eeuu == other.eeuu &&
          positivo == other.positivo;

  @override
  int get hashCode =>
      id.hashCode ^
      nombre.hashCode ^
      unidad.hashCode ^
      resultado.hashCode ^
      codex.hashCode ^
      ue.hashCode ^
      eeuu.hashCode ^
      positivo.hashCode;
}
