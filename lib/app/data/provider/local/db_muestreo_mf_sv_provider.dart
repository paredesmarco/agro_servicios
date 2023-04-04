import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/muestreo_mosca_sv/muestreo_mf_sv_laboratorio_modelo.dart';
import 'package:agro_servicios/app/data/models/muestreo_mosca_sv/muestreo_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBMuestreoMfSvProvider {
  var database = DBProvider.db;

  //Selects
  Future<List<LocalizacionModelo?>> obtenerTodasProvincia() async {
    final List<LocalizacionModelo?> lista =
        await DBLocalizcion.db.getTodosProvincias(1);
    return lista;
  }

  Future<LocalizacionModelo?> getProvinciaSincronizada() async {
    final db = await database.dataBase;
    final res = await db!.query(
      'provincia_sincronizada_muestreo_mf_sv',
    );

    return res.isNotEmpty ? LocalizacionModelo.fromJson(res.first) : null;
  }

  Future<LocalizacionModelo?> getCantidadRegistros() async {
    final db = await database.dataBase;
    final res = await db!.query(
      'moscaf03',
    );

    return res.isNotEmpty ? LocalizacionModelo.fromJson(res.first) : null;
  }

  Future getCantidadMuestras() async {
    final db = await database.dataBase;
    final res = await db!.rawQuery("SELECT count(id) cantidad FROM moscaf03");
    return res.toList();
  }

  Future getMuestreoTodos() async {
    final db = await database.dataBase;
    final res = await db!.query("moscaf03");

    // print(res);
    // var logger = Logger();
    // logger.d(res);

    List<MuestreoMfSvModelo> list = res.isNotEmpty
        ? res.map((e) => MuestreoMfSvModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  Future getOrdenesLaboratorioTodos() async {
    final db = await database.dataBase;
    final res = await db!.query("moscaf03_detalle_ordenes");

    List<MuestreoMfSvLaboratorioModeo> list = res.isNotEmpty
        ? res.map((e) => MuestreoMfSvLaboratorioModeo.fromJson(e)).toList()
        : [];
    return list;
  }

  //Inserts
  guardarProvinciaSincronizada(LocalizacionCatalogo localizacion) async {
    final db = await database.dataBase;
    final res = await db!.rawInsert(
        "INSERT Into provincia_sincronizada_muestreo_mf_sv (id_localizacion, codigo, nombre, id_localizacion_padre, categoria) values (?,?,?,?,?)",
        [
          localizacion.idguia,
          localizacion.codigo,
          localizacion.nombre,
          localizacion.idGuiaPadre,
          localizacion.categoria
        ]);
    return res;
  }

  guardarMuestreo(MuestreoMfSvModelo muestreo,
      List<MuestreoMfSvLaboratorioModeo> laboratorio) async {
    final db = await database.dataBase;
    final res = await db!.insert('moscaf03', muestreo.toJson());

    for (var e in laboratorio) {
      e.idMuestreo = res;
      _guardarOrdenLaboratorio(e);
    }

    return res;
  }

  _guardarOrdenLaboratorio(MuestreoMfSvLaboratorioModeo modelo) async {
    final db = await database.dataBase;
    final res = await db!.insert('moscaf03_detalle_ordenes', modelo.toJson());

    return res;
  }

  //Deletes
  Future<int> eliminarProvinciaSincronizada() async {
    final db = await database.dataBase;
    final res = await db!.delete('provincia_sincronizada_muestreo_mf_sv');
    return res;
  }

  Future<int> eliminarMuestreo() async {
    final db = await database.dataBase;
    final res = await db!.delete('moscaf03');
    return res;
  }

  Future<int> eliminarOrdenesLaboratorio() async {
    final db = await database.dataBase;
    final res = await db!.delete('moscaf03_detalle_ordenes');
    return res;
  }
}
