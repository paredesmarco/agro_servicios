// import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'dart:io';

import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';

class DBLocalizcion {
  static final DBLocalizcion db = DBLocalizcion._constructorPrivado();

  DBLocalizcion._constructorPrivado();

  var database = DBProvider.db;

  Future<List<LocalizacionModelo>> getTodosProvincias(int categoria) async {
    final db = await database.dataBase;
    final res = await db!
        .query('localizacion', where: 'categoria=?', whereArgs: [categoria]);

    List<LocalizacionModelo> list = res.isNotEmpty
        ? res.map((e) => LocalizacionModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  /// Recibe como parámetro el id del padre y retorna una lista de LocalizacionModelo
  Future<List<LocalizacionModelo>> getLocalizacionPorPadre(int? idPadre) async {
    final db = await database.dataBase;
    final res = await db!.query('localizacion',
        where: 'id_localizacion_padre=?', whereArgs: [idPadre]);

    List<LocalizacionModelo> list = res.isNotEmpty
        ? res.map((e) => LocalizacionModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<LocalizacionModelo?> getLocalizacionPorId(id) async {
    final db = await database.dataBase;
    final res = await db!
        .query('localizacion', where: 'id_localizacion=?', whereArgs: [id]);

    return res.isNotEmpty ? LocalizacionModelo.fromJson(res.first) : null;
  }

//Inserts
  guardarLocalizacionSincronizadas(LocalizacionModelo localizacion) async {
    final db = await database.dataBase;
    final res = await db!.insert('localizacion', localizacion.toJson());
    return res;
  }

  guardarLocalizacionSincronizadasRaw(LocalizacionModelo localizacion) async {
    final db = await database.dataBase;
    final res = await db!.rawInsert(
        "INSERT Into localizacion (id_localizacion, codigo, nombre, id_localizacion_padre, categoria) "
        "VALUES (${localizacion.idGuia},'${localizacion.codigo}','${localizacion.nombre}',${localizacion.idGuiaPadre},${localizacion.categoria})");
    return res;
  }

  guardarLocalizacionCatalogo(LocalizacionCatalogo localizacion) async {
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
