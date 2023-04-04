import 'package:agro_servicios/app/data/models/trampeo_sv/formulario_orden_trabajo_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/formulario_trampa_detalle_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/formulario_trampa_inspeccion_padre.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

import 'package:agro_servicios/app/data/models/trampeo_sv/trampas_modelo.dart';

class DBTrampeoVigilancia {
  // var database.dataBase = DBProvider.db;
  // static Database.dataBase? _dataBase;
  // static final DBTrampeoVigilancia db =
  //     DBTrampeoVigilancia._constructorPrivado();

  // DBTrampeoVigilancia._constructorPrivado();

  // Future<Database.dataBase?> get dataBase.dataBase async {
  //   if (_dataBase != null) return _dataBase;
  //   _dataBase = await initDB();
  //   return _dataBase;
  // }

  // initDB() async {
  //   Directory direccionDocumentos = await getApplicationDocumentsDirectory();
  //   String path = join(direccionDocumentos.path, 'agrodb.db');

  //   return await openDatabase(
  //     path,
  //     version: BD_VERSION,
  //     onOpen: (db) {},
  //   );
  // }

  var dataBase = DBProvider.db;

  guardarNuevaTrampa(Trampas trampas) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('trampas', trampas.toJson());
    return res;
  }

  guardarInspeccionPadre(InspeccionPadreModelo inspeccionPadre) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert("inspecion_padre", inspeccionPadre.toJson());
    return res;
  }

  guardarDetalleTrampa(TrampaDetallemodelo trampaDetalle) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('detalle_trampa', trampaDetalle.toJson());
    return res;
  }

  guardarMuestralaboratorio(OrdenTrabajoLaboratorioModelo ordenTrabajo) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('orden_laboratorio', ordenTrabajo.toJson());
    return res;
  }

  guardarProvinicasSincronizadas(int? provincia) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawInsert(
        "INSERT INTO provincias_sincronizadas_trampas_sv(id_localizacion) VALUES (?)",
        [provincia]);
    return res;
  }

  limpiarProvinciasSincronizadas() async {
    final db = await dataBase.dataBase;
    await db!.delete('provincias_sincronizadas_trampas_sv');
  }

  limpiarTrampas() async {
    final db = await dataBase.dataBase;
    await db!.delete('trampas');
  }

  limpiarTrampasPadre() async {
    final db = await dataBase.dataBase;
    await db!.delete('inspecion_padre');
  }

  limpiarTrampasDetalle() async {
    final db = await dataBase.dataBase;
    await db!.delete('detalle_trampa');
  }

  limpiarOrdenLaboratorio() async {
    final db = await dataBase.dataBase;
    await db!.delete('orden_laboratorio');
  }

  Future getTrampasMax() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawQuery("SELECT MAX(id) cantidad FROM trampas");
    return res.toList();
  }

  Future<Trampas?> getTrampasTodas() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'trampas',
    );
    return res.isNotEmpty ? Trampas.fromJson(res.first) : null;
  }

  Future<List<Trampas>> getTrampasPorNumero(
      int? canton, int? lugar, String numero) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trampas',
        where:
            'idcanton = ? and idlugarinstalacion=? and numerolugarinstalacion=? and utilizado !=?',
        whereArgs: [canton, lugar, numero, 1]);

    List<Trampas> list =
        res.isNotEmpty ? res.map((e) => Trampas.fromJson(e)).toList() : [];

    return list;
  }

  Future<List<Trampas>> getTrampasPorParroquia(
      int? canton, int? lugar, int? parroquia) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trampas',
        where:
            'idcanton = ? and idlugarinstalacion=? and idparroquia=? and utilizado != ?',
        whereArgs: [canton, lugar, parroquia, 1]);

    List<Trampas> list =
        res.isNotEmpty ? res.map((e) => Trampas.fromJson(e)).toList() : [];

    return list;
  }

  Future<List<LocalizacionModelo>> getProvinciasSincronizadas() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawQuery("SELECT DISTINCT l.* "
        "FROM provincias_sincronizadas_trampas_sv as ps, localizacion as l "
        "WHERE l.id_localizacion = ps.id_localizacion;");

    List<LocalizacionModelo> list = res.isNotEmpty
        ? res.map((e) => LocalizacionModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<LocalizacionModelo>> getCantonesSincronizadas(
      int? provincia) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawQuery(
        "SELECT DISTINCT l.* FROM localizacion l, trampas t "
        "where l.id_localizacion = t.idcanton "
        "and t.idprovincia = ? and t.utilizado !=?"
        " ORDER BY 4 ;",
        [provincia, 1]);

    List<LocalizacionModelo> list = res.isNotEmpty
        ? res.map((e) => LocalizacionModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<Trampas>> getLugarInstalacion(int? canton) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trampas',
        groupBy: 'idlugarinstalacion',
        where: 'idcanton=? and utilizado != ?',
        whereArgs: [canton, 1]);

    List<Trampas> list =
        res.isNotEmpty ? res.map((e) => Trampas.fromJson(e)).toList() : [];

    return list;
  }

  Future<Trampas?> getNombreInstalacion(int? canton, lugarInstalacion) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trampas',
        distinct: true,
        groupBy: 'idlugarinstalacion',
        where: 'idcanton=? and idlugarinstalacion=?',
        whereArgs: [canton, lugarInstalacion]);

    return res.isNotEmpty ? Trampas.fromJson(res.first) : null;
  }

  Future<List<Trampas>> getNumeroLugarIsntalacion(
      int? canton, int lugarInstalacion) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('trampas',
        groupBy: 'numerolugarinstalacion',
        where: 'idcanton=? and idlugarinstalacion=?',
        whereArgs: [canton, lugarInstalacion]);

    List<Trampas> list =
        res.isNotEmpty ? res.map((e) => Trampas.fromJson(e)).toList() : [];

    return list;
  }

  Future<List<LocalizacionModelo>> getParroquias(
      int? canton, int? lugarInstalacion) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawQuery(
        "SELECT idparroquia as id_localizacion, parroquia as nombre "
        "FROM trampas where idcanton=? and idlugarinstalacion=? group by idparroquia;",
        [canton, lugarInstalacion]);

    List<LocalizacionModelo> list = res.isNotEmpty
        ? res.map((e) => LocalizacionModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future getSecuencialOrden(String? codigoTrampa) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawQuery(
        "SELECT secuencialorden "
        "FROM trampas where codigotrampa=?;",
        [codigoTrampa]);

    return res.toList();
  }

  Future getCantidadTrampasUtilizadas() async {
    final db = await dataBase.dataBase;
    final res = await db!
        .rawQuery("SELECT count(id) cantidad FROM trampas WHERE utilizado = 1");

    return res.toList();
  }

  Future getCantidadTrampasDetalle() async {
    final db = await dataBase.dataBase;
    final res =
        await db!.rawQuery("SELECT count(id) cantidad FROM detalle_trampa;");

    // final res =
    //     await db!.rawQuery("SELECT count(id) cantidad FROM inspecion_padre;");

    return res.toList();
  }

  Future<List<TrampaDetallemodelo>> getTrampasDetalle() async {
    final db = await dataBase.dataBase;
    final res = await db!.query('detalle_trampa');

    List<TrampaDetallemodelo> list = res.isNotEmpty
        ? res.map((e) => TrampaDetallemodelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<InspeccionPadreModelo>> getInspeccionPadre() async {
    final db = await dataBase.dataBase;
    final res = await db!.query('inspecion_padre');
    List<InspeccionPadreModelo> list = res.isNotEmpty
        ? res.map((e) => InspeccionPadreModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<OrdenTrabajoLaboratorioModelo>> getOrdeneslaboratorio() async {
    final db = await dataBase.dataBase;
    final res = await db!.query('orden_laboratorio');
    List<OrdenTrabajoLaboratorioModelo> list = res.isNotEmpty
        ? res.map((e) => OrdenTrabajoLaboratorioModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  /// 0 = sin utilizar
  /// 1 = trampa utilizada
  /// 2 = trampa sincronizada up
  Future<int> updateTrampaCompletada(
      int condicion, String? codigoTrampa) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawUpdate(
        'UPDATE trampas SET utilizado = ? WHERE codigotrampa = ?',
        [condicion, codigoTrampa]);

    return res;
  }
}
