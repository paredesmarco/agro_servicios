import 'package:agro_servicios/app/data/models/trips_sv/trips_modelo.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_productor_modelo.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_sitio_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';
import 'package:sqflite/sqflite.dart';
export 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';

class DBTripsProvider {
  // static final DBTripsProvider db = DBTripsProvider._();

  // DBTripsProvider._();
  DBProvider dataBase = DBProvider.db;

  /*
   * INSERTS CREAR Registros
   */

  ///Guarda en la Base Local los Datos
  // creaTablasTripsCatalogo() async {
  //   final db = await dataBase.dataBase;
  //   // DBTripSql.scriptDrop,
  //   List<List<String>> scripts = [
  //     // DBPreguntasSvSql.scriptDrop,
  //     // DBPreguntasSvSql.script,
  //     // DBTripSql.scriptCatalogos,

  //     // DBTripSql.scriptDelete,
  //   ];

  //   scripts.forEach((e) async {
  //     e.forEach((script) async => await db?.execute(script));
  //   });
  // }

  ///Guarda en la Base Local los Datos
  nuevoSitio(TripsSitioModelo modelo) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('trips_sitios', modelo.toJson());
    return res;
  }

  ///Guarda en la Base Local los Datos
  nuevoProducto(TripsProductorModelo modelo) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('trips_productores', modelo.toJson());
    return res;
  }

  ///Guarda en la Base Local los Datos de Inspecciones esta esta por REVISAR
  nuevoInspeccion(TripsModelo modelo) async {
    // print(
    // "INSERT INTO trips_certificacionf09 (id,id_tablet, numero_reporte, ruc, razon_social, provincia, canton, parroquia, id_sitio_produccion, sitio_produccion,representante, resultado, observaciones, fecha_inspeccion, usuario_id, usuario, tablet_id, tablet_version_base, fecha_ingreso_guia, estado_f09, observacion_f09,  tipo_area, total_resultado,total_areas,id_ponderacion) VALUES ('${modelo.id}','${modelo.idTablet}', '${modelo.numeroReporte}', '${modelo.ruc}', '${modelo.razonSocial}', '${modelo.provincia}','${modelo.canton}', '${modelo.parroquia}', '${modelo.idSitioProduccion}', '${modelo.sitioProduccion}', '${modelo.representante}', '${modelo.resultado}', '${modelo.observaciones}', '${modelo.fechaInspeccion}','${modelo.usuarioId}', '${modelo.usuario}', '${modelo.tabletId}', '${modelo.tabletVersionBase}', '${modelo.fechaIngresoGuia}','${modelo.estadoF09}', '${modelo.observacionF09}', '${modelo.tipoArea}', '${modelo.totalResultado}', '${modelo.totalAreas}', '${modelo.idPonderacion}')");
    final db = await dataBase.dataBase;
    final res = await db!.rawInsert(
        "INSERT INTO trips_certificacionf09 (id,id_tablet, numero_reporte, ruc, razon_social, provincia, canton, parroquia, id_sitio_produccion, sitio_produccion,representante, resultado, observaciones, fecha_inspeccion, usuario_id, usuario, tablet_id, tablet_version_base, fecha_ingreso_guia, estado_f09, observacion_f09,  tipo_area, total_resultado,total_areas,id_ponderacion) VALUES ('${modelo.id}','${modelo.idTablet}', '${modelo.numeroReporte}', '${modelo.ruc}', '${modelo.razonSocial}', '${modelo.provincia}','${modelo.canton}', '${modelo.parroquia}', '${modelo.idSitioProduccion}', '${modelo.sitioProduccion}', '${modelo.representante}', '${modelo.resultado}', '${modelo.observaciones}', '${modelo.fechaInspeccion}','${modelo.usuarioId}', '${modelo.usuario}', '${modelo.tabletId}', '${modelo.tabletVersionBase}', '${modelo.fechaIngresoGuia}','${modelo.estadoF09}', '${modelo.observacionF09}', '${modelo.tipoArea}', '${modelo.totalResultado}', '${modelo.totalAreas}', '${modelo.idPonderacion}')");
    return res;
  }

  ///Guarda en la Base Local los Datos de Inspecciones esta esta por REVISAR
  Future<int> codigoInspeccion() async {
    int codigo = 0;
    final db = await dataBase.dataBase;
    var resM = Sqflite.firstIntValue(await db!
        .rawQuery("SELECT max(id) AS codigo FROM trips_certificacionf09"));
    if (resM == null) {
      codigo = 1;
    } else {
      codigo = int.parse(resM.toString()) + 1;
    }

    // print(codigo);
    return codigo;
  }

  /// Retorna Todo el Catálogo de Operadores o Productores
  /// Devuelve: List<TripsProductorModelo>
  Future<List<TripsProductorModelo>> obtenerListaTripsProductorModelo() async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trips_productores');
    List<TripsProductorModelo> list = res.isNotEmpty
        ? res.map((e) => TripsProductorModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  ///Obtiene los sitios de un Operador
  Future<List<String>> obtenerSitioLista(idProductor) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trips_sitios',
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
  Future<List<TripsSitioModelo>> obteneAreaPorOpeSitTip(
      idProductor, idSitio, tipoArea) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trips_sitios',
        distinct: true,
        columns: ['id_area', 'area'],
        where: 'identificador_operador=? and id_sitio=? and tipo_area=?',
        whereArgs: ['$idProductor', '$idSitio', '$tipoArea']);

    List<TripsSitioModelo> list = res.isNotEmpty
        ? res.map((e) => TripsSitioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  ///Obtiene las areas de un sitio
  Future<List<TripsSitioModelo>> obteneTipoAreaPorOpeSit(
      idProductor, idSitio) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trips_sitios',
        distinct: true,
        columns: ['tipo_area'],
        where: 'identificador_operador=? and id_sitio=?',
        whereArgs: ['$idProductor', '$idSitio']);

    List<TripsSitioModelo> list = res.isNotEmpty
        ? res.map((e) => TripsSitioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  ///Obtiene el sitio por id
  Future<TripsSitioModelo?> obtenerSitioPorId(int idSitio) async {
    final db = await dataBase.dataBase;
    final res = await db!
        .query('trips_sitios', where: 'id_sitio=?', whereArgs: [idSitio]);

    return res.isEmpty ? null : TripsSitioModelo.fromJson(res.first);
  }

  /// Retorna todo un registro con los datos de ubicacion de la tabla trips_sitios, filtrada,
  /// por indentificador,sitio,area
  /// Recibe:identificador del operador,sitio,area
  /// Devuleve List<TripsSitioModelo>
  Future<List<TripsSitioModelo>> obtenerUbicacion(
      identificador, idSitio, idArea) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trips_sitios',
        where: 'identificador_operador=? and id_sitio=? and id_area=?',
        whereArgs: ['$identificador', '$idSitio', '$idArea']);

    List<TripsSitioModelo> list = res.isNotEmpty
        ? res.map((e) => TripsSitioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<TripsSitioModelo>> obtenerUbicacionMultiple(
      identificador, idSitio, idArea) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawQuery(
        "SELECT * FROM trips_sitios WHERE identificador_operador = '$identificador' and id_sitio=$idSitio and id_area IN ($idArea)");

    List<TripsSitioModelo> list = res.isNotEmpty
        ? res.map((e) => TripsSitioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<TripsSitioModelo?> obtenerUbicacionModelo(
      identificador, idSitio, idArea) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trips_sitios',
        where: 'identificador_operador=? and id_sitio=? and id_area=?',
        whereArgs: ['$identificador', '$idSitio', '$idArea']);

    return res.isNotEmpty ? TripsSitioModelo.fromJson(res.first) : null;
  }

  Future<List<TripsSitioModelo>> obtenerSitiosPorUsuario(identificador) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trips_sitios',
        distinct: true,
        columns: ['id_sitio,sitio'],
        where: 'identificador_operador=?',
        whereArgs: ['$identificador']);

    List<TripsSitioModelo> list = res.isNotEmpty
        ? res.map((e) => TripsSitioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  //Obtener de la base local Todos los Sitios
  Future<TripsSitioModelo?> obtenerTodosSitio() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'trips_sitios',
    );
    return res.isNotEmpty ? TripsSitioModelo.fromJson(res.first) : null;
  }

  //Obtener de la base local Todos los Productos
  Future<TripsProductorModelo?> obtenerTodosProductor() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'trips_productores',
    );
    return res.isNotEmpty ? TripsProductorModelo.fromJson(res.first) : null;
  }

  ///Obtiene una lista de todas las inspecciones completas
  Future<TripsModelo?> obtenerTripsModelo() async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trips_certificacionf09',
        where: 'estado_f09=?', whereArgs: ['activo']);
    return res.isNotEmpty ? TripsModelo.fromJson(res.first) : null;
  }

  ///Obtiene una lista de todas las inspecciones completas
  Future<List<TripsModelo>> obtenerTripsListaCompleto() async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trips_certificacionf09',
        where: 'estado_f09=?', whereArgs: ['activo']);

    List<TripsModelo> list =
        res.isNotEmpty ? res.map((e) => TripsModelo.fromJson(e)).toList() : [];
    return list;
  }

  ///Obtener de la base local Todos las Inspecciones
  Future<List<TripsModelo>> obtenerTodosInspeccionesLista(usuarioId) async {
    final db = await dataBase.dataBase;

    final res = await db!.query('trips_certificacionf09',
        where: 'usuario_id=?',
        whereArgs: ['$usuarioId'],
        orderBy: 'estado_f09,id DESC');

    List<TripsModelo> list =
        res.isNotEmpty ? res.map((e) => TripsModelo.fromJson(e)).toList() : [];
    return list;
  }

  ///Obtener de la base local Todos las Inspecciones x estado I Incompleto C Completo
  Future<TripsModelo> obtenerInspeccionEstado(estado, usuarioId) async {
    TripsModelo modelo = TripsModelo();
    final db = await dataBase.dataBase;

    final res = await db!.query('trips_certificacionf09',
        where: 'estado_f09=? and usuario_id=?',
        whereArgs: ['$estado', '$usuarioId']);
    if (res.isNotEmpty) {
      return TripsModelo.fromJson(res.first);
    } else {
      return modelo;
    }
  }

  /*
   * UPDATES Actualizar Registros
   */

  ///Revisar las actualizaciones
  ///
  Future<int> actualizaTrips(TripsModelo nuevaInspeccion) async {
    final db = await dataBase.dataBase;
    final res = await db!.update(
        'trips_certificacionf09', nuevaInspeccion.toJson(),
        where: "id = ?", whereArgs: ['${nuevaInspeccion.id}']);

    return res;
  }

  Future<int> actualizaCampoTrips(id, campo, valor) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawUpdate(
        'UPDATE trips_certificacionf09 SET $campo = ? WHERE id = ?',
        ['$valor', id]);
    // print('Actualizar $campo=$valor');
    return res;
  }

  //Revisar si seria mejor solo enviar el estado Incompleto, Completo
  Future<int> actualizarTripsEstado(TripsModelo nuevaInspeccion) async {
    final db = await dataBase.dataBase;
    Map<String, Object> estado = {'estado_f09': '${nuevaInspeccion.estadoF09}'};
    final res = await db!.update('trips_certificacionf09', estado,
        where: "id = ?", whereArgs: ['${nuevaInspeccion.id}']);

    return res;
  }

  // DELETES Eliminar Registros

  //Eliminar de la base local Todos los Sitios
  Future<int> eliminarTodosSitios() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM trips_sitios');
    return res;
  }

//Eliminar de la base local Todos los Productos
  Future<int> eliminarTodosProductos() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM trips_productores');
    return res;
  }

//Eliminar de la base local todas las Inspecciones
  Future<int> eliminarTodosInspecciones() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM trips_certificacionf09');
    return res;
  }

//Eliminar de la base local todas las Inspecciones
  Future<int> eliminarInspeccionesIncompleta() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete(
        'DELETE FROM trips_certificacionf09 WHERE estado_f09 = ?',
        ['En proceso...']);
    return res;
  }

//Eliminar de la base local todas las Inspecciones
  Future<int> eliminarTodasPreguntas() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM trips_preguntas');
    return res;
  }
}
