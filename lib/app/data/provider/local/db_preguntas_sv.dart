import 'package:agro_servicios/app/data/models/preguntas_sv/preguntas_modelo.dart';
import 'package:flutter/foundation.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';
export 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';

class DBPreguntasProvider {
  static final DBPreguntasProvider db = DBPreguntasProvider._();

  DBPreguntasProvider._();
  DBProvider dataBase = DBProvider.db;

  ///Obtener de la base local Todos las Inspecciones x estado I Incompleto C Completo
  Future<List<PreguntasModelo>> obtenerPreguntas(idFormulario, tipoArea) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('preguntas_sv',
        where: 'formulario=? and tipo_area=? ',
        whereArgs: ['$idFormulario', '$tipoArea'],
        orderBy: 'orden');

    List<PreguntasModelo> list = res.isNotEmpty
        ? res.map((e) => PreguntasModelo.fromJson(e)).toList()
        : [];
    debugPrint('$list');
    return list;
  }

  ///Obtener de la base local Todos las Inspecciones x estado I Incompleto C Completo
  Future<List<PreguntasModelo>> obtenerPreguntasTab(
      formulario, tipoArea, tab) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('preguntas_sv',
        where: 'formulario=? and tipo_area=? and tab=?',
        whereArgs: ['$formulario', '$tipoArea', '$tab'],
        orderBy: 'orden');

    List<PreguntasModelo> list = res.isNotEmpty
        ? res.map((e) => PreguntasModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  //Eliminar
  Future<int> eliminarTodosPreguntas(idFormulario) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete(
        'DELETE FROM preguntas_sv WHERE formulario = ?', [idFormulario]);

    return res;
  }

  nuevoPreguntas(PreguntasModelo modelo) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('preguntas_sv', modelo.toJson());
    return res;
  }

  //Obtener de la base local Todos los Sitios
  Future<PreguntasModelo?> obtenerPreguntasSvModelo() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'preguntas_sv',
    );
    return res.isNotEmpty ? PreguntasModelo.fromJson(res.first) : null;
  }
}
