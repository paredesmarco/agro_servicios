class DBMuestreoMfSvSql {
  static List<String> script = [
    _provinciaSincronizada,
    _ordenLaboratorio,
    _mosca,
  ];

  static const _provinciaSincronizada =
      '''CREATE TABLE IF NOT EXISTS provincia_sincronizada_muestreo_mf_sv(
      id INTEGER PRIMARY KEY,
      id_localizacion INTEGER UNIQUE ON CONFLICT IGNORE,
      codigo TEXT,
      nombre TEXT,
      id_localizacion_padre INTEGER,
      categoria INTEGER
      ); ''';

  static const _mosca = '''create TABLE IF NOT EXISTS moscaf03 (
      id INTEGER PRIMARY KEY,
      id_tablet INTEGER,
      codigo_provincia TEXT,
      nombre_provincia TEXT, 
      codigo_canton TEXT,
      nombre_canton TEXT,
      codigo_parroquia TEXT,
      nombre_parroquia TEXT, 
      codigo_lugar_muestreo TEXT,
      nombre_lugar_muestreo TEXT, 
      semana integer,
      coordenada_x TEXT, 
      coordenada_y TEXT,
      coordenada_z TEXT, 
      fecha_inspeccion timestamp,
      usuario_id TEXT,
      usuario TEXT,
      tablet_id TEXT,
      tablet_version_base TEXT,
      sitio TEXT,
      envio_muestra TEXT,
      imagen TEXT);''';

  static const _ordenLaboratorio =
      '''create table IF NOT EXISTS moscaf03_detalle_ordenes(
      id INTEGER primary key,
      id_padre INTEGER,
      id_tablet INTEGER,
      aplicacion_producto_quimico TEXT,
      codigo_muestra TEXT,
      descripcion_sintomas TEXT,
      peso_muestra TEXT,
      especie_vegetal TEXT,
      sitio_muestreo TEXT,
      numero_frutos_colectados TEXT,
      id_muestreo INTEGER
      );''';
}
