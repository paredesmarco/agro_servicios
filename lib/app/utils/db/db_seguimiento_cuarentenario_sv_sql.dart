class DBSeguimientoCuarentenarioSvSql {
  static List<String> script = [
    _controlF04Solicitudes,
    _controlF04Producto,
    _controlF04AreasCuarentena,
    _controlF04,
    _controF04Laboratorio,
  ];

  static const _controlF04Solicitudes = '''
    CREATE TABLE IF NOT EXISTS solicitud_control_f04 (
      id INTEGER PRIMARY KEY,
      id_seguimiento_cuarentenario INTEGER NOT NULL,
      identificador_operador TEXT NOT NULL,
      razon_social TEXT NOT NULL,
      numero_seguimientos_planificados INTEGER NOT NULL,
      numero_plantas_ingreso INTEGER NOT NULL,
      id_pais_origen INTEGER NOT NULL,
      pais_origen TEXT NOT NULL,
      id_vue TEXT,
      utilizada INTEGER NOT NULL
    );    
  ''';

  static const _controlF04Producto = '''
    CREATE TABLE IF NOT EXISTS solicitud_control_f04_producto (
      id INTEGER PRIMARY KEY,
      id_producto INTEGER,
      producto TEXT,
      subtipo TEXT,
      peso TEXT,
      unidad TEXT,
      id_solicitud INTEGER NOT NULL 
    );
  ''';

  static const _controlF04AreasCuarentena = '''
    CREATE TABLE IF NOT EXISTS solicitud_control_f04_areas_cuarentena (
      id INTEGER PRIMARY KEY,
      id_guia INTEGER NOT NULL UNIQUE ON CONFLICT IGNORE,
      nombre_area TEXT,
      tipo_area TEXT,
      identificador_operador TEXT,
      nombre_lugar TEXT,
      codigo_area TEXT
    );
  ''';

  static const _controlF04 = '''
    CREATE TABLE IF NOT EXISTS control_f04 (
      id INTEGER PRIMARY KEY,
      id_seguimiento_cuarentenario INTEGER,
      ruc_operador TEXT,
      razon_social TEXT,
      codigo_pais_origen INTEGER,
      pais_origen TEXT,
      producto TEXT,
      subtipo TEXT,
      peso TEXT,
      numero_plantas_ingreso INTEGER,
      codigo_provincia INTEGER,
      provincia TEXT,
      codigo_canton INTEGER,
      canton TEXT,
      codigo_parroquia INTEGER,
      parroquia TEXT,
      nombre_scpe TEXT,
      tipo_operacion TEXT,
      tipo_cuarentena_condicion_produccion TEXT,
      fase_seguimiento TEXT,
      codigo_lote TEXT,
      numero_seguimientos_planificados INTEGER,
      cantidad_total REAL,
      cantidad_vigilada REAL,
      actividad TEXT,
      etapa_cultivo TEXT,
      registro_monitoreo_plagas TEXT,
      ausencia_plagas TEXT,
      cantidad_afectada REAL,
      porcentaje_incidencia REAL,
      porcentaje_severidad REAL,
      fase_desarrollo_plaga TEXT,
      organo_afectado TEXT,
      distribucion_plaga TEXT,
      poblacion REAL,
      descripcion_sintomas TEXT,
      envio_muestra TEXT,
      resultado_inspeccion TEXT,
      numero_plantas_inspeccion TEXT,
      observaciones TEXT,
      usuario TEXT NOT NULL,
      usuario_id TEXT NOT NULL,
      fecha_creacion INTEGER NOT NULL,
      id_tablet INTEGER,
      tablet_id TEXT,
      tablet_version_base TEXT
      );
  ''';

  static const _controF04Laboratorio = ''' 
  CREATE TABLE IF NOT EXISTS control_f04_orden (
    id INTEGER PRIMARY KEY,
    id_padre INTEGER NOT NULL,
    id_tablet INTEGER,
    actividad_origen TEXT,
    analisis TEXT,
    aplicacion_producto_quimico TEXT,
    codigo_muestra TEXT,
    conservacion TEXT,
    tipo_muestra TEXT,
    descripcion_sintomas TEXT,
    fase_fenologica TEXT,
    nombre_producto TEXT,
    prediagnostico TEXT
    );
  ''';
}
