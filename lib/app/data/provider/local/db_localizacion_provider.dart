import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBLocalizacionProvider {
  DBProvider database = DBProvider.db;

  /**
   * selects
   */

  /// Recibe como parámetro el id del padre y retorna un catálogo de localizaciones List[LocalizacionModelo]
  Future<List<LocalizacionModelo>> getLocalizacionPorPadre(int? idPadre) async {
    final db = await database.dataBase;
    final res = await db!.query('localizacion',
        where: 'id_localizacion_padre=?', whereArgs: [idPadre]);

    List<LocalizacionModelo> list = res.isNotEmpty
        ? res.map((e) => LocalizacionModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  /// Retorna una localización [LocalizacionModelo] por su id(GUIA)
  Future<LocalizacionModelo?> getLocalizacionPorId(id) async {
    final db = await database.dataBase;
    final res = await db!
        .query('localizacion', where: 'id_localizacion=?', whereArgs: [id]);

    return res.isNotEmpty ? LocalizacionModelo.fromJson(res.first) : null;
  }

  /// Retorna una localización [LocalizacionModelo] por su nombre(GUIA)
  Future<LocalizacionModelo?> getLocalizacionPorNombre(String pais) async {
    final db = await database.dataBase;
    final res =
        await db!.query('localizacion', where: 'nombre=?', whereArgs: [pais]);

    return res.isNotEmpty ? LocalizacionModelo.fromJson(res.first) : null;
  }

  /// Retorna todo el catálogo de localización List[LocalizacionModelo] por categoría(GUIA)
  Future<List<LocalizacionModelo>> getLocalizacionPorCategoria(
      int categoria) async {
    final db = await database.dataBase;
    final res = await db!
        .query('localizacion', where: 'categoria=?', whereArgs: [categoria]);

    List<LocalizacionModelo> list = res.isNotEmpty
        ? res.map((e) => LocalizacionModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  /**
   * inserts
   */

  /// Recibe un [LocalizacionCatalogo] y lo guarda en la tabla localizacion
  Future<int> guardarLocalizacionCatalogo(
      LocalizacionCatalogo localizacion) async {
    final db = await database.dataBase;
    final res = await db!.rawInsert(
        "INSERT Into localizacion (id_localizacion, codigo, nombre, id_localizacion_padre, categoria) values (?,?,?,?,?)",
        [
          localizacion.idguia,
          localizacion.codigo,
          localizacion.nombre,
          localizacion.idGuiaPadre,
          localizacion.categoria
        ]);
    return res;
  }
}
