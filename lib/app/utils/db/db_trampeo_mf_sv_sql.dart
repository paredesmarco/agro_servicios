class DBTrampeoMfSvSql {
  static List<String> script = [_trampas, _detalleTrampa, _trampaPadre, _orden];

  static const _trampas = '''CREATE TABLE IF NOT EXISTS moscaf01_trampas (
      id INTEGER PRIMARY KEY,
      id_provincia INTEGER,
      provincia TEXT,
      id_canton INTEGER,
      canton TEXT,
      id_parroquia INTEGER,
      parroquia TEXT,
      id_lugar_instalacion INTEGER,
      nombre_lugar_instalacion TEXT,
      numero_lugar_instalacion INTEGER,
      id_tipo_atrayente INTEGER,
      nombre_tipo_atrayente TEXT,
      nombre_tipo_trampa TEXT,
      codigo_trampa TEXT,
      coordenadax TEXT,
      coordenaday TEXT,
      coordenadaz TEXT,
      fecha_instalacion DateTime,
      estado_trampa TEXT,
      secuencial_orden INTEGER,
      fecha_inspeccion DateTime,
      utilizado INTEGER DEFAULT 0
      );''';

  static const _trampaPadre = '''CREATE TABLE IF NOT EXISTS moscaf01 (
      id INTEGER PRIMARY KEY,
      id_tablet INTEGER,
      fecha_inspeccion DateTime,
      usuario_id TEXT,
      usuario  TEXT,
      tablet_id  TEXT,
      tablet_version_base TEXT,
      observacion_mf01 TEXT
      );''';

  static const _detalleTrampa =
      '''CREATE TABLE IF NOT EXISTS moscaf01_detalle_trampas (
      id INTEGER PRIMARY KEY,
      id_padre INTEGER,
      id_tablet INTEGER,
      id_provincia TEXT,
      nombre_provincia TEXT,
      id_canton TEXT,
      nombre_canton TEXT,
      id_parroquia TEXT,
      nombre_parroquia TEXT,
      id_lugar_instalacion TEXT,
      nombre_lugar_instalacion TEXT,
      numero_lugar_instalacion INTEGER,
      id_tipo_atrayente TEXT,
      nombre_tipo_atrayente TEXT,
      tipo_trampa TEXT,
      codigo_trampa TEXT,
      semana INTEGER,
      coordenada_x TEXT,
      coordenada_y TEXT,
      coordenada_z TEXT,
      fecha_instalacion timestamp,
      estado_trampa TEXT,
      exposicion TEXT,
      condicion TEXT,
      cambio_trampa TEXT,
      cambio_plug TEXT,
      especie_principal TEXT,
      estado_fenologico_principal TEXT,
      especie_colindante TEXT,
      estado_fenologico_colindante TEXT,
      numero_especimenes INTEGER DEFAULT 0,
      observaciones TEXT,
      envio_muestra TEXT,
      estado_registro TEXT,
      fecha_inspeccion DateTime,
      usuario_id TEXT,
      usuario TEXT,
      tablet_id TEXT,
      tablet_version_base TEXT
      );''';

  static const _orden = '''CREATE TABLE IF NOT EXISTS moscaf01_detalle_ordenes (
      id INTEGER PRIMARY KEY,
      id_padre INTEGER,
      id_tablet INTEGER,
      analisis TEXT,
      codigo_muestra TEXT,
      tipo_muestra TEXT,
      codigo_trampa_padre TEXT
      );''';
}
