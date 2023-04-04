class DBCaracterizacionFrMfSv {
  static List<String> script = [
    _provinciaSincronizada,
    _caracterizacion,
  ];

  static const _provinciaSincronizada =
      '''CREATE TABLE IF NOT EXISTS provincia_sincronizada_caracterizacion_fr_mf_sv(
      id INTEGER PRIMARY KEY,
      id_localizacion INTEGER UNIQUE ON CONFLICT IGNORE,
      codigo TEXT,
      nombre TEXT,
      id_localizacion_padre INTEGER,
      categoria INTEGER
      ); ''';

  static const _caracterizacion = '''CREATE TABLE IF NOT EXISTS moscaf02 (
      id INTEGER NOT NULL PRIMARY KEY,
      id_tablet INTEGER,
      nombre_asociacion_productor TEXT,
      identificador TEXT,
      telefono TEXT,
      codigo_provincia TEXT,
      provincia TEXT,
      codigo_canton TEXT,
      canton TEXT,
      codigo_parroquia TEXT,
      parroquia TEXT,
      sitio TEXT,
      especie TEXT,
      variedad TEXT,
      area_produccion_estimada TEXT,
      coordenada_x TEXT,
      coordenada_y TEXT,
      coordenada_z TEXT,
      observaciones TEXT,
      fecha_inspeccion DATETIME,
      usuario_id TEXT,
      usuario TEXT,
      tablet_id TEXT,
      tablet_version_base TEXT,
      imagen TEXT
      );''';
}
