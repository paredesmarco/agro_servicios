class DBTripSql {
  static List<String> script = [_productores, _sitios, _trips];
  static List<String> scriptCatalogos = [_productores, _sitios, _trips];
  static List<String> scriptDrop = [_dropTrips, _dropPreguntas];

  static List<String> scriptDelete = [
    _deleteTrips,
    _deleteSitios,
    _deleteProductores
  ];
  static const _dropTrips = 'DROP TABLE IF EXISTS trips_certificacionf09;';
  static const _dropPreguntas = 'DROP TABLE IF EXISTS trips_preguntas;';

  static const _deleteSitios = 'DELETE TABLE trips_sitios;';
  static const _deleteProductores = 'DELETE TABLE trips_productores;';
  static const _deleteTrips = 'DELETE TABLE trips_certificacionf09;';

  static const _sitios = '''CREATE TABLE IF NOT EXISTS  trips_sitios (
      id_area INTEGER PRIMARY KEY,
      area TEXT,
      sitio TEXT,
      id_sitio INTEGER,
      tipo_area TEXT,
      direccion TEXT,
      parroquia TEXT,
      canton TEXT,
      provincia TEXT,
      identificador_operador TEXT
      ); ''';

  static const _productores = '''CREATE TABLE IF NOT EXISTS trips_productores (
      identificador TEXT PRIMARY KEY,
      nombre TEXT
      ); ''';

  static const _trips = '''CREATE TABLE IF NOT EXISTS trips_certificacionf09(
      id  INTEGER PRIMARY KEY,
      id_tablet INTEGER,
      numero_reporte TEXT,
      ruc TEXT,
      razon_social TEXT,
      provincia TEXT,
      canton TEXT,
      parroquia TEXT,
      id_sitio_produccion TEXT,
      sitio_produccion TEXT,
      representante TEXT,
      resultado TEXT,
      observaciones TEXT,
      fecha_inspeccion TEXT,
      usuario_id TEXT,
      usuario TEXT,
      tablet_id TEXT,
      tablet_version_base TEXT,
      fecha_ingreso_guia TEXT,
      estado_f09 TEXT,
      observacion_f09 TEXT,
      tipo_area TEXT,
      total_resultado INTEGER,
      total_areas INTEGER,
      id_ponderacion INTEGER
      ); ''';
}
