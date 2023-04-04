class DBCatalogosSql {
  static List<String> script = [
    _puertos,
    _lugarInspeccion,
    _envases,
    _paisOrigen,
    _productosTransito,
    _provinciaContrato,
  ];

  static const _puertos = '''
    CREATE TABLE IF NOT EXISTS puertos_catalogos (
      id INTEGER PRIMARY KEY,
      id_puerto INTEGER UNIQUE ON CONFLICT IGNORE,
      nombre TEXT
    );
  ''';

  static const _lugarInspeccion = '''
    CREATE TABLE IF NOT EXISTS lugar_inspeccion (
      id INTEGER PRIMARY KEY,
      nombre TEXT, 
      id_puerto INTEGER -- foreing key puertos_catalogo
    );
  ''';

  static const _envases = '''
    CREATE TABLE IF NOT EXISTS tipos_envase (
      id INTEGER PRYMARY KEY,
      id_envase INTEGER UNIQUE ON CONFLICT IGNORE,
      nombre_envase TEXT, 
      id_area INTEGER
    );
  ''';

  static const _paisOrigen = '''
    CREATE TABLE IF NOT EXISTS paises_origen_procedencia (
      id INTEGER PRYMARY KEY,
      id_localizacion INTEGER UNIQUE ON CONFLICT IGNORE,
      nombre TEXT
    );
  ''';

  static const _productosTransito = '''
    CREATE TABLE IF NOT EXISTS productos_transito (
      id INTEGER PRYMARY KEY,
      partida_arancelaria TEXT UNIQUE ON CONFLICT IGNORE,
      nombre TEXT,
      subtipo TEXT
    );
  ''';

  static const _provinciaContrato =
      'CREATE TABLE IF NOT EXISTS provincia_usuario_contrato ('
      'id INTEGER PRIMARY KEY,'
      'identificador TEXT NOT NULL,'
      'provincia TEXT NOT NULL'
      '); ';
}
