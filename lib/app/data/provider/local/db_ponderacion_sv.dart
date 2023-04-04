import 'package:agro_servicios/app/data/models/preguntas_sv/ponderacion_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';
export 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';

class DBPonderacionProvider {
  static final DBPonderacionProvider db = DBPonderacionProvider._();

  DBPonderacionProvider._();
  DBProvider dataBase = DBProvider.db;

  ///Obtener de la base local Todos las Inspecciones x estado I Incompleto C Completo
  Future<List<PonderacionModelo>> obtenerPonderacion(
      formulario, tipoArea) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('ponderacion_sv',
        where: 'formulario=? and tipo_area=?',
        whereArgs: ['$formulario', '$tipoArea']);

    List<PonderacionModelo> list = res.isNotEmpty
        ? res.map((e) => PonderacionModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  //Eliminar
  Future<int> eliminarTodosPonderacion(codigoAplicacion) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete(
        'DELETE FROM ponderacion_sv WHERE formulario = ?',
        ['$codigoAplicacion']);
    return res;
  }

  nuevoPonderacion(PonderacionModelo modelo) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('ponderacion_sv', modelo.toJson());
    return res;
  }

  //Obtener de la base local Todos los Sitios
  Future<PonderacionModelo?> obtenerPonderacionSvModelo() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'ponderacion_sv',
    );
    return res.isNotEmpty ? PonderacionModelo.fromJson(res.first) : null;
  }
}
