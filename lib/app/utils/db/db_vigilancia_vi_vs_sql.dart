class DBVigilanciaViSvSql {
  static List<String> script = [
    _vigilancia,
    _ordenLaboratorio,
    _provinciaSincronizada
  ];

  List<String> updateV5 = [_updateBdd];

  static const _vigilancia =
      '''CREATE TABLE IF NOT EXISTS monitoreo_vigilancia_sv (
      id INTEGER PRIMARY KEY,
      idTablet TEXT,
      codigoProvincia TEXT,
      nombreProvincia TEXT,
      codigoCanton TEXT,
      nombreCanton TEXT,
      codigoParroquia TEXT,
      nombreParroquia TEXT,
      nombrePropietarioFinca TEXT,
      localidadOvia TEXT,
      coordenadaX TEXT,
      coordenadaY TEXT,
      coordenadaZ TEXT,
      denuncia TEXT,
      nombreDenunciante TEXT,
      telefonoDenunciante TEXT,
      direccionDenunciante TEXT,
      correoDenunciante TEXT,
      especie TEXT,
      cantidadTotal REAL,
      cantidadVigilancia REAL,
      unidad TEXT,
      sitioOperacion TEXT,
      condicionProduccion TEXT,
      etapaCultivo TEXT,
      actividad TEXT,
      manejoSitioOperacion TEXT,
      presenciaPlagas TEXT,
      plagaPrediagnostico TEXT,
      cantidadAfectada REAL,
      incidencia REAL,
      severidad REAL,
      tipoPlaga TEXT,
      fasePlaga TEXT,
      organoAfectado TEXT,
      distribucionPlaga TEXT,
      poblacion REAL,
      diagnosticoVisual TEXT,
      descripcionSintoma TEXT,
      envioMuestra TEXT,
      observaciones TEXT,
      fechaInspeccion TEXT,
      usuarioId TEXT,
      usuario TEXT,
      tabletId TEXT,
      tabletBase TEXT,
      imagen TEXT,
      longitudImagen TEXT,
      latitudImagen TEXT,
      alturaImagen TEXT
      ); ''';

  static const _ordenLaboratorio =
      '''CREATE TABLE IF NOT EXISTS vigilancia_orden_sv (
      id INTEGER PRIMARY KEY,
      tipoMuestra TEXT,
      conservacion TEXT,
      codigoMuestra TEXT,
      analisisSolicitado TEXT,
      idVigilancia INTEGER NOT NULl,
      especie TEXT
      ); ''';

  static const _provinciaSincronizada =
      '''CREATE TABLE IF NOT EXISTS provincia_sincronizada_vigilancia_sv (
      id INTEGER PRIMARY KEY,
      id_localizacion INTEGER UNIQUE ON CONFLICT IGNORE,
      codigo TEXT,
      nombre TEXT,
      id_localizacion_padre INTEGER,
      categoria INTEGER
      ); ''';

  static const _updateBdd = 'DROP TABLE IF EXISTS vigilancia_sv;';
}
