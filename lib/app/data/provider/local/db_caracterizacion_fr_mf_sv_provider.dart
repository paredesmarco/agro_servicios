import 'package:agro_servicios/app/data/models/caracterizacion_fr_mosca_sv/caracterizacion_fr_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBCaracterizacionFrMfSvProvider {
  var database = DBProvider.db;

  //Inserts
  guardarProvinciaSincronizada(LocalizacionCatalogo localizacion) async {
    final db = await database.dataBase;

    final res = await db!.rawInsert(
        "INSERT Into provincia_sincronizada_caracterizacion_fr_mf_sv (id_localizacion, codigo, nombre, id_localizacion_padre, categoria) values (?,?,?,?,?)",
        [
          localizacion.idguia,
          localizacion.codigo,
          localizacion.nombre,
          localizacion.idGuiaPadre,
          localizacion.categoria
        ]);
    return res;
  }

  guardarCaracterizacion(CaracterizacionFrMfSvModelo muestreo) async {
    final db = await database.dataBase;
    final res = await db!.insert('moscaf02', muestreo.toJson());

    return res;
  }

  //Selects
  Future<LocalizacionModelo?> getProvinciaSincronizada() async {
    final db = await database.dataBase;
    final res = await db!.query(
      'provincia_sincronizada_caracterizacion_fr_mf_sv',
    );

    return res.isNotEmpty ? LocalizacionModelo.fromJson(res.first) : null;
  }

  Future getCaracterizacionTodos() async {
    final db = await database.dataBase;
    final res = await db!.query("moscaf02");

    List<CaracterizacionFrMfSvModelo> list = res.isNotEmpty
        ? res.map((e) => CaracterizacionFrMfSvModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  Future getCantidadCaracterizacion() async {
    final db = await database.dataBase;
    final res = await db!.rawQuery("SELECT count(id) cantidad FROM moscaf02");
    return res.toList();
  }

  //Deletes
  Future<int> eliminarProvinciaSincronizada() async {
    final db = await database.dataBase;
    final res =
        await db!.delete('provincia_sincronizada_caracterizacion_fr_mf_sv');
    return res;
  }

  Future<int> eliminarCaracterizacion() async {
    final db = await database.dataBase;
    final res = await db!.delete('moscaf02');
    return res;
  }
}
