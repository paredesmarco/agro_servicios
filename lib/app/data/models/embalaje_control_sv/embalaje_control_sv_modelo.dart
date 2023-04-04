class EmbalajeControlModelo {
  EmbalajeControlModelo(
      {this.id,
      this.idPuntoControl,
      this.puntoControl,
      this.areaInspeccion,
      this.identidadEmbalaje,
      this.idPaisOrigen,
      this.paisOrigen,
      this.numeroEmbalajes,
      this.numeroUnidades,
      this.marcaAutorizada,
      this.marcaAutorizadaDescripcion,
      this.marcaLegible,
      this.marcaLegibleDescripcion,
      this.ausenciaDanoInsectos,
      this.ausenciaDanoInsectosDescripcion,
      this.ausenciaInsectosVivos,
      this.ausenciaInsectosVivosDescripcion,
      this.ausenciaCorteza,
      this.ausenciaCortezaDescripcion,
      this.razonSocial,
      this.manifesto,
      this.producto,
      this.envioMuestra,
      this.observaciones,
      this.dictamenFinal,
      this.usuario,
      this.usuarioId,
      this.fechaCreacion,
      this.idTablet,
      this.tabletId,
      this.tabletVersionBase});

  int? id;
  String? idPuntoControl;
  String? puntoControl;
  String? areaInspeccion;
  String? identidadEmbalaje;
  String? idPaisOrigen;
  String? paisOrigen;
  int? numeroEmbalajes;
  int? numeroUnidades;
  String? marcaAutorizada;
  String? marcaAutorizadaDescripcion;
  String? marcaLegible;
  String? marcaLegibleDescripcion;
  String? ausenciaDanoInsectos;
  String? ausenciaDanoInsectosDescripcion;
  String? ausenciaInsectosVivos;
  String? ausenciaInsectosVivosDescripcion;
  String? ausenciaCorteza;
  String? ausenciaCortezaDescripcion;
  String? razonSocial;
  String? manifesto;
  String? producto;
  String? envioMuestra;
  String? observaciones;
  String? dictamenFinal;
  String? usuario;
  String? usuarioId;
  String? fechaCreacion;
  int? idTablet;
  String? tabletId;
  String? tabletVersionBase;

  factory EmbalajeControlModelo.fromJson(Map<String, dynamic> json) =>
      EmbalajeControlModelo(
        id: json["id"],
        idPuntoControl: json["id_punto_control"],
        puntoControl: json["punto_control"],
        areaInspeccion: json["area_inspeccion"],
        identidadEmbalaje: json["identidad_embalaje"],
        idPaisOrigen: json["id_pais_origen"],
        paisOrigen: json["pais_origen"],
        numeroEmbalajes: json["numero_embalajes"],
        numeroUnidades: json["numero_unidades"],
        marcaAutorizada: json["marca_autorizada"],
        marcaAutorizadaDescripcion: json["marca_autorizada_descripcion"],
        marcaLegible: json["marca_legible"],
        marcaLegibleDescripcion: json["marca_legible_descripcion"],
        ausenciaDanoInsectos: json["ausencia_dano_insectos"],
        ausenciaDanoInsectosDescripcion:
            json["ausencia_dano_insectos_descripcion"],
        ausenciaInsectosVivos: json["ausencia_insectos_vivos"],
        ausenciaInsectosVivosDescripcion:
            json["ausencia_insectos_vivos_descripcion"],
        ausenciaCorteza: json["ausencia_corteza"],
        ausenciaCortezaDescripcion: json["ausencia_corteza_descripcion"],
        razonSocial: json["razon_social"],
        manifesto: json["manifesto"],
        producto: json["producto"],
        envioMuestra: json["envio_muestra"],
        observaciones: json["observaciones"],
        dictamenFinal: json["dictamen_final"],
        usuario: json["usuario"],
        usuarioId: json["usuario_id"],
        fechaCreacion: json["fecha_creacion"],
        idTablet: json["id_tablet"],
        tabletId: json["tablet_id"],
        tabletVersionBase: json["tablet_version_base"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_punto_control": idPuntoControl,
        "punto_control": puntoControl,
        "area_inspeccion": areaInspeccion,
        "identidad_embalaje": identidadEmbalaje,
        "id_pais_origen": idPaisOrigen,
        "pais_origen": paisOrigen,
        "numero_embalajes": numeroEmbalajes,
        "numero_unidades": numeroUnidades,
        "marca_autorizada": marcaAutorizada,
        "marca_autorizada_descripcion": marcaAutorizadaDescripcion,
        "marca_legible": marcaLegible,
        "marca_legible_descripcion": marcaLegibleDescripcion,
        "ausencia_dano_insectos": ausenciaDanoInsectos,
        "ausencia_dano_insectos_descripcion": ausenciaDanoInsectosDescripcion,
        "ausencia_insectos_vivos": ausenciaInsectosVivos,
        "ausencia_insectos_vivos_descripcion": ausenciaInsectosVivosDescripcion,
        "ausencia_corteza": ausenciaCorteza,
        "ausencia_corteza_descripcion": ausenciaCortezaDescripcion,
        "razon_social": razonSocial,
        "manifesto": manifesto,
        "producto": producto,
        "envio_muestra": envioMuestra,
        "observaciones": observaciones,
        "dictamen_final": dictamenFinal,
        "usuario": usuario,
        "usuario_id": usuarioId,
        "fecha_creacion": fechaCreacion,
        "id_tablet": idTablet,
        "tablet_id": tabletId,
        "tablet_version_base": tabletVersionBase
      };

  @override
  String toString() {
    return '''
        identidad_embalaje: $identidadEmbalaje,
        id_pais_origen: $idPaisOrigen,
        pais_origen: $paisOrigen,
        numero_embalajes: $numeroEmbalajes,
        numero_unidades: $numeroUnidades,
        marca_autorizada: $marcaAutorizada,
        marca_autorizada_descripcion: $marcaAutorizadaDescripcion,
        marca_legible: $marcaLegible,
        marca_legible_descripcion: $marcaLegibleDescripcion,
        ausencia_dano_insectos: $ausenciaDanoInsectos,
        ausencia_dano_insectos_descripcion: $ausenciaDanoInsectosDescripcion,
        ausencia_insectos_vivos: $ausenciaInsectosVivos,
        ausencia_insectos_vivos_descripcion: $ausenciaInsectosVivosDescripcion,
        ausencia_corteza: $ausenciaCorteza,
        ausencia_corteza_descripcion: $ausenciaCortezaDescripcion,
        razon_social: $razonSocial,
        manifesto: $manifesto,
        producto: $producto,
        envio_muestra: $envioMuestra,
        observaciones: $observaciones,
        dictamen_final: $dictamenFinal,
        usuario: $usuario,
        usuario_id: $usuarioId,
        fecha_creacion: $fechaCreacion,
        id_tablet: $idTablet,
        tablet_id: $tabletId,
        tablet_version_base: $tabletVersionBase
        ''';
  }
}
