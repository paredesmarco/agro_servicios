import 'package:agro_servicios/app/data/models/transito_ingreso_control_sv/transito_ingreso_producto_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_ingreso_control_sv/transito_ingreso_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_salida_control_sv/registros_transito_ingreso_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBTransitoIngresoControlSvProvider {
  final database = DBProvider.db;

  // Inserts

  Future guardarVerificacionIngreso(TransitoIngresoSvModelo registros) async {
    final db = await database.dataBase;

    final res = await db!.insert('control_f02_ingreso', registros.toJson());

    return res;
  }

  Future guardarVerificacionIngresoProducto(
      TransitoIngresoProductoSvModelo registros) async {
    final db = await database.dataBase;

    final res = await db!.insert('control_f02_producto', registros.toJson());

    return res;
  }

  // Selects

  Future<int> getSecuenciaTransitoIngreso() async {
    final db = await database.dataBase;

    final res = await db!
        .rawQuery("select max(id) + 1 as id_tablet from control_f02_ingreso");

    int id = res[0]['id_tablet'] == null
        ? 1
        : int.parse(res[0]['id_tablet'].toString());

    return id;
  }

  Future<int> getSecuenciaTransitoIngresoProducto() async {
    final db = await database.dataBase;

    final res = await db!
        .rawQuery("select max(id) + 1 as id_tablet from control_f02_producto");

    int id = res[0]['id_tablet'] == null
        ? 1
        : int.parse(res[0]['id_tablet'].toString());

    return id;
  }

  Future<List<RegistrosTransitoIngresoModelo>> getRegistrosIngreso() async {
    final db = await database.dataBase;

    final res = await db!.query('control_f02_ingreso');

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

  Future getCantidadVerificacionIngreso() async {
    final db = await database.dataBase;
    final res = await db!
        .rawQuery("SELECT count(id) cantidad FROM control_f02_ingreso");
    return res.toList();
  }

  Future<List<TransitoIngresoSvModelo>>
      getRegistrosVerificacionIngreso() async {
    final db = await database.dataBase;
    final res = await db!.query("control_f02_ingreso");

    List<TransitoIngresoSvModelo> lista = res.isNotEmpty
        ? res.map((e) => TransitoIngresoSvModelo.fromJson(e)).toList()
        : [];

    return lista;
  }

  Future<List<TransitoIngresoProductoSvModelo>>
      getRegistrosVerificacionIngresoProductos() async {
    final db = await database.dataBase;
    final res = await db!.query("control_f02_producto");

    List<TransitoIngresoProductoSvModelo> lista = res.isNotEmpty
        ? res.map((e) => TransitoIngresoProductoSvModelo.fromJson(e)).toList()
        : [];

    return lista;
  }

  // Deletes

  Future eliminarRegistrosVerificacionIngreso() async {
    final db = await database.dataBase;

    final res = await db!.delete('control_f02_ingreso');

    return res;
  }

  Future eliminarRegistrosVerificacionProductos() async {
    final db = await database.dataBase;

    final res = await db!.delete('control_f02_producto');

    return res;
  }
}
