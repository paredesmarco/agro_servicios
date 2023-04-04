class DBEmbalajeControlSql {
  static List<String> script = [
    _controlf03,
    _controlf03OrdenLaboratorio,
  ];

  static const _controlf03 = '''    
    CREATE TABLE IF NOT EXISTS control_f03 (
    id INTEGER PRIMARY KEY,
    id_punto_control TEXT NOT NULL,
    punto_control TEXT NOT NULL,
    area_inspeccion TEXT NOT NULL,
    identidad_embalaje TEXT NOT NULL,
    id_pais_origen TEXT NOT NULL,
    pais_origen TEXT NOT NULL,
    numero_embalajes INTEGER NOT NULL,
    numero_unidades INTEGER NOT NULL,
    marca_autorizada TEXT NOT NULL,
    marca_autorizada_descripcion TEXT,
    marca_legible TEXT NOT NULL,
    marca_legible_descripcion TEXT,
    ausencia_dano_insectos TEXT NOT NULL,
    ausencia_dano_insectos_descripcion TEXT,
    ausencia_insectos_vivos TEXT NOT NULL,
    ausencia_insectos_vivos_descripcion TEXT,
    ausencia_corteza TEXT NOT NULL,
    ausencia_corteza_descripcion TEXT,
    razon_social TEXT,
    manifesto TEXT,
    producto TEXT,
    envio_muestra TEXT NOT NULL,
    observaciones TEXT,
    dictamen_final TEXT NOT NULL,
    usuario TEXT NOT NULL,
    usuario_id TEXT NOT NULL,
    fecha_creacion TEXT NOT NULL,
    id_tablet INTEGER,
    tablet_id TEXT,
    tablet_version_base TEXT
    );
  ''';

  static const _controlf03OrdenLaboratorio = '''
    CREATE TABLE IF NOT EXISTS control_f03_orden (
    id INTEGER PRIMARY KEY,
    nombre_producto TEXT NOT NULL,
    tipo_cliente TEXT NOT NULL,
    tipo_muestra TEXT NOT NULL,
    conservacion TEXT NOT NULL,
    actividad_origen TEXT NOT NULL,
    peso_muestra TEXT NOT NULL,
    codigo_muestra TEXT NOT NULL,
    prediagnostico TEXT NOT NULL,
    analisis TEXT,
    descripcion_sintomas TEXT NOT NULL,
    fase_fenologica TEXT NOT NULL,
    control_f03_id INTEGER NOT NULL,
    id_tablet INTEGER
    );
  ''';
}
