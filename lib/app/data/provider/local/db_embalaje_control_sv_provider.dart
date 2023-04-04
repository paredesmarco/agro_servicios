import 'package:agro_servicios/app/data/models/embalaje_control_sv/embalaje_control_laboratorio_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/embalaje_control_sv/embalaje_control_sv_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBEmbalajeControlSvProvider {
  var database = DBProvider.db;

  //Inserts

  Future<int> guardarRegistrosEmbalaje(EmbalajeControlModelo embalaje) async {
    final db = await database.dataBase;

    final res = await db!.insert('control_f03', embalaje.toJson());

    return res;
  }

  Future<int> guardarRegistrosLaboratorio(
      EmbalajeControlLaboratorioSvModelo embalaje) async {
    final db = await database.dataBase;

    final res = await db!.insert('control_f03_orden', embalaje.toJson());

    return res;
  }

  // Selects

  Future getCantidadEmbalaje() async {
    final db = await database.dataBase;
    final res =
        await db!.rawQuery("SELECT count(id) cantidad FROM control_f03");
    return res.toList();
  }

  Future<int> getSecuenciaEmbalaje() async {
    final db = await database.dataBase;

    final res =
        await db!.rawQuery("select max(id) + 1 as id_tablet from control_f03");

    int id = res[0]['id_tablet'] == null
        ? 1
        : int.parse(res[0]['id_tablet'].toString());

    return id;
  }

  Future<int> getSecuenciaLaboratorio() async {
    final db = await database.dataBase;

    final res = await db!
        .rawQuery("select max(id) + 1 as id_tablet from control_f03_orden");
    int id = res[0]['id_tablet'] == null
        ? 1
        : int.parse(res[0]['id_tablet'].toString());
    return id;
  }

  Future<List<EmbalajeControlModelo>> getInspecciones() async {
    final db = await database.dataBase;

    final res = await db!.query("control_f03");

    List<EmbalajeControlModelo> lista = res.isNotEmpty
        ? res.map((e) => EmbalajeControlModelo.fromJson(e)).toList()
        : [];

    return lista;
  }

  Future<List<EmbalajeControlLaboratorioSvModelo>>
      getOrdenesLaboratorio() async {
    final db = await database.dataBase;

    final res = await db!.query("control_f03_orden");

    List<EmbalajeControlLaboratorioSvModelo> lista = res.isNotEmpty
        ? res
            .map((e) => EmbalajeControlLaboratorioSvModelo.fromJson(e))
            .toList()
        : [];

    return lista;
  }

  // Deletes

  Future<int> eliminarRegistrosEmbalaje() async {
    final db = await database.dataBase;
    final res = await db!.delete("control_f03");

    return res;
  }

  Future<int> eliminarRegistrosOrdenLaboratorio() async {
    final db = await database.dataBase;
    final res = await db!.delete("control_f03_orden");

    return res;
  }
}
