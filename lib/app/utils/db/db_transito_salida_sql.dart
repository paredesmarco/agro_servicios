class DBTransitoSalidaSql {
  static List<String> script = [
    _ingresosSincronizados,
    _productosSincronizados,
    _salidas,
  ];

  static const _ingresosSincronizados = '''
    CREATE TABLE IF NOT EXISTS formulario_ingreso_transito(
      id INTEGER PRIMARY KEY,
      id_ingreso INTEGER UNIQUE ON CONFLICT IGNORE,
      nombre_razon_social TEXT,
      ruc_ci TEXT,
      pais_origen TEXT,
      pais_procedencia TEXT,
      pais_destino TEXT,
      punto_ingreso TEXT,
      punto_salida TEXT,
      placa_vehiculo TEXT,
      dda TEXT,
      precintosticker TEXT,
      fecha_ingreso TEXT
    );
  ''';

  static const _productosSincronizados = '''
    CREATE TABLE IF NOT EXISTS formulario_ingreso_transito_producto(
      id INTEGER PRIMARY KEY,
      id_producto INTEGER,
      partida_arancelaria TEXT,
      producto TEXT,
      cantidad TEXT,
      tipo_envase TEXT,
      formulario_ingreso_transito_id_ingreso INTEGER -- foreign key de registros_ingreso_transito
    );
  ''';

  static const _salidas = '''
    CREATE TABLE IF NOT EXISTS control_f02_salida (
      id INTEGER PRIMARY KEY,
      id_ingreso INTEGER NOT NULL, --foreing key de registros_ingreso_transito
      estado_precinto TEXT NOT NULL,
      tipo_verificacion TEXT NOT NULL,
      fecha_salida TEXT NOT NULL,
      usuario_salida TEXT NOT NULL,
      usuario_id_salida TEXT NOT NULL
    );
  ''';
}
