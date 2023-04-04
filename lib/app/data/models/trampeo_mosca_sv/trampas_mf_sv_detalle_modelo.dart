class TrampasMfSvDetalleModelo {
  TrampasMfSvDetalleModelo({
    this.id,
    this.idPadre,
    this.idTablet,
    this.idProvincia,
    this.nombreProvincia,
    this.idCanton,
    this.nombreCanton,
    this.idParroquia,
    this.nombreParroquia,
    this.idLugarInstalacion,
    this.nombreLugarInstalacion,
    this.numeroLugarInstalacion,
    this.idTipoAtrayente,
    this.nombreTipoAtrayente,
    this.tipoTrampa,
    this.codigoTrampa,
    this.semana,
    this.coordenadaX,
    this.coordenadaY,
    this.coordenadaZ,
    this.fechaInstalacion,
    this.estadoTrampa,
    this.exposicion,
    this.condicion,
    this.cambioTrampa,
    this.cambioPlug,
    this.especiePrincipal,
    this.estadoFenologicoPrincipal,
    this.especieColindante,
    this.estadoFenologicoColindante,
    this.numeroEspecimenes,
    this.observaciones,
    this.envioMuestra,
    this.estadoRegistro,
    this.fechaInspeccion,
    this.usuarioId,
    this.usuario,
    this.tabletId,
    this.tabletVersionBase,
  });

  int? id;
  int? idPadre;
  int? idTablet;
  int? idProvincia;
  String? nombreProvincia;
  int? idCanton;
  String? nombreCanton;
  int? idParroquia;
  String? nombreParroquia;
  int? idLugarInstalacion;
  String? nombreLugarInstalacion;
  int? numeroLugarInstalacion;
  int? idTipoAtrayente;
  String? nombreTipoAtrayente;
  String? tipoTrampa;
  String? codigoTrampa;
  int? semana;
  String? coordenadaX;
  String? coordenadaY;
  String? coordenadaZ;
  String? fechaInstalacion;
  String? estadoTrampa;
  String? exposicion;
  String? condicion;
  String? cambioTrampa;
  String? cambioPlug;
  String? especiePrincipal;
  String? estadoFenologicoPrincipal;
  String? especieColindante;
  String? estadoFenologicoColindante;
  int? numeroEspecimenes;
  String? observaciones;
  String? envioMuestra;
  String? estadoRegistro;
  String? fechaInspeccion;
  String? usuarioId;
  String? usuario;
  String? tabletId;
  String? tabletVersionBase;

  factory TrampasMfSvDetalleModelo.fromJson(Map<String, dynamic> json) =>
      TrampasMfSvDetalleModelo(
        id: json["id"],
        idPadre: json["id_padre"],
        idTablet: json["id_tablet"],
        idProvincia: int.parse(json["id_provincia"]),
        nombreProvincia: json["nombre_provincia"],
        idCanton: int.parse(json["id_canton"]),
        nombreCanton: json["nombre_canton"],
        idParroquia: int.parse(json["id_parroquia"]),
        nombreParroquia: json["nombre_parroquia"],
        idLugarInstalacion: int.parse(json["id_lugar_instalacion"]),
        nombreLugarInstalacion: json["nombre_lugar_instalacion"],
        numeroLugarInstalacion: json["numero_lugar_instalacion"],
        idTipoAtrayente: int.parse(json["id_tipo_atrayente"]),
        nombreTipoAtrayente: json["nombre_tipo_atrayente"],
        tipoTrampa: json["tipo_trampa"],
        codigoTrampa: json["codigo_trampa"],
        semana: json["semana"],
        coordenadaX: json["coordenada_x"],
        coordenadaY: json["coordenada_y"],
        coordenadaZ: json["coordenada_z"],
        fechaInstalacion: json["fecha_instalacion"],
        estadoTrampa: json["estado_trampa"],
        exposicion: json["exposicion"],
        condicion: json["condicion"],
        cambioTrampa: json["cambio_trampa"],
        cambioPlug: json["cambio_plug"],
        especiePrincipal: json["especie_principal"],
        estadoFenologicoPrincipal: json["estado_fenologico_principal"],
        especieColindante: json["especie_colindante"],
        estadoFenologicoColindante: json["estado_fenologico_colindante"],
        numeroEspecimenes: json["numero_especimenes"],
        observaciones: json["observaciones"],
        envioMuestra: json["envio_muestra"],
        estadoRegistro: json["estado_registro"],
        fechaInspeccion: json["fecha_inspeccion"],
        usuarioId: json["usuario_id"],
        usuario: json["usuario"],
        tabletId: json["tablet_id"],
        tabletVersionBase: json["tablet_version_base"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_padre": idPadre,
        "id_tablet": idTablet,
        "id_provincia": idProvincia,
        "nombre_provincia": nombreProvincia,
        "id_canton": idCanton,
        "nombre_canton": nombreCanton,
        "id_parroquia": idParroquia,
        "nombre_parroquia": nombreParroquia,
        "id_lugar_instalacion": idLugarInstalacion,
        "nombre_lugar_instalacion": nombreLugarInstalacion,
        "numero_lugar_instalacion": numeroLugarInstalacion,
        "id_tipo_atrayente": idTipoAtrayente,
        "nombre_tipo_atrayente": nombreTipoAtrayente,
        "tipo_trampa": tipoTrampa,
        "codigo_trampa": codigoTrampa,
        "semana": semana,
        "coordenada_x": coordenadaX,
        "coordenada_y": coordenadaY,
        "coordenada_z": coordenadaZ,
        "fecha_instalacion": fechaInstalacion,
        "estado_trampa": estadoTrampa,
        "exposicion": exposicion,
        "condicion": condicion,
        "cambio_trampa": cambioTrampa,
        "cambio_plug": cambioPlug,
        "especie_principal": especiePrincipal,
        "estado_fenologico_principal": estadoFenologicoPrincipal,
        "especie_colindante": especieColindante,
        "estado_fenologico_colindante": estadoFenologicoColindante,
        "numero_especimenes": numeroEspecimenes,
        "observaciones": observaciones,
        "envio_muestra": envioMuestra,
        "estado_registro": estadoRegistro,
        "fecha_inspeccion": fechaInspeccion,
        "usuario_id": usuarioId,
        "usuario": usuario,
        "tablet_id": tabletId,
        "tablet_version_base": tabletVersionBase,
      };

  @override
  String toString() {
    return '''
    TrampasMfSvDetalleModelo : {
      id : $id,
      id_padre : $idPadre,
      id_tablet : $idTablet,
      id_provincia : $idProvincia,
      nombre_provincia : $nombreProvincia,
      id_canton : $idCanton,
      nombre_canton : $nombreCanton,
      id_parroquia : $idParroquia,
      nombre_parroquia : $nombreParroquia,
      id_lugar_instalacion : $idLugarInstalacion,
      nombre_lugar_instalacion : $nombreLugarInstalacion,
      numero_lugar_instalacion : $numeroLugarInstalacion,
      id_tipo_atrayente : $idTipoAtrayente,
      nombre_tipo_atrayente : $nombreTipoAtrayente,
      tipo_trampa : $tipoTrampa,
      codigo_trampa : $codigoTrampa,
      semana : $semana,
      coordenada_x : $coordenadaX,
      coordenada_y : $coordenadaY,
      coordenada_z : $coordenadaZ,
      fecha_instalacion : $fechaInstalacion,
      estado_trampa : $estadoTrampa,
      exposicion : $exposicion,
      condicion : $condicion,
      cambio_trampa : $cambioTrampa,
      cambio_plug : $cambioPlug,
      especie_principal : $especiePrincipal,
      estado_fenologico_principal : $estadoFenologicoPrincipal,
      especie_colindante : $especieColindante,
      estado_fenologico_colindante : $estadoFenologicoColindante,
      numero_especimenes : $numeroEspecimenes,
      observaciones : $observaciones,
      envio_muestra : $envioMuestra,
      estado_registro : $estadoRegistro,
      fecha_inspeccion : $fechaInspeccion,
      usuario_id : $usuarioId,
      usuario : $usuario,
      tablet_id : $tabletId,
      tablet_version_base : $tabletVersionBase
    }
    ''';
  }
}
