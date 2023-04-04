class DBTrampeoViSvSql {
  static List<String> script = [
    trampaPadre,
    trampa,
    detalleTrampa,
    trampaSincronizada,
    ordenLaboratorio
  ];

  static List<String> updateV2 = [updateBdd2_1, updateBdd2_2];

  static const trampaPadre = '''CREATE TABLE IF NOT EXISTS inspecion_padre (
      id integer PRIMARY KEY,
      id_tablet INTEGER,
      fecha_inspeccion timestamp,
      usuario_id  TEXT,
      usuario  TEXT,
      tablet_id  TEXT,
      tablet_version_base TEXT
      ); ''';

  static const trampa = '''CREATE TABLE IF NOT EXISTS trampas (
      id INTEGER PRIMARY KEY,
      idTrampa INTEGER UNIQUE ON CONFLICT IGNORE,
      idprovincia INTEGER,
      provincia TEXT,
      idcanton INTEGER,
      canton TEXT,
      idparroquia INTEGER,
      parroquia TEXT,
      idlugarinstalacion INTEGER,
      lugarinstalacion TEXT,
      numerolugarinstalacion TEXT,
      tipotrampa TEXT,
      codigotrampa TEXT,
      coordenadax TEXT,
      coordenaday TEXT,
      coordenadaz TEXT,
      fechainstalacion TIMESTAMP,
      estadotrampa TEXT,
      nombreplaga TEXT,
      secuencialorden INTEGER,
      fecha_inspeccion TIMESTAMP,
      utilizado INTEGER
      ); ''';

  static const detalleTrampa = '''create table IF NOT EXISTS detalle_trampa (
      id INTEGER PRIMARY KEY,
      id_tablet INTEGER,
      fecha_instalacion timestamp,
      codigo_trampa TEXT,
      tipo_trampa TEXT(64),
      id_provincia TEXT,
      nombre_provincia TEXT, 
      id_canton TEXT,
      nombre_canton TEXT, 
      id_parroquia TEXT, 
      nombre_parroquia TEXT, 
      estado_trampa TEXT, 
      coordenada_x TEXT,
      coordenada_y TEXT,
      coordenada_z TEXT, 
      id_lugar_instalacion TEXT, 
      nombre_lugar_instalacion TEXT, 
      numero_lugar_instalacion integer, 
      fecha_inspeccion timestamp , 
      semana TEXT,
      usuario_id TEXT, 
      usuario TEXT, 
      propiedad_finca TEXT, 
      condicion_trampa TEXT,
      especie TEXT, 
      procedencia TEXT, 
      condicion_cultivo TEXT, 
      etapa_cultivo TEXT, 
      exposicion TEXT, 
      cambio_feromona TEXT, 
      cambio_papel TEXT, 
      cambio_aceite TEXT, 
      cambio_trampa TEXT, 
      numero_especimenes integer DEFAULT 0, 
      diagnostico_visual TEXT, 
      fase_plaga TEXT, 
      observaciones text, 
      envio_muestra TEXT,
      tablet_id TEXT,
      tablet_version_base TEXT,
      foto TEXT,
      id_padre INTEGER
      ); ''';

  static const trampaSincronizada =
      '''create TABLE IF NOT EXISTS provincias_sincronizadas_trampas_sv (
      id integer PRIMARY key,
      id_localizacion integer UNIQUE ON CONFLICT IGNORE
      ); ''';

  static const ordenLaboratorio =
      '''CREATE TABLE IF NOT EXISTS orden_laboratorio (
      id INTEGER PRIMARY KEY,
      id_tablet INTEGER,
      actividad_origen TEXT,
      analisis TEXT,
      codigo_muestra TEXT,
      conservacion TEXT,
      tipo_muestra TEXT,
      descripcion_sintomas TEXT,
      fase_fenologica TEXT,
      nombre_producto TEXT,
      peso_muestra INTEGER,
      prediagnostico TEXT,
      tipo_cliente TEXT,
      aplicacion_producto_quimico TEXT,
      codigo_trampa TEXT,
      id_padre INTEGER
      ); ''';

  static const updateBdd2_1 = 'DROP TABLE IF EXISTS detalle_trampa;';

  static const updateBdd2_2 = '''create table IF NOT EXISTS detalle_trampa (
      id INTEGER PRIMARY KEY, 
      id_tablet integer,
      fecha_instalacion timestamp,
      codigo_trampa TEXT,
      tipo_trampa TEXT(64),
      id_provincia TEXT,
      nombre_provincia TEXT, 
      id_canton TEXT,
      nombre_canton TEXT, 
      id_parroquia TEXT, 
      nombre_parroquia TEXT, 
      estado_trampa TEXT, 
      coordenada_x TEXT,
      coordenada_y TEXT,
      coordenada_z TEXT, 
      id_lugar_instalacion TEXT, 
      nombre_lugar_instalacion TEXT, 
      numero_lugar_instalacion INTEGER, 
      fecha_inspeccion timestamp , 
      semana TEXT,
      usuario_id TEXT, 
      usuario TEXT, 
      propiedad_finca TEXT, 
      condicion_trampa TEXT,
      especie TEXT, 
      procedencia TEXT, 
      condicion_cultivo TEXT, 
      etapa_cultivo TEXT, 
      exposicion TEXT, 
      cambio_feromona TEXT, 
      cambio_papel TEXT, 
      cambio_aceite TEXT, 
      cambio_trampa TEXT, 
      numero_especimenes INTEGER DEFAULT 0, 
      diagnostico_visual TEXT, 
      fase_plaga TEXT, 
      observaciones text, 
      envio_muestra TEXT,
      tablet_id TEXT,
      tablet_version_base TEXT,
      foto TEXT,
      id_padre INTEGER
      );''';
}
