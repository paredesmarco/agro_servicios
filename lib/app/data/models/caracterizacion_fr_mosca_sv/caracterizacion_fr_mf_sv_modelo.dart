class CaracterizacionFrMfSvModelo {
  CaracterizacionFrMfSvModelo(
      {this.id,
      this.idTablet,
      this.nombreAsociacionProductor,
      this.identificador,
      this.telefono,
      this.codigoProvincia,
      this.provincia,
      this.codigoCanton,
      this.canton,
      this.codigoParroquia,
      this.parroquia,
      this.sitio,
      this.especie,
      this.variedad,
      this.areaProduccionEstimada,
      this.coordenadaX,
      this.coordenadaY,
      this.coordenadaZ,
      this.observaciones,
      this.fechaInspeccion,
      this.usuarioId,
      this.usuario,
      this.tabletId,
      this.tabletVersionBase,
      this.imagen});

  int? id;
  int? idTablet;
  String? nombreAsociacionProductor;
  String? identificador;
  String? telefono;
  String? codigoProvincia;
  String? provincia;
  String? codigoCanton;
  String? canton;
  String? codigoParroquia;
  String? parroquia;
  String? sitio;
  String? especie;
  String? variedad;
  String? areaProduccionEstimada;
  String? coordenadaX;
  String? coordenadaY;
  String? coordenadaZ;
  String? observaciones;
  String? fechaInspeccion;
  String? usuarioId;
  String? usuario;
  String? tabletId;
  String? tabletVersionBase;
  String? imagen;

  factory CaracterizacionFrMfSvModelo.fromJson(Map<String, dynamic> json) =>
      CaracterizacionFrMfSvModelo(
        id: json["id"],
        idTablet: json["id_tablet"],
        nombreAsociacionProductor: json["nombre_asociacion_productor"],
        identificador: json["identificador"],
        telefono: json["telefono"],
        codigoProvincia: json["codigo_provincia"],
        provincia: json["provincia"],
        codigoCanton: json["codigo_canton"],
        canton: json["canton"],
        codigoParroquia: json["codigo_parroquia"],
        parroquia: json["parroquia"],
        sitio: json["sitio"],
        especie: json["especie"],
        variedad: json["variedad"],
        areaProduccionEstimada: json["area_produccion_estimada"],
        coordenadaX: json["coordenada_x"],
        coordenadaY: json["coordenada_y"],
        coordenadaZ: json["coordenada_z"],
        observaciones: json["observaciones"],
        fechaInspeccion: json["fecha_inspeccion"],
        usuarioId: json["usuario_id"],
        usuario: json["usuario"],
        tabletId: json["tablet_id"],
        tabletVersionBase: json["tablet_version_base"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tablet": idTablet,
        "nombre_asociacion_productor": nombreAsociacionProductor,
        "identificador": identificador,
        "telefono": telefono,
        "codigo_provincia": codigoProvincia,
        "provincia": provincia,
        "codigo_canton": codigoCanton,
        "canton": canton,
        "codigo_parroquia": codigoParroquia,
        "parroquia": parroquia,
        "sitio": sitio,
        "especie": especie,
        "variedad": variedad,
        "area_produccion_estimada": areaProduccionEstimada,
        "coordenada_x": coordenadaX,
        "coordenada_y": coordenadaY,
        "coordenada_z": coordenadaZ,
        "observaciones": observaciones,
        "fecha_inspeccion": fechaInspeccion!,
        "usuario_id": usuarioId,
        "usuario": usuario,
        "tablet_id": tabletId,
        "tablet_version_base": tabletVersionBase,
        "imagen": imagen,
      };

  @override
  String toString() {
    return '''
    CaracterizacionFrMfSvModelo {
    id : $id
    idTablet : $idTablet
    nombreAsociacionProductor : $nombreAsociacionProductor
    identificador : $identificador
    telefono : $telefono
    codigoProvincia : $codigoProvincia
    provincia : $provincia
    codigoCanton : $codigoCanton
    canton : $canton
    codigoParroquia : $codigoParroquia
    parroquia : $parroquia
    sitio : $sitio
    especie : $especie
    variedad : $variedad
    areaProduccionEstimada : $areaProduccionEstimada
    coordenadaX : $coordenadaX
    coordenadaY : $coordenadaY
    coordenadaZ : $coordenadaZ
    observaciones : $observaciones
    fechaInspeccion : $fechaInspeccion
    usuarioId : $usuarioId
    usuario : $usuario
    tabletId : $tabletId
    tabletVersionBase : $tabletVersionBase
    imagen : $imagen
    }
    ''';
  }
}
