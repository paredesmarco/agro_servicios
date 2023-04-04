class DBTransitoIngresoSql {
  static List<String> script = [
    _controlF02Ingreso,
    _controlF02Producto,
  ];

  static const _controlF02Ingreso = '''
    CREATE TABLE IF NOT EXISTS control_f02_ingreso(
      id INTEGER PRIMARY KEY,
      nombre_razon_social TEXT NOT NULL,
      ruc_ci TEXT NOT NULL,
      id_pais_origen TEXT NOT NULL,
      pais_origen TEXT NOT NULL,
      id_pais_procedencia TEXT NOT NULL,
      pais_procedencia TEXT NOT NULL,
      id_pais_destino TEXT NOT NULL,
      pais_destino TEXT NOT NULL,
      id_punto_ingreso TEXT NOT NULL,
      punto_ingreso TEXT NOT NULL,
      id_punto_salida TEXT NOT NULL,
      punto_salida TEXT NOT NULL,
      placa_vehiculo TEXT NOT NULL,
      dda TEXT NOT NULL,
      precinto_sticker TEXT NOT NULL,
      usuario_ingreso TEXT NOT NULL,
      usuario_id_ingreso TEXT NOT NULL,
      fecha_ingreso TEXT NOT NULL,
      id_tablet INTEGER NOT NULL,
      tablet_version_base_ingreso TEXT NOT NULL
      );
  ''';

  static const _controlF02Producto = '''
    CREATE TABLE IF NOT EXISTS control_f02_producto(
      id INTEGER PRIMARY KEY,
      partida_arancelaria TEXT NOT NULL,
      descripcion_producto TEXT NOT NULL,
      subtipo TEXT NOT NULL,
      cantidad REAL NOT NULL,
      tipo_envase TEXT NOT NULL,
      control_f02_id INTEGER NOT NULL, -- foreign key de registros_ingreso_transito
      id_tablet INTEGER NOT NULL
    );
  ''';
}
