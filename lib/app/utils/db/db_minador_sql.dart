class DBMinadorSql {
  static List<String> script = [_productores, _sitios, _minador];
  static List<String> scriptCatalogos = [_productores, _sitios, _minador];
  static List<String> scriptDrop = [_dropMinador, _dropPreguntas];

  static List<String> scriptDelete = [
    _deleteMinador,
    _deleteSitios,
    _deleteProductores
  ];
  static const String _dropMinador =
      'DROP TABLE IF EXISTS minador_certificacionf08;';
  static const String _dropPreguntas =
      'DROP TABLE IF EXISTS minador_preguntas;';

  static const String _deleteSitios = 'DELETE TABLE minador_sitios;';
  static const String _deleteProductores = 'DELETE TABLE minador_productores;';
  static const String _deleteMinador = 'DELETE TABLE minador_certificacionf08;';

  static const String _sitios = 'CREATE TABLE IF NOT EXISTS  minador_sitios ('
      'id_area INTEGER PRIMARY KEY,'
      'area TEXT,'
      'sitio TEXT,'
      'id_sitio INTEGER,'
      'tipo_area TEXT,'
      'direccion TEXT,'
      'parroquia TEXT,'
      'canton TEXT,'
      'provincia TEXT,'
      'identificador_operador TEXT'
      '); ';

  static const String _productores =
      'CREATE TABLE IF NOT EXISTS minador_productores ('
      'identificador TEXT PRIMARY KEY,'
      'nombre TEXT'
      '); ';

  static const String _minador =
      'CREATE TABLE IF NOT EXISTS minador_certificacionf08('
      'id  INTEGER PRIMARY KEY,'
      'id_tablet INTEGER,'
      'numero_reporte TEXT,'
      'ruc TEXT,'
      'razon_social TEXT,'
      'provincia TEXT,'
      'canton TEXT,'
      'parroquia TEXT,'
      'id_sitio_produccion TEXT,'
      'sitio_produccion TEXT,'
      'representante TEXT,'
      'resultado TEXT,'
      'observaciones TEXT,'
      'fecha_inspeccion TEXT,'
      'usuario_id TEXT,'
      'usuario TEXT,'
      'tablet_id TEXT,'
      'tablet_version_base TEXT,'
      'fecha_ingreso_guia TEXT,'
      'estado_f08 TEXT,'
      'observacion_f08 TEXT,'
      'tipo_area TEXT,'
      'total_resultado INTEGER,'
      'total_areas INTEGER,'
      'id_ponderacion INTEGER'
      '); ';
}
