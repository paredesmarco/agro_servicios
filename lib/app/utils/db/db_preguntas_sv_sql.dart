class DBPreguntasSvSql {
  static List<String> script = [_preguntas, _poderacion];
  static List<String> scriptDrop = [
    _dropPonderacion,
    _dropPreguntas,
  ];
  static List<String> scriptDelete = [_deletePreguntas, _deletePonderacion];

  static const _dropPreguntas = 'DROP TABLE IF EXISTS preguntas_sv;';
  static const _dropPonderacion = 'DROP TABLE IF EXISTS ponderacion_sv;';

  static const _deletePreguntas = 'DELETE TABLE preguntas_sv;';
  static const _deletePonderacion = 'DELETE TABLE ponderacion_sv;';

  static const _preguntas = '''CREATE TABLE IF NOT EXISTS  preguntas_sv (
      id   INTEGER  PRIMARY KEY,
      formulario TEXT,
      tipo_area TEXT,
      orden INTEGER,
      pregunta TEXT,
      puntos INTEGER,
      tab  TEXT,
      tipo  TEXT,
      modo_visualizar  TEXT,
      fecha TEXT,
      estado TEXT,
      tipo_dato TEXT,
      obligatorio TEXT,
      opciones_respuesta TEXT
      ); ''';

  static const _poderacion = '''CREATE TABLE IF NOT EXISTS ponderacion_sv (
      id   INTEGER PRIMARY KEY, 		
      formulario TEXT,
      tipo_area TEXT,
      resultado TEXT,
      rinicial INTEGER,
      rfinal INTEGER,
      fecha TEXT
      ); ''';
}
