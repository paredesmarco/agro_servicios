import 'package:agro_servicios/app/data/models/catalogos/puertos_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBLugarInspeccionProvider {
  var database = DBProvider.db;

  //Inserts

  ///Guardar catalogo de puertos
  Future guardarLugarInspeccion(LugarInspeccion lugar) async {
    final db = await database.dataBase;

    final res = await db!.rawInsert(
        "INSERT Into lugar_inspeccion (nombre,id_puerto) values (?,?)",
        [lugar.nombre, lugar.idPuerto]);
    return res;
  }

  //Deletes

  ///
  ///Eliminar todos los registros del catálogo de puertos
  ///
  Future eliminarLugarInspeccion() async {
    final db = await database.dataBase;

    final res = await db!.delete('lugar_inspeccion');
    return res;
  }

  // Selects

  ///
  ///Obtener el catálogo de puertos
  ///
  Future<List<LugarInspeccion>> getLugarInspeccionPorId(int idPuerto) async {
    final db = await database.dataBase;

    final res = await db!
        .query('lugar_inspeccion', where: 'id_puerto=?', whereArgs: [idPuerto]);

    // final res = await db!.query('lugar_inspeccion');

    List<LugarInspeccion> lista = res.isNotEmpty
        ? res.map((e) => LugarInspeccion.fromJson(e)).toList()
        : [];
    return lista;
  }
}
