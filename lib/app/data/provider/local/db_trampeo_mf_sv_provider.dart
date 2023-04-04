import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_detalle_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_laboratorio_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_padre_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBTrampeoMfSvProvider {
  var database = DBProvider.db;

  Future nuevoUsuario(TrampasMfSvModelo usuario) async {
    final db = await database.dataBase;
    final res = await db!.insert('usuario', usuario.toJson());
    return res;
  }

  Future guardarNuevaTrampa(TrampasMfSvModelo trampas) async {
    final db = await database.dataBase;
    final res = await db!.insert('moscaf01_trampas', trampas.toJson());
    return res;
  }

  Future<void> limpiarTrampas() async {
    final db = await database.dataBase;
    await db!.delete('moscaf01_trampas');
  }

  Future<List<TrampasMfSvModelo>> getTrampas() async {
    final db = await database.dataBase;
    final res = await db!.query('moscaf01_trampas');

    List<TrampasMfSvModelo> list = res.isNotEmpty
        ? res.map((e) => TrampasMfSvModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<LocalizacionModelo>> getProvinciasSincronizadas() async {
    final db = await database.dataBase;
    final res = await db!.rawQuery(
        'SELECT id_provincia as id_localizacion, provincia as nombre '
        'FROM moscaf01_trampas '
        'WHERE utilizado != ? '
        'group by id_provincia ;',
        [1]);

    List<LocalizacionModelo> list = res.isNotEmpty
        ? res.map((e) => LocalizacionModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<LocalizacionModelo>> getCantonesPorProvincia(
      int? provincia) async {
    final db = await database.dataBase;

    final res = await db!.rawQuery(
        'SELECT id_canton as id_localizacion, canton as nombre '
        'FROM moscaf01_trampas '
        'WHERE id_provincia = ? and utilizado != ? '
        'group by id_canton ;',
        [provincia, 1]);

    List<LocalizacionModelo> list = res.isNotEmpty
        ? res.map((e) => LocalizacionModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<TrampasMfSvModelo>> getLugarInstalacion(int? canton) async {
    final db = await database.dataBase;
    final res = await db!.query('moscaf01_trampas',
        groupBy: 'id_lugar_instalacion',
        where: 'id_canton=? and utilizado != ?',
        whereArgs: [canton, 1]);

    List<TrampasMfSvModelo> list = res.isNotEmpty
        ? res.map((e) => TrampasMfSvModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<TrampasMfSvModelo?> getNombreInstalacion(
      int? canton, int lugarInstalacion) async {
    final db = await database.dataBase;
    final res = await db!.query('moscaf01_trampas',
        distinct: true,
        groupBy: 'id_lugar_instalacion',
        where: 'id_canton=? and id_lugar_instalacion=?',
        whereArgs: [canton, lugarInstalacion]);

    return res.isNotEmpty ? TrampasMfSvModelo.fromJson(res.first) : null;
  }

  Future<List<TrampasMfSvModelo>> getNumeroLugarIsntalacion(
      int? canton, int lugarInstalacion) async {
    final db = await database.dataBase;
    final res = await db!.query('moscaf01_trampas',
        groupBy: 'numero_lugar_instalacion',
        where: 'id_canton=? and id_lugar_instalacion=?',
        whereArgs: [canton, lugarInstalacion]);

    List<TrampasMfSvModelo> list = res.isNotEmpty
        ? res.map((e) => TrampasMfSvModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<LocalizacionModelo>> getParroquias(
      int? canton, int? lugarInstalacion) async {
    final db = await database.dataBase;
    final res = await db!.rawQuery(
        "SELECT id_parroquia as id_localizacion, parroquia as nombre "
        "FROM moscaf01_trampas where id_canton=? and id_lugar_instalacion=? group by id_parroquia;",
        [canton, lugarInstalacion]);

    List<LocalizacionModelo> list = res.isNotEmpty
        ? res.map((e) => LocalizacionModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<TrampasMfSvModelo>> getTrampasPorNumero(
      int? canton, int? lugar, int numero) async {
    final db = await database.dataBase;
    final res = await db!.query('moscaf01_trampas',
        where:
            'id_canton = ? and id_lugar_instalacion=? and numero_lugar_instalacion=? and utilizado !=?',
        whereArgs: [canton, lugar, '$numero', 1]);

    List<TrampasMfSvModelo> list = res.isNotEmpty
        ? res.map((e) => TrampasMfSvModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<TrampasMfSvModelo>> getTrampasPorParroquia(
      int? canton, int? lugar, int? parroquia) async {
    final db = await database.dataBase;
    final res = await db!.query('moscaf01_trampas',
        where:
            'id_canton = ? and id_lugar_instalacion=? and id_parroquia=? and utilizado != ?',
        whereArgs: [canton, lugar, parroquia, 1]);

    List<TrampasMfSvModelo> list = res.isNotEmpty
        ? res.map((e) => TrampasMfSvModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future getSecuencialOrden(String? codigoTrampa) async {
    final db = await database.dataBase;
    final res = await db!.rawQuery(
        "SELECT secuencial_orden "
        "FROM moscaf01_trampas where codigo_trampa=?;",
        [codigoTrampa]);

    return res.toList();
  }

  Future getCantidadTrampasCompletadas() async {
    final db = await database.dataBase;
    final res = await db!
        .rawQuery("SELECT count(id) as cantidad FROM moscaf01_detalle_trampas");

    return res.toList();
  }

  Future getSinOperaciones() async {
    final db = await database.dataBase;
    final res = await db!
        .rawQuery("SELECT count(id) as cantidad FROM moscaf01_detalle_trampas");

    return res.toList();
  }

  Future getDetallesTrampasPadre() async {
    final db = await database.dataBase;
    final res = await db!.query('moscaf01');

    List<TrampasMfSvPadreModelo> list = res.isNotEmpty
        ? res.map((e) => TrampasMfSvPadreModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  Future getDetallesTrampas() async {
    final db = await database.dataBase;
    final res = await db!.query('moscaf01_detalle_trampas');

    List<TrampasMfSvDetalleModelo> list = res.isNotEmpty
        ? res.map((e) => TrampasMfSvDetalleModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  Future getOrdenesTodas() async {
    final db = await database.dataBase;
    final res = await db!.query('moscaf01_detalle_ordenes');

    List<TrampasMfSvLaboratorioModelo> list = res.isNotEmpty
        ? res.map((e) => TrampasMfSvLaboratorioModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  /* INSERTS
  */

  guardarInspeccionPadre(TrampasMfSvPadreModelo inspeccionPadre) async {
    final db = await database.dataBase;
    final res = await db!.insert("moscaf01", inspeccionPadre.toJson());

    return res;
  }

  guardarDetalleTrampa(TrampasMfSvDetalleModelo trampaDetalle) async {
    final db = await database.dataBase;
    final res =
        await db?.insert('moscaf01_detalle_trampas', trampaDetalle.toJson());

    return res;
  }

  guardarMuestralaboratorio(
      TrampasMfSvLaboratorioModelo ordenLaboratorio) async {
    final db = await database.dataBase;
    final res =
        await db!.insert('moscaf01_detalle_ordenes', ordenLaboratorio.toJson());
    return res;
  }

  /// 0 = sin utilizar
  /// 1 = trampa utilizada
  /// 2 = trampa sincronizada up
  Future<int> updateTrampaCompletada(
      int condicion, String? codigoTrampa) async {
    final db = await database.dataBase;
    final res = await db!.rawUpdate(
        'UPDATE moscaf01_trampas SET utilizado = ? WHERE codigo_trampa = ?',
        [condicion, codigoTrampa]);

    return res;
  }

  //Deletes

  Future<int> eliminarTrampasSincronizadas() async {
    final db = await database.dataBase;
    final res = await db!.delete('moscaf01_trampas');
    return res;
  }

  Future<int> eliminarTrampasInspeccionPadre() async {
    final db = await database.dataBase;
    final res = await db!.delete('moscaf01');
    return res;
  }

  Future<int> eliminarTrampasDetalle() async {
    final db = await database.dataBase;
    final res = await db!.delete('moscaf01_detalle_trampas');
    return res;
  }

  Future<int> eliminarOrdenesLaboratorio() async {
    final db = await database.dataBase;
    final res = await db!.delete('moscaf01_detalle_ordenes');
    return res;
  }
}
