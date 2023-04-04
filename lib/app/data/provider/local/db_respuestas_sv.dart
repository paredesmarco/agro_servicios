import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_areas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';
import 'package:flutter/foundation.dart';

export 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';

class DBRespuestasProvider {
  static final DBRespuestasProvider db = DBRespuestasProvider._();

  DBRespuestasProvider._();
  DBProvider dataBase = DBProvider.db;

  /*
   * Insert Respuestas
   */

  ///Guarda en la Base Local los Datos de Inspecciones esta esta por REVISAR
  nuevoRespuestas(RespuestasModelo modelo) async {
    debugPrint(
        "INSERT INTO formulario_respuestas_sv (id_pregunta,formulario, tipo_area, orden, pregunta,  puntos, tab, tipo, modo_visualizar, fecha, estado, tipo_dato, obligatorio,opciones_respuesta, numero_reporte, respuesta) VALUES ( ${modelo.idPregunta},'${modelo.formulario}', '${modelo.tipoArea}', ${modelo.orden}, '${modelo.pregunta}', ${modelo.puntos}, '${modelo.tab}', '${modelo.tipo}', '${modelo.modoVisualizar}', '${modelo.fecha}', '${modelo.estado}', '${modelo.tipoDato}', '${modelo.obligatorio}','${modelo.opcionesRespuesta}', '${modelo.numeroReporte}', '${modelo.respuesta}')");
    final db = await dataBase.dataBase;
    final res = await db!.rawInsert(
        "INSERT INTO formulario_respuestas_sv (id_pregunta,formulario, tipo_area, orden, pregunta,  puntos, tab, tipo, modo_visualizar, fecha, estado, tipo_dato, obligatorio,opciones_respuesta, numero_reporte, respuesta) VALUES ( ${modelo.idPregunta},'${modelo.formulario}', '${modelo.tipoArea}', ${modelo.orden}, '${modelo.pregunta}', ${modelo.puntos}, '${modelo.tab}', '${modelo.tipo}', '${modelo.modoVisualizar}', '${modelo.fecha}', '${modelo.estado}', '${modelo.tipoDato}', '${modelo.obligatorio}', '${modelo.opcionesRespuesta}','${modelo.numeroReporte}', '${modelo.respuesta}')");

    final res1 = await db.query('formulario_respuestas_sv');

    res1.isNotEmpty
        ? res1.map((e) => RespuestasModelo.fromJson(e)).toList()
        : [];
    return res;
  }

  ///Guarda en la Base Local los Datos de Inspecciones esta esta por REVISAR
  nuevoAreas(RespuestasAreasModelo modelo) async {
    // print(
    //     "INSERT INTO formulario_areas_sv (formulario, numero_reporte, id_area) VALUES ('${modelo.formulario}', '${modelo.numeroReporte}','${modelo.idArea}')");
    final db = await dataBase.dataBase;
    final res = await db!.rawInsert(
        "INSERT INTO formulario_areas_sv (formulario, numero_reporte, id_area) VALUES ('${modelo.formulario}', '${modelo.numeroReporte}','${modelo.idArea}')");
    return res;
  }

  /*
   * UPDATES Actualizar Respuestas
   */

  Future<int> actualizaRespuestas(id, respuesta) async {
    // print(
    //     "UPDATE formulario_respuestas_sv SET respuesta ='$respuesta' WHERE id = $id");

    final db = await dataBase.dataBase;
    final res = await db!.rawUpdate(
        'UPDATE formulario_respuestas_sv SET respuesta =?  WHERE id = ?',
        ['$respuesta', id]);

    return res;
  }

//ojo
  Future<int> actualizaAreas(id, respuesta) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawUpdate(
        'UPDATE formulario_areas_sv SET id_area = ? WHERE id = ?',
        [respuesta, id]);

    return res;
  }

  /*
   * SElECT Seleccionar Listas
   */

  ///Obtener de la base local todos las respuestas ingresadas.
  Future<List<RespuestasModelo>> obtenerRespuestas(
      idFormulario, numeroReporte) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('formulario_respuestas_sv',
        where: 'formulario=?  and numero_reporte=? ',
        whereArgs: [idFormulario, '$numeroReporte'],
        orderBy: 'orden');

    List<RespuestasModelo> list = res.isNotEmpty
        ? res.map((e) => RespuestasModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  ///Obtener de la base local todos las respuestas ingresadas.
  Future<int> obtenerRespuestasPositivas(idFormulario, numeroReporte) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('formulario_respuestas_sv',
        where: 'respuesta=? and formulario=?  and numero_reporte=? ',
        whereArgs: ['Si', idFormulario, '$numeroReporte'],
        orderBy: 'orden');
    List<RespuestasModelo> list = res.isNotEmpty
        ? res.map((e) => RespuestasModelo.fromJson(e)).toList()
        : [];
    return list.length;
  }

  ///Obtener de la base local todos las respuestas ingresadas.
  Future<List<RespuestasAreasModelo>> obtenerAreas(
      idFormulario, numeroReporte) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('formulario_areas_sv',
        where: 'formulario=?  and numero_reporte=? ',
        whereArgs: [idFormulario, '$numeroReporte']);

    List<RespuestasAreasModelo> list = res.isNotEmpty
        ? res.map((e) => RespuestasAreasModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  /*
   * DElETE Actualizar Respuestas
   */
//Eliminar de la base local todas las Inspecciones
  Future<int> eliminarRespuestas(idFormulario, numeroReporte) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete(
        'DELETE FROM formulario_respuestas_sv WHERE formulario = ? AND numero_reporte=?',
        [idFormulario, '$numeroReporte']);
    return res;
  }

//Eliminar de la base local todas las Inspecciones
  Future<int> eliminarTodasRespuestas(formulario) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete(
        'DELETE FROM formulario_respuestas_sv WHERE formulario=?',
        [formulario]);
    return res;
  }

  //Eliminar de la base local todas las Inspecciones
  Future<int> eliminarTodasIdAreas(formulario) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete(
        'DELETE FROM formulario_areas_sv WHERE formulario=?', [formulario]);
    return res;
  }

  //Eliminar de la base local todas las Inspecciones
  Future<int> eliminarAreas(formulario, numeroReporte) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete(
        'DELETE FROM formulario_areas_sv WHERE formulario  = ? and numero_reporte   = ?',
        [formulario, '$numeroReporte']);
    return res;
  }
}
