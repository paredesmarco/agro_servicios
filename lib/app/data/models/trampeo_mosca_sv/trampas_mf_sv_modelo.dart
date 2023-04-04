class TrampasMfSvModelo {
  TrampasMfSvModelo({
    this.id,
    this.idPadre,
    this.idTrampa,
    this.idProvincia,
    this.provincia,
    this.idCanton,
    this.canton,
    this.idParroquia,
    this.parroquia,
    this.idLugarInstalacion,
    this.nombreLugarInstalacion,
    this.numeroLugarInstalacion,
    this.idTipoAtrayente,
    this.nombreTipoAtrayente,
    this.nombreTipoTrampa,
    this.codigoTrampa,
    this.coordenadax,
    this.coordenaday,
    this.coordenadaz,
    this.fechaInstalacion,
    this.estadoTrampa,
    this.secuencialOrden,
    this.fechaInspeccion,
    this.utilizado,
    this.actualizado,
    this.activo,
  });

  int? id;
  int? idPadre;
  int? idTrampa;
  int? idProvincia;
  String? provincia;
  int? idCanton;
  String? canton;
  int? idParroquia;
  String? parroquia;
  int? idLugarInstalacion;
  String? nombreLugarInstalacion;
  int? numeroLugarInstalacion;
  int? idTipoAtrayente;
  String? nombreTipoAtrayente;
  String? nombreTipoTrampa;
  String? codigoTrampa;
  String? coordenadax;
  String? coordenaday;
  String? coordenadaz;
  DateTime? fechaInstalacion;
  String? estadoTrampa;
  int? secuencialOrden;
  DateTime? fechaInspeccion;
  int? utilizado;
  bool? actualizado = false;
  bool? activo = true;
  bool llenado = false;

  factory TrampasMfSvModelo.fromJson(Map<String, dynamic> json) =>
      TrampasMfSvModelo(
        id: json["id"],
        idPadre: json["id_padre"],
        idTrampa: json["id_trampa"],
        idProvincia: json["id_provincia"],
        provincia: json["provincia"],
        idCanton: json["id_canton"],
        canton: json["canton"],
        idParroquia: json["id_parroquia"],
        parroquia: json["parroquia"],
        idLugarInstalacion: json["id_lugar_instalacion"],
        nombreLugarInstalacion: json["nombre_lugar_instalacion"],
        numeroLugarInstalacion: json["numero_lugar_instalacion"],
        idTipoAtrayente: json["id_tipo_atrayente"],
        nombreTipoAtrayente: json["nombre_tipo_atrayente"],
        nombreTipoTrampa: json["nombre_tipo_trampa"],
        codigoTrampa: json["codigo_trampa"],
        coordenadax: json["coordenadax"],
        coordenaday: json["coordenaday"],
        coordenadaz: json["coordenadaz"],
        fechaInstalacion: DateTime.parse(json["fecha_instalacion"]),
        estadoTrampa: json["estado_trampa"],
        secuencialOrden: json["secuencialorden"],
        fechaInspeccion: json["fecha_inspeccion"] != null
            ? DateTime.parse(json["fecha_inspeccion"])
            : null,
        utilizado: 0,
        activo: true,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_provincia": idProvincia,
        "provincia": provincia,
        "id_canton": idCanton,
        "canton": canton,
        "id_parroquia": idParroquia,
        "parroquia": parroquia,
        "id_lugar_instalacion": idLugarInstalacion,
        "nombre_lugar_instalacion": nombreLugarInstalacion,
        "numero_lugar_instalacion": numeroLugarInstalacion,
        "id_tipo_atrayente": idTipoAtrayente,
        "nombre_tipo_atrayente": nombreTipoAtrayente,
        "nombre_tipo_trampa": nombreTipoTrampa,
        "codigo_trampa": codigoTrampa,
        "coordenadax": coordenadax,
        "coordenaday": coordenaday,
        "coordenadaz": coordenadaz,
        "fecha_instalacion": fechaInstalacion?.toIso8601String() ??
            fechaInstalacion!.toIso8601String(),
        "estado_trampa": estadoTrampa,
        "secuencial_orden": secuencialOrden,
        "fecha_inspeccion":
            fechaInspeccion != null ? fechaInspeccion!.toIso8601String() : null,
      };

  @override
  String toString() {
    return 'TrampasMfSvModelo :{idTrampa: $idTrampa, '
        'idProvincia: $idProvincia, '
        'provincia: $provincia, '
        'idCanton: $idCanton, '
        'canton: $canton, '
        'idParroquia: $idParroquia, '
        'parroquia: $parroquia, '
        'idLugarInstalacion: $idLugarInstalacion, '
        'nombreLugarInstalacion: $nombreLugarInstalacion, '
        'numeroLugarInstalacion: $numeroLugarInstalacion, '
        'idTipoAtrayente: $idTipoAtrayente, '
        'nombreTipoAtrayente: $nombreTipoAtrayente, '
        'nombreTipoTrampa: $nombreTipoTrampa, '
        'codigoTrampa: $codigoTrampa, '
        'coordenadax: $coordenadax, '
        'coordenaday: $coordenaday, '
        'coordenadaz: $coordenadaz, '
        'fechaInstalacion: $fechaInstalacion, '
        'estadoTrampa: $estadoTrampa, '
        'secuencial_orden: $secuencialOrden, '
        'fechaInspeccion: $fechaInspeccion}';
  }
}
