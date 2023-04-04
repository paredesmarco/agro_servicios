class MuestreoMfSvModelo {
  MuestreoMfSvModelo({
    this.id,
    this.idTablet,
    this.codigoProvincia,
    this.nombreProvincia,
    this.codigoCanton,
    this.nombreCanton,
    this.codigoParroquia,
    this.nombreParroquia,
    this.semana,
    this.coordenadaX,
    this.coordenadaY,
    this.coordenadaZ,
    this.fechaInspeccion,
    this.usuarioId,
    this.usuario,
    this.tabletId,
    this.tabletVersionBase,
    this.sitio,
    this.envioMuestra = 'Si',
    this.imagen,
  });
  int? id;
  int? idTablet;
  String? codigoProvincia;
  String? nombreProvincia;
  String? codigoCanton;
  String? nombreCanton;
  String? codigoParroquia;
  String? nombreParroquia;
  // String? codigoLugarMuestreo;
  // String? nombreLugarMuestreo;
  int? semana;
  String? coordenadaX;
  String? coordenadaY;
  String? coordenadaZ;
  String? fechaInspeccion;
  String? usuarioId;
  String? usuario;
  String? tabletId;
  String? tabletVersionBase;
  String? sitio;
  String? envioMuestra;
  String? imagen;

  factory MuestreoMfSvModelo.fromJson(Map<String, dynamic> json) =>
      MuestreoMfSvModelo(
        id: json["id"],
        idTablet: json["id_tablet"],
        codigoProvincia: json["codigo_provincia"],
        nombreProvincia: json["nombre_provincia"],
        codigoCanton: json["codigo_canton"],
        nombreCanton: json["nombre_canton"],
        codigoParroquia: json["codigo_parroquia"],
        nombreParroquia: json["nombre_parroquia"],
        semana: json["semana"],
        coordenadaX: json["coordenada_x"],
        coordenadaY: json["coordenada_y"],
        coordenadaZ: json["coordenada_z"],
        fechaInspeccion: json["fecha_inspeccion"],
        usuarioId: json["usuario_id"],
        usuario: json["usuario"],
        tabletId: json["tablet_id"],
        tabletVersionBase: json["tablet_version_base"],
        sitio: json["sitio"],
        envioMuestra: json["envio_muestra"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tablet": idTablet,
        "codigo_provincia": codigoProvincia,
        "nombre_provincia": nombreProvincia,
        "codigo_canton": codigoCanton,
        "nombre_canton": nombreCanton,
        "codigo_parroquia": codigoParroquia,
        "nombre_parroquia": nombreParroquia,
        "semana": semana,
        "coordenada_x": coordenadaX,
        "coordenada_y": coordenadaY,
        "coordenada_z": coordenadaZ,
        "fecha_inspeccion": fechaInspeccion,
        "usuario_id": usuarioId,
        "usuario": usuario,
        "tablet_id": tabletId,
        "tablet_version_base": tabletVersionBase,
        "sitio": sitio,
        "envio_muestra": envioMuestra,
        "imagen": imagen,
      };

  @override
  String toString() {
    return ('''MuestreoMfSvModelo : { 
      idTablet: $idTablet,
      codigoProvincia: $codigoProvincia,
      nombreProvincia: $nombreProvincia,
      codigoCanton: $codigoCanton,
      nombreCanton: $nombreCanton,
      codigoParroquia: $codigoParroquia,
      nombreParroquia: $nombreParroquia,
      semana: $semana,
      coordenadaX: $coordenadaX,
      coordenadaY: $coordenadaY,
      coordenadaZ: $coordenadaZ,
      fechaInspeccion: $fechaInspeccion,
      usuarioId: $usuarioId,
      usuario: $usuario,
      tabletId: $tabletId,
      tabletVersionBase: $tabletVersionBase,
      sitio: $sitio,
      envioMuestra: $envioMuestra,
      imagen: $imagen
     }''');
  }
}
