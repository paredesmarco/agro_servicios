import 'package:agro_servicios/app/data/models/minador_sv/minador_modelo.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_productor_modelo.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_sitio_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';
import 'package:sqflite/sqflite.dart';
export 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';

class DBMinadorProvider {
  static final DBMinadorProvider db = DBMinadorProvider._();

  DBMinadorProvider._();
  DBProvider dataBase = DBProvider.db;

  /*
   * INSERTS CREAR Registros
   */

  ///Guarda en la Base Local los Datos
  // creaTablasMinadorCatalogo() async {
  //   final db = await dataBase.dataBase;
  //   // DBMinadorSql.scriptDrop,
  //   List<List<String>> scripts = [
  //     // DBPreguntasSvSql.scriptDrop,
  //     // DBPreguntasSvSql.script,
  //     // DBMinadorSql.scriptCatalogos,

  //     // DBMinadorSql.scriptDelete,
  //   ];

  //   scripts.forEach((e) async {
  //     e.forEach((script) async => await db?.execute(script));
  //   });
  // }

  ///Guarda en la Base Local los Datos
  nuevoSitio(MinadorSitioModelo modelo) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('minador_sitios', modelo.toJson());
    return res;
  }

  ///Guarda en la Base Local los Datos
  nuevoProducto(MinadorProductorModelo modelo) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('minador_productores', modelo.toJson());
    return res;
  }

  ///Guarda en la Base Local los Datos de Inspecciones esta esta por REVISAR
  nuevoInspeccion(MinadorModelo modelo) async {
    // print(
    // "INSERT INTO minador_certificacionf08 (id,id_tablet, numero_reporte, ruc, razon_social, provincia, canton, parroquia, id_sitio_produccion, sitio_produccion,representante, resultado, observaciones, fecha_inspeccion, usuario_id, usuario, tablet_id, tablet_version_base, fecha_ingreso_guia, estado_f08, observacion_f08,  tipo_area, total_resultado,total_areas,id_ponderacion) VALUES ('${modelo.id}','${modelo.idTablet}', '${modelo.numeroReporte}', '${modelo.ruc}', '${modelo.razonSocial}', '${modelo.provincia}','${modelo.canton}', '${modelo.parroquia}', '${modelo.idSitioProduccion}', '${modelo.sitioProduccion}', '${modelo.representante}', '${modelo.resultado}', '${modelo.observaciones}', '${modelo.fechaInspeccion}','${modelo.usuarioId}', '${modelo.usuario}', '${modelo.tabletId}', '${modelo.tabletVersionBase}', '${modelo.fechaIngresoGuia}','${modelo.estadoF08}', '${modelo.observacionF08}', '${modelo.tipoArea}', '${modelo.totalResultado}', '${modelo.totalAreas}', '${modelo.idPonderacion}')");
    final db = await dataBase.dataBase;
    final res = await db!.rawInsert(
        "INSERT INTO minador_certificacionf08 (id,id_tablet, numero_reporte, ruc, razon_social, provincia, canton, parroquia, id_sitio_produccion, sitio_produccion,representante, resultado, observaciones, fecha_inspeccion, usuario_id, usuario, tablet_id, tablet_version_base, fecha_ingreso_guia, estado_f08, observacion_f08,  tipo_area, total_resultado,total_areas,id_ponderacion) VALUES ('${modelo.id}','${modelo.idTablet}', '${modelo.numeroReporte}', '${modelo.ruc}', '${modelo.razonSocial}', '${modelo.provincia}','${modelo.canton}', '${modelo.parroquia}', '${modelo.idSitioProduccion}', '${modelo.sitioProduccion}', '${modelo.representante}', '${modelo.resultado}', '${modelo.observaciones}', '${modelo.fechaInspeccion}','${modelo.usuarioId}', '${modelo.usuario}', '${modelo.tabletId}', '${modelo.tabletVersionBase}', '${modelo.fechaIngresoGuia}','${modelo.estadoF08}', '${modelo.observacionF08}', '${modelo.tipoArea}', '${modelo.totalResultado}', '${modelo.totalAreas}', '${modelo.idPonderacion}')");
    return res;
  }

  ///Guarda en la Base Local los Datos de Inspecciones esta esta por REVISAR
  Future<int> codigoInspeccion() async {
    int codigo = 0;
    final db = await dataBase.dataBase;
    var resM = Sqflite.firstIntValue(await db!
        .rawQuery("SELECT max(id) AS codigo FROM minador_certificacionf08"));
    if (resM == null) {
      codigo = 1;
    } else {
      codigo = int.parse(resM.toString()) + 1;
    }

    // print(codigo);
    return codigo;
  }

  /// Retorna Todo el Catálogo de Operadores o Productores
  /// Devuelve: List<MinadorProductorModelo>
  Future<List<MinadorProductorModelo>>
      obtenerListaMinadorProductorModelo() async {
    final db = await dataBase.dataBase;
    final res = await db!.query('minador_productores');
    List<MinadorProductorModelo> list = res.isNotEmpty
        ? res.map((e) => MinadorProductorModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  ///Obtiene los sitios de un Operador
  Future<List<String>> obtenerSitioLista(idProductor) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('minador_sitios',
        distinct: true,
        columns: ['id_sitio,sitio'],
        where: 'identificador_operador=?',
        whereArgs: ['$idProductor']);

    List<String> sitiosLista;
    sitiosLista = [];
    for (int i = 0; i < res.length; i++) {
      String cadena1 = res[i]["id_sitio"].toString();
      String cadena2 = res[i]["sitio"].toString();
      String cadena3 = '$cadena1 - $cadena2';
      sitiosLista.add(cadena3);
    }
    return sitiosLista;
  }

  ///Obtiene las areas de un sitio
  Future<List<MinadorSitioModelo>> obteneAreaPorOpeSitTip(
      idProductor, idSitio, tipoArea) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('minador_sitios',
        distinct: true,
        columns: ['id_area', 'area'],
        where: 'identificador_operador=? and id_sitio=? and tipo_area=?',
        whereArgs: ['$idProductor', '$idSitio', '$tipoArea']);

    List<MinadorSitioModelo> list = res.isNotEmpty
        ? res.map((e) => MinadorSitioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  ///Obtiene las areas de un sitio
  Future<List<MinadorSitioModelo>> obteneTipoAreaPorOpeSit(
      idProductor, idSitio) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('minador_sitios',
        distinct: true,
        columns: ['tipo_area'],
        where: 'identificador_operador=? and id_sitio=?',
        whereArgs: ['$idProductor', '$idSitio']);

    List<MinadorSitioModelo> list = res.isNotEmpty
        ? res.map((e) => MinadorSitioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  ///Obtiene el sitio por id
  Future<MinadorSitioModelo?> obtenerSitioPorId(int idSitio) async {
    final db = await dataBase.dataBase;
    final res = await db!
        .query('minador_sitios', where: 'id_sitio=?', whereArgs: [idSitio]);

    return res.isEmpty ? null : MinadorSitioModelo.fromJson(res.first);
  }

  /// Retorna todo un registro con los datos de ubicacion de la tabla minador_sitios, filtrada,
  /// por indentificador,sitio,area
  /// Recibe:identificador del operador,sitio,area
  /// Devuleve List<MinadorSitioModelo>
  Future<List<MinadorSitioModelo>> obtenerUbicacion(
      identificador, idSitio, idArea) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('minador_sitios',
        where: 'identificador_operador=? and id_sitio=? and id_area=?',
        whereArgs: ['$identificador', '$idSitio', '$idArea']);

    List<MinadorSitioModelo> list = res.isNotEmpty
        ? res.map((e) => MinadorSitioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<MinadorSitioModelo>> obtenerUbicacionMultiple(
      identificador, idSitio, idArea) async {
    final db = await dataBase.dataBase;
    final res = await db!
        .rawQuery('SELECT *FROM minador_sitios WHERE identificador_operador='
            "'"
            '$identificador'
            "'"
            ' and id_sitio=$idSitio and id_area IN  ($idArea)');

    List<MinadorSitioModelo> list = res.isNotEmpty
        ? res.map((e) => MinadorSitioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<MinadorSitioModelo?> obtenerUbicacionModelo(
      identificador, idSitio, idArea) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('minador_sitios',
        where: 'identificador_operador=? and id_sitio=? and id_area=?',
        whereArgs: ['$identificador', '$idSitio', '$idArea']);

    return res.isNotEmpty ? MinadorSitioModelo.fromJson(res.first) : null;
  }

  Future<List<MinadorSitioModelo>> obtenerSitiosPorUsuario(
      identificador) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('minador_sitios',
        distinct: true,
        columns: ['id_sitio,sitio'],
        where: 'identificador_operador=?',
        whereArgs: ['$identificador']);

    List<MinadorSitioModelo> list = res.isNotEmpty
        ? res.map((e) => MinadorSitioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  //Obtener de la base local Todos los Sitios
  Future<MinadorSitioModelo?> obtenerTodosSitio() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'minador_sitios',
    );
    return res.isNotEmpty ? MinadorSitioModelo.fromJson(res.first) : null;
  }

  //Obtener de la base local Todos los Productos
  Future<MinadorProductorModelo?> obtenerTodosProductor() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'minador_productores',
    );
    return res.isNotEmpty ? MinadorProductorModelo.fromJson(res.first) : null;
  }

  ///Obtiene una lista de todas las inspecciones completas
  Future<MinadorModelo?> obtenerMinadorModelo() async {
    final db = await dataBase.dataBase;
    final res = await db!.query('minador_certificacionf08',
        where: 'estado_f08=?', whereArgs: ['activo']);
    return res.isNotEmpty ? MinadorModelo.fromJson(res.first) : null;
  }

  ///Obtiene una lista de todas las inspecciones completas
  Future<List<MinadorModelo>> obtenerMinadorListaCompleto() async {
    final db = await dataBase.dataBase;
    final res = await db!.query('minador_certificacionf08',
        where: 'estado_f08=?', whereArgs: ['activo']);

    List<MinadorModelo> list = res.isNotEmpty
        ? res.map((e) => MinadorModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  ///Obtener de la base local Todos las Inspecciones
  Future<List<MinadorModelo>> obtenerTodosInspeccionesLista(usuarioId) async {
    final db = await dataBase.dataBase;

    final res = await db!.query('minador_certificacionf08',
        where: 'usuario_id=?',
        whereArgs: ['$usuarioId'],
        orderBy: 'estado_f08,id DESC');

    List<MinadorModelo> list = res.isNotEmpty
        ? res.map((e) => MinadorModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  ///Obtener de la base local Todos las Inspecciones x estado I Incompleto C Completo
  Future<MinadorModelo> obtenerInspeccionEstado(estado, usuarioId) async {
    MinadorModelo modelo = MinadorModelo();
    final db = await dataBase.dataBase;

    final res = await db!.query('minador_certificacionf08',
        where: 'estado_f08=? and usuario_id=?',
        whereArgs: ['$estado', '$usuarioId']);
    if (res.isNotEmpty) {
      return MinadorModelo.fromJson(res.first);
    } else {
      return modelo;
    }
  }

  /*
   * UPDATES Actualizar Registros
   */

  ///Revisar las actualizaciones
  ///
  Future<int> actualizaMinador(MinadorModelo nuevaInspeccion) async {
    final db = await dataBase.dataBase;
    final res = await db!.update(
        'minador_certificacionf08', nuevaInspeccion.toJson(),
        where: "id = ?", whereArgs: ['${nuevaInspeccion.id}']);

    return res;
  }

  Future<int> actualizaCampoMinador(id, campo, valor) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawUpdate(
        'UPDATE minador_certificacionf08 SET $campo = ? WHERE id = ?',
        ['$valor', id]);
    // print('Actualizar $campo=$valor');
    return res;
  }

  //Revisar si seria mejor solo enviar el estado Incompleto, Completo
  Future<int> actualizarMinadorEstado(MinadorModelo nuevaInspeccion) async {
    final db = await dataBase.dataBase;
    Map<String, Object> estado = {'estado_f08': '${nuevaInspeccion.estadoF08}'};
    final res = await db!.update('minador_certificacionf08', estado,
        where: "id = ?", whereArgs: ['${nuevaInspeccion.id}']);

    return res;
  }

  // DELETES Eliminar Registros

  //Eliminar de la base local Todos los Sitios
  Future<int> eliminarTodosSitios() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM minador_sitios');
    return res;
  }

//Eliminar de la base local Todos los Productos
  Future<int> eliminarTodosProductos() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM minador_productores');
    return res;
  }

//Eliminar de la base local todas las Inspecciones
  Future<int> eliminarTodosInspecciones() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM minador_certificacionf08');
    return res;
  }

//Eliminar de la base local todas las Inspecciones
  Future<int> eliminarInspeccionesIncompleta() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete(
        'DELETE FROM minador_certificacionf08 WHERE estado_f08 = ?',
        ['En proceso...']);
    return res;
  }

//Eliminar de la base local todas las Inspecciones
  Future<int> eliminarTodasPreguntas() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM minador_preguntas');
    return res;
  }
}
