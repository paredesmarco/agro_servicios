class DBProductosImportadosSql {
  static List<String> script = [
    _solicitudProductosImportadosSv,
    _productosSolictudProductosImportadosSv,
    _controlF01SV,
    _controlF01LoteSV,
    _controlF01ProductoSV,
    _controlF01OrdenSV,
    _solicitudProductosImportadosSA,
    _productosSolictudProductosImportadosSA,
    _controlF01SA,
    _controlF01LoteSA,
    _controlF01ProductoSA,
    _controlF01OrdenSA,
  ];

  static const _solicitudProductosImportadosSv = '''
    CREATE TABLE IF NOT EXISTS solicitud_productos_importados_sv (
      id integer PRIMARY KEY NOT NULL,
      pfi TEXT,
      estado TEXT,
      dda TEXT,
      razon_social TEXT,
      pais_origen TEXT,
      tipo_certificado TEXT
    );
  ''';

  static const _productosSolictudProductosImportadosSv = '''
    CREATE TABLE IF NOT EXISTS productos_solictud_productos_importados_sv (
      id integer PRIMARY KEY NOT NULL,
      nombre TEXT,
      cantidad_declarada TEXT,
      cantidad_ingresada TEXT,
      unidad TEXT,
      subtipo TEXT,
      control_f01_id INTEGER,
      id_tablet INTEGER
    );
  ''';

  static const _controlF01SV = '''
  CREATE TABLE IF NOT EXISTS control_f01_sv (
    id INTEGER PRIMARY KEY,
    pfi TEXT NOT NULL,
    dda TEXT NOT NULL,
    pregunta01 TEXT NOT NULL,
    pregunta02 TEXT NOT NULL,
    pregunta03 TEXT NOT NULL,
    pregunta04 TEXT NOT NULL,
    pregunta05 TEXT NOT NULL,
    pregunta06 TEXT NOT NULL,
    pregunta07 TEXT NOT NULL,
    pregunta08 TEXT NOT NULL,
    pregunta09 INTEGER NOT NULL,
    pregunta10 INTEGER NOT NULL,
    pregunta11 TEXT NOT NULL,
    categoria_riesgo TEXT NOT NULL,
    seguimiento_cuarentenario TEXT NOT NULL,
    provincia TEXT,
    peso_ingreso TEXT NOT NULL,
    envio_muestra TEXT NOT NULL,
    observaciones TEXT,
    dictamen_final TEXT NOT NULL,
    numero_embalajes_envio INTEGER NOT NULL,
    numero_embalajes_inspeccionados INTEGER NOT NULL,
    usuario TEXT NOT NULL,
    usuario_id TEXT NOT NULL,
    fecha_creacion TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_tablet INTEGER,
    tablet_id TEXT,
    tablet_version TEXT
  );
  ''';

  static const _controlF01LoteSV = '''
  CREATE TABLE IF NOT EXISTS control_f01_lote_sv(
    id INTEGER PRIMARY KEY,
    descripcion TEXT NOT NULL,
    numero_cajas INTEGER NOT NULL,
    cajas_muestra INTEGER NOT NULL,
    porcentaje_inspeccion TEXT NOT NULL,
    ausencia_suelo TEXT NOT NULL,
    ausencia_contaminantes TEXT NOT NULL,
    ausencia_sintomas TEXT NOT NULL,
    ausencia_plagas TEXT NOT NULL,
    dictamen TEXT NOT NULL,
    control_f01_id INTEGER NOT NULL,
    id_tablet INTEGER
  );
  ''';

  static const _controlF01OrdenSV = '''
  CREATE TABLE IF NOT EXISTS control_f01_orden_sv (
    id INTEGER PRIMARY KEY,
    nombre_producto TEXT NOT NULL,
    tipo_cliente TEXT NOT NULL,
    tipo_muestra TEXT NOT NULL,
    conservacion TEXT NOT NULL,
    actividad_origen TEXT NOT NULL,
    peso_muestra TEXT NOT NULL,
    codigo_muestra TEXT NOT NULL,
    prediagnostico TEXT NOT NULL,
    analisis TEXT NOT NULL,
    descripcion_sintomas TEXT NOT NULL,
    fase_fenologica TEXT NOT NULL,
    control_f01_id INTEGER NOT NULL,
    id_tablet INTEGER
  );
  ''';

  static const _controlF01ProductoSV = '''
  CREATE TABLE IF NOT EXISTS control_f01_producto_sv (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    cantidad_declarada TEXT,
    cantidad_ingresada TEXT,
    unidad TEXT,
    subtipo TEXT,
    control_f01_id INTEGER NOT NULL,
    id_tablet INTEGER
  );
  ''';

  static const _solicitudProductosImportadosSA = '''
    CREATE TABLE IF NOT EXISTS solicitud_productos_importados_sa (
      id integer PRIMARY KEY NOT NULL,
      pfi TEXT,
      estado TEXT,
      dda TEXT,
      razon_social TEXT,
      pais_origen TEXT,
      tipo_certificado TEXT
    );
  ''';

  static const _productosSolictudProductosImportadosSA = '''
    CREATE TABLE IF NOT EXISTS productos_solictud_productos_importados_sa (
      id integer PRIMARY KEY NOT NULL,
      nombre TEXT,
      cantidad_declarada TEXT,
      cantidad_ingresada TEXT,
      unidad TEXT,
      subtipo TEXT,
      control_f01_id INTEGER,
      id_tablet INTEGER
    );
  ''';

  static const _controlF01SA = '''
  CREATE TABLE IF NOT EXISTS control_f01_sa (
    id INTEGER PRIMARY KEY,
    pfi TEXT NOT NULL,
    dda TEXT NOT NULL,
    pregunta01 TEXT NOT NULL,
    pregunta02 TEXT NOT NULL,
    pregunta03 TEXT,
    pregunta04 TEXT,
    pregunta05 TEXT,
    pregunta06 TEXT,
    pregunta07 TEXT,
    pregunta08 TEXT,
    pregunta09 INTEGER NOT NULL,
    pregunta10 INTEGER NOT NULL,
    pregunta11 TEXT NOT NULL,
    categoria_riesgo TEXT NOT NULL,
    seguimiento_cuarentenario TEXT NOT NULL,
    provincia TEXT,
    peso_ingreso TEXT NOT NULL,
    envio_muestra TEXT NOT NULL,
    observaciones TEXT,
    dictamen_final TEXT NOT NULL,
    numero_embalajes_envio INTEGER,
    numero_embalajes_inspeccionados INTEGER,
    usuario TEXT NOT NULL,
    usuario_id TEXT NOT NULL,
    fecha_creacion TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_tablet INTEGER,
    tablet_id TEXT,
    tablet_version TEXT
  );
  ''';

  static const _controlF01LoteSA = '''
  CREATE TABLE IF NOT EXISTS control_f01_lote_sa (
    id INTEGER PRIMARY KEY,
    descripcion TEXT NOT NULL,
    numero_cajas INTEGER NOT NULL,
    cajas_muestra INTEGER NOT NULL,
    porcentaje_inspeccion TEXT NOT NULL,
    ausencia_suelo TEXT NOT NULL,
    ausencia_contaminantes TEXT NOT NULL,
    ausencia_sintomas TEXT NOT NULL,
    ausencia_plagas TEXT NOT NULL,
    dictamen TEXT NOT NULL,
    control_f01_id INTEGER NOT NULL,
    id_tablet INTEGER
  );
  ''';

  static const _controlF01OrdenSA = '''
  CREATE TABLE IF NOT EXISTS control_f01_orden_sa (
    id INTEGER PRIMARY KEY,
    nombre_producto TEXT NOT NULL,
    tipo_cliente TEXT NOT NULL,
    tipo_muestra TEXT NOT NULL,
    conservacion TEXT NOT NULL,
    actividad_origen TEXT NOT NULL,
    peso_muestra TEXT NOT NULL,
    codigo_muestra TEXT NOT NULL,
    prediagnostico TEXT NOT NULL,
    analisis TEXT NOT NULL,
    descripcion_sintomas TEXT NOT NULL,
    fase_fenologica TEXT NOT NULL,
    control_f01_id INTEGER NOT NULL,
    id_tablet INTEGER
  );
  ''';

  static const _controlF01ProductoSA = '''
  CREATE TABLE IF NOT EXISTS control_f01_producto_sa (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    cantidad_declarada TEXT,
    cantidad_ingresada TEXT,
    unidad TEXT,
    subtipo TEXT,
    control_f01_id INTEGER NOT NULL,
    id_tablet INTEGER
  );
  ''';
}
