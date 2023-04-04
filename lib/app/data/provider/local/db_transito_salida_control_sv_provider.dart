import 'package:agro_servicios/app/data/models/transito_salida_control_sv/registros_transito_ingreso_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_salida_control_sv/verificacion_transito_salida_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBTransitoSalidaControlSvProvider {
  final database = DBProvider.db;

  // Inserts

  Future guardarRegistrosIngreso(
      RegistrosTransitoIngresoModelo registros) async {
    final db = await database.dataBase;

    final res = await db!.rawInsert(''' 
    INSERT INTO formulario_ingreso_transito 
        (id_ingreso,nombre_razon_social,ruc_ci,pais_origen,pais_procedencia,pais_destino,
        punto_ingreso,punto_salida,placa_vehiculo,dda,precintosticker,fecha_ingreso) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?); 
    ''', [
      registros.idIngreso,
      registros.nombreRazonSocial,
      registros.rucCi,
      registros.paisOrigen,
      registros.paisProcedencia,
      registros.paisDestino,
      registros.puntoIngreso,
      registros.puntoSalida,
      registros.placaVehiculo,
      registros.dda,
      registros.precintosticker,
      registros.fechaIngreso.toString(),
    ]);

    return res;
  }

  Future guardarRegistrosIngresoProducto(
      IngresoTransitoProducto registros) async {
    final db = await database.dataBase;

    final res = await db!
        .insert('formulario_ingreso_transito_producto', registros.toJson());

    return res;
  }

  Future guardarVerificacionSalida(
      VerificacionTransitoSalidaModelo registros) async {
    final db = await database.dataBase;

    var values = {
      'id_ingreso': registros.idIngreso,
      'estado_precinto': registros.estadoPrecinto,
      'tipo_verificacion': registros.tipoVerificacion,
      'fecha_salida': registros.fechaSalida,
      'usuario_salida': registros.usuarioSalida,
      'usuario_id_salida': registros.usuarioIdSalida,
    };

    final res = await db!.insert('control_f02_salida', values);

    return res;
  }

  // Selects

  Future<List<RegistrosTransitoIngresoModelo>> getRegistrosIngreso() async {
    final db = await database.dataBase;

    final res = await db!
        .query('formulario_ingreso_transito', orderBy: 'nombre_razon_social');

    List<RegistrosTransitoIngresoModelo> lista = res.isNotEmpty
        ? res.map((e) => RegistrosTransitoIngresoModelo.fromJson(e)).toList()
        : [];

    return lista;
  }

  Future<IngresoTransitoProducto?> getRegistrosIngresoProducto(
      int idPadre) async {
    final db = await database.dataBase;

    final res = await db!.query(
      'formulario_ingreso_transito_producto',
      where: 'formulario_ingreso_transito_id_ingreso =?',
      whereArgs: [idPadre],
    );

    return res.isNotEmpty ? IngresoTransitoProducto.fromJson(res.first) : null;
  }

  Future<VerificacionTransitoSalidaModelo?> getVerificaionSalidaLLenada(
      int idIngreso) async {
    final db = await database.dataBase;

    final res = await db!.query(
      'control_f02_salida',
      where: 'id_ingreso =?',
      whereArgs: [idIngreso],
    );

    return res.isNotEmpty
        ? VerificacionTransitoSalidaModelo.fromJson(res.first)
        : null;
  }

  Future getCantidadVerificacionSalida() async {
    final db = await database.dataBase;
    final res =
        await db!.rawQuery("SELECT count(id) cantidad FROM control_f02_salida");
    return res.toList();
  }

  Future<List<VerificacionTransitoSalidaModelo>>
      getRegistrosVerificacionSalida() async {
    final db = await database.dataBase;
    final res = await db!.query("control_f02_salida");

    List<VerificacionTransitoSalidaModelo> lista = res.isNotEmpty
        ? res.map((e) => VerificacionTransitoSalidaModelo.fromJson(e)).toList()
        : [];

    return lista;
  }

  // Deletes

  Future eliminarRegistrosIngreso() async {
    final db = await database.dataBase;

    final res = await db!.delete('formulario_ingreso_transito');

    return res;
  }

  Future eliminarRegistrosIngresoProducto() async {
    final db = await database.dataBase;

    final res = await db!.delete('formulario_ingreso_transito_producto');

    return res;
  }

  Future eliminarRegistrosVerificacionSalida() async {
    final db = await database.dataBase;

    final res = await db!.delete('control_f02_salida');

    return res;
  }
}
