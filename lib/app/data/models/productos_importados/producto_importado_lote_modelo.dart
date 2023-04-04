class ProductoImportadoLoteModelo {
  ProductoImportadoLoteModelo({
    this.id,
    this.descripcion,
    this.numeroCajas,
    this.cajasMuestra,
    this.porcentajeInspeccion,
    this.ausenciaSuelo,
    this.ausenciaContaminantes,
    this.ausenciaSintomas,
    this.ausenciaPlagas,
    this.dictamen,
    this.controlF01Id,
  });

  int? id;
  String? descripcion;
  int? numeroCajas;
  int? cajasMuestra;
  String? porcentajeInspeccion;
  String? ausenciaSuelo;
  String? ausenciaContaminantes;
  String? ausenciaSintomas;
  String? ausenciaPlagas;
  String? dictamen;
  int? controlF01Id;
  int? idTablet;

  factory ProductoImportadoLoteModelo.fromJson(Map<String, dynamic> json) =>
      ProductoImportadoLoteModelo(
        id: json["id"],
        descripcion: json["descripcion"],
        numeroCajas: json["numero_cajas"],
        cajasMuestra: json["cajas_muestra"],
        porcentajeInspeccion: json["porcentaje_inspeccion"],
        ausenciaSuelo: json["ausencia_suelo"],
        ausenciaContaminantes: json["ausencia_contaminantes"],
        ausenciaSintomas: json["ausencia_sintomas"],
        ausenciaPlagas: json["ausencia_plagas"],
        dictamen: json["dictamen"],
        controlF01Id: json["control_f01_id"],
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "numero_cajas": numeroCajas,
        "cajas_muestra": cajasMuestra,
        "porcentaje_inspeccion": porcentajeInspeccion,
        "ausencia_suelo": ausenciaSuelo,
        "ausencia_contaminantes": ausenciaContaminantes,
        "ausencia_sintomas": ausenciaSintomas,
        "ausencia_plagas": ausenciaPlagas,
        "dictamen": dictamen,
        "control_f01_id": controlF01Id,
        "id_tablet": idTablet,
      };

  @override
  String toString() {
    return '''ProductoImportadoLoteModelo{
        id: $id,
        descripcion: $descripcion,
        numero_cajas: $numeroCajas,
        cajas_muestra: $cajasMuestra,
        porcentaje_inspeccion: $porcentajeInspeccion,
        ausencia_suelo: $ausenciaSuelo,
        ausencia_contaminantes: $ausenciaContaminantes,
        ausencia_sintomas: $ausenciaSintomas,
        ausencia_plagas: $ausenciaPlagas,
        dictamen: $dictamen,
        control_f01_id: $controlF01Id,
        id_tablet: $idTablet,
        }
    ''';
  }
}
