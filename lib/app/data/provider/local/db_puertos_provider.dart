import 'package:agro_servicios/app/data/models/catalogos/puertos_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBPuertosProvider {
  var database = DBProvider.db;

  //Inserts

  ///Guardar catalogo de puertos
  Future guardarPuertos(PuertosCatalogoModelo puertos) async {
    final db = await database.dataBase;

    final res = await db!.rawInsert(
        "INSERT Into puertos_catalogos (id_puerto,nombre) values (?,?)", [
      puertos.idPuerto,
      puertos.nombre,
    ]);
    return res;
  }

  //Deletes

  ///
  ///Eliminar todos los registros del catálogo de puertos
  ///
  Future eliminarPuertos() async {
    final db = await database.dataBase;

    final res = await db!.delete('puertos_catalogos');
    return res;
  }

  // Selects

  ///
  ///Obtener el catálogo de puertos
  ///
  Future<List<PuertosCatalogoModelo>> getCatalogoPuertos() async {
    final db = await database.dataBase;

    final res = await db!.query('puertos_catalogos');

    List<PuertosCatalogoModelo> lista = res.isNotEmpty
        ? res.map((e) => PuertosCatalogoModelo.fromJson(e)).toList()
        : [];
    return lista;
  }

  ///
  ///Obtener el puertos por el nombre
  ///
  Future<PuertosCatalogoModelo?> getPuertoPorNombre(String nombre) async {
    final db = await database.dataBase;

    final res = await db!
        .query('puertos_catalogos', where: 'nombre=?', whereArgs: [nombre]);

    return res.isNotEmpty ? PuertosCatalogoModelo.fromJson(res.first) : null;
  }

  ///
  ///Obtener el puertos por el id del puerto
  ///
  Future<PuertosCatalogoModelo?> getPuertoPorId(int idPuerto) async {
    final db = await database.dataBase;

    final res = await db!.query('puertos_catalogos',
        where: 'id_puerto=?', whereArgs: [idPuerto]);

    return res.isNotEmpty ? PuertosCatalogoModelo.fromJson(res.first) : null;
  }
}
