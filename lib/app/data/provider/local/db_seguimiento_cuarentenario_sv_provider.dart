import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_laboratorio_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_solicitud_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_sv_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBSeguimientoCuarentenarioProvider {
  var database = DBProvider.db;

  //Inserts

  Future<int> guardarSolicitudes(
      SeguimientoCuarentenarioSolicitudSvModelo solicitud) async {
    final db = await database.dataBase;

    Map<String, dynamic> datos = {
      'id_seguimiento_cuarentenario': solicitud.idSeguimientoCuarentenario,
      'identificador_operador': solicitud.identificadorOperador,
      'razon_social': solicitud.razonSocial,
      'id_pais_origen': solicitud.idPaisOrigen,
      'pais_origen': solicitud.paisOrigen,
      'numero_seguimientos_planificados':
          solicitud.numeroSeguimientosPlanificados,
      'numero_plantas_ingreso': solicitud.numeroPlantasIngreso,
      'utilizada': 0,
      'id_vue': solicitud.idVue
    };

    final res = await db!.insert('solicitud_control_f04', datos);

    return res;
  }

  Future<int> guardarProductoSolicitud(
      SeguimientoCuarentenarioProductoSvModelo solicitudProducto) async {
    final db = await database.dataBase;

    final res = await db!
        .insert('solicitud_control_f04_producto', solicitudProducto.toJson());

    return res;
  }

  Future<int> guardarAreaSolicitud(
      SeguimientoCuarentenarioAreaCuarentenaSvModelo
          solicitudAreasCuarentena) async {
    final db = await database.dataBase;
    final res = await db!.insert('solicitud_control_f04_areas_cuarentena',
        solicitudAreasCuarentena.toJson());

    return res;
  }

  Future<int> guardarInspeccionSeguimientoCuarentenario(
      SeguimientoCuarentenarioSvModelo inspeccion) async {
    final db = await database.dataBase;

    final res = await db!.insert('control_f04', inspeccion.toJson());

    return res;
  }

  Future<int> guardarInspeccionSeguimientoCuarentenarioProducto(
      SeguimientoCuarentenarioLaboratorioSvModelo inspeccion) async {
    final db = await database.dataBase;

    final res = await db!.insert('control_f04_orden', inspeccion.toJson());

    return res;
  }

  // Selects

  Future getCantidadSolicitudes() async {
    final db = await database.dataBase;
    final res = await db!
        .rawQuery("SELECT count(id) cantidad FROM solicitud_control_f04");
    return res.toList();
  }

  Future<int> getSecuenciaSolicitud() async {
    final db = await database.dataBase;

    final res = await db!
        .rawQuery("select max(id) + 1 as id_tablet from solicitud_control_f04");

    int id = res[0]['id_tablet'] == null
        ? 1
        : int.parse(res[0]['id_tablet'].toString());

    return id;
  }

  Future<List<SeguimientoCuarentenarioSolicitudSvModelo>>
      obtenerSolicitudesSincronizadas() async {
    final db = await database.dataBase;
    final res =
        await db!.query("solicitud_control_f04", orderBy: 'razon_social');

    List<SeguimientoCuarentenarioSolicitudSvModelo>? seguimientos;

    seguimientos = res.isNotEmpty
        ? res
            .map((e) => SeguimientoCuarentenarioSolicitudSvModelo.fromJson(e))
            .toList()
        : [];

    return seguimientos;
  }

  Future<List<SeguimientoCuarentenarioProductoSvModelo>>
      obtenerSolicitudesProductosSincronizados() async {
    final db = await database.dataBase;

    final res = await db!.query("solicitud_control_f04_producto");

    List<SeguimientoCuarentenarioProductoSvModelo> lista = res.isNotEmpty
        ? res
            .map((e) => SeguimientoCuarentenarioProductoSvModelo.fromJson(e))
            .toList()
        : [];

    return lista;
  }

  Future<List<SeguimientoCuarentenarioAreaCuarentenaSvModelo>>
      getSolicitudesAreasCuarentenaSincronizados(String identificador) async {
    final db = await database.dataBase;

    final res = await db!.query(
      "solicitud_control_f04_areas_cuarentena",
      where: "identificador_operador=?",
      whereArgs: [identificador],
    );

    List<SeguimientoCuarentenarioAreaCuarentenaSvModelo> lista = res.isNotEmpty
        ? res
            .map((e) =>
                SeguimientoCuarentenarioAreaCuarentenaSvModelo.fromJson(e))
            .toList()
        : [];

    return lista;
  }

  Future<SeguimientoCuarentenarioAreaCuarentenaSvModelo?>
      getSolicitudeAreasCuarentenaPorId(int id) async {
    final db = await database.dataBase;
    final res = await db!.query("solicitud_control_f04_areas_cuarentena",
        where: "id_guia=?", whereArgs: ['$id']);

    return res.isNotEmpty
        ? SeguimientoCuarentenarioAreaCuarentenaSvModelo.fromJson(res.first)
        : null;
  }

  Future<List<SeguimientoCuarentenarioLaboratorioSvModelo>>
      obtenerMuestrasLaboratorio() async {
    final db = await database.dataBase;
    final res = await db!.query("control_f04_orden");

    List<SeguimientoCuarentenarioLaboratorioSvModelo> lista = res.isNotEmpty
        ? res
            .map((e) => SeguimientoCuarentenarioLaboratorioSvModelo.fromJson(e))
            .toList()
        : [];

    return lista;
  }

  Future<List<SeguimientoCuarentenarioSvModelo>>
      obtenerRegistrosSeguimientos() async {
    final db = await database.dataBase;
    final res = await db!.query("control_f04");

    List<SeguimientoCuarentenarioSvModelo> lista = res.isNotEmpty
        ? res.map((e) => SeguimientoCuarentenarioSvModelo.fromJson(e)).toList()
        : [];

    return lista;
  }

  Future obtenerCantidadRegistrosSeguimiento() async {
    final db = await database.dataBase;
    final res =
        await db!.rawQuery("SELECT count(id) cantidad FROM control_f04");
    return res.toList();
  }

  Future<int> obtenerSecuenciaSeguimiento() async {
    final db = await database.dataBase;

    final res =
        await db!.rawQuery("select max(id) + 1 as id_tablet from control_f04");

    int id = res[0]['id_tablet'] == null
        ? 1
        : int.parse(res[0]['id_tablet'].toString());

    return id;
  }

  // Deletes

  Future<int> eliminarSolicitudes() async {
    final db = await database.dataBase;
    final res = await db!.delete("solicitud_control_f04");

    return res;
  }

  Future<int> eliminarSolicitudProductos() async {
    final db = await database.dataBase;
    final res = await db!.delete("solicitud_control_f04_producto");

    return res;
  }

  Future<int> eliminarSolicitudAreasCuarentena() async {
    final db = await database.dataBase;
    final res = await db!.delete("solicitud_control_f04_areas_cuarentena");

    return res;
  }

  Future<int> eliminarInspeccionesSeguimientos() async {
    final db = await database.dataBase;
    final res = await db!.delete("control_f04");

    return res;
  }

  Future<int> eliminarInspeccionesLaboratorio() async {
    final db = await database.dataBase;
    final res = await db!.delete("control_f04_orden");

    return res;
  }
}
