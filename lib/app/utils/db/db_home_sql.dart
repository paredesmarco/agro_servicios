class DBHomeSql {
  static List<String> script = [
    _usuario,
    _aplicacion,
    _area,
    _localizacion,
    _insertLocalizacion
  ];

  static List<String> updateV4 = [_updatev4];

  static const _usuario = '''CREATE TABLE IF NOT EXISTS usuario (
      id INTEGER PRIMARY KEY,
      identificador TEXT,
      nombre TEXT,
      tipo TEXT,
      foto TEXT,
      pin TEXT,
      fecha_caducidad TIMESTAMP
      );''';

  static const _aplicacion = '''CREATE TABLE IF NOT EXISTS aplicacion (
      id INTEGER PRIMARY KEY,
      nombre TEXT,
      version TEXT,
      descripcion TEXT,
      color_inicio TEXT,
      color_fin TEXT,
      codificacion_aplicacion TEXT,
      estado_aplicacion TEXT,
      id_area TEXT,
      vista TEXT,
      orden INTEGER
      ); ''';

  static const _area = '''CREATE TABLE IF NOT EXISTS area (
      id INTEGER PRIMARY KEY,
      id_area TEXT,
      nombre TEXT,
      nombre_corto TEXT,
      id_area_padre TEXT
      ); ''';

  static const _localizacion = '''CREATE TABLE IF NOT EXISTS localizacion (
      id integer PRIMARY KEY,
      id_localizacion INTEGER UNIQUE ON CONFLICT IGNORE,
      codigo TEXT,
      nombre TEXT,
      id_localizacion_padre INTEGER,
      categoria INTEGER
      ); ''';

  static const _insertLocalizacion =
      '''INSERT INTO localizacion (id_localizacion,codigo,nombre,id_localizacion_padre,categoria) VALUES 
      (241,'EC-A','Azuay',66,1),
      (242,'EC-B','Bolívar',66,1),
      (243,'EC-F','Cañar',66,1),
      (244,'EC-C','Carchi',66,1),
      (245,'EC-H','Chimborazo',66,1),
      (246,'EC-X','Cotopaxi',66,1),
      (247,'EC-O','El Oro',66,1),
      (248,'EC-E','Esmeraldas',66,1),
      (249,'EC-W','Galapagos',66,1),
      (250,'EC-G','Guayas',66,1),
      (251,'EC-I','Imbabura',66,1),
      (252,'EC-L','Loja',66,1),
      (253,'EC-R','Los Ríos',66,1),
      (254,'EC-M','Manabí',66,1),
      (255,'EC-S','Morona Santiago',66,1),
      (256,'EC-N','Napo',66,1),
      (257,'EC-D','Orellana',66,1),
      (258,'EC-Y','Pastaza',66,1),
      (259,'EC-P','Pichincha',66,1),
      (260,'EC-SE','Santa Elena',66,1),
      (261,'EC-SD','Santo Domingo de los Tsáchilas',66,1),
      (262,'EC-U','Sucumbíos',66,1),
      (263,'EC-T','Tungurahua',66,1),
      (264,'EC-Z','Zamora Chinchipe',66,1)
      ; ''';

  static const _updatev4 = 'DROP TABLE IF EXISTS aplicacion;';
}
