import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/vigilancia_sv/orden_laboratorio_modelo.dart';
import 'package:agro_servicios/app/data/models/vigilancia_sv/vigilancia_modelo.dart';
import 'package:agro_servicios/app/data/models/vigilancia_sv/vigilancia_modelo_singleton.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBVigilanciaSv {
  var dataBase = DBProvider.db;

  //Selects

  Future<dynamic> getProvinciaSincronizada() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'provincia_sincronizada_vigilancia_sv',
    );

    return res.isNotEmpty ? LocalizacionModelo.fromJson(res.first) : null;
  }

  Future<List<VigilanciaModelo>> getVigilancia() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'monitoreo_vigilancia_sv',
    );

    List<VigilanciaModelo> list = res.isNotEmpty
        ? res.map((e) => VigilanciaModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<dynamic> getOrdenesLaboratorio() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'vigilancia_orden_sv',
    );
    List<OrdenLaboratorioSvModelo> list = res.isNotEmpty
        ? res.map((e) => OrdenLaboratorioSvModelo.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<dynamic> getSecuancialEspecie(String especie) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawQuery(
        "SELECT MAX(id) as secuencial from demo"
        "WHERE especie = '?'",
        [especie]);

    return res;
  }

  //Inserts
  guardarNuevaVigilancia(VigilanciaModeloSingleton modelo) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('monitoreo_vigilancia_sv', modelo.toJson());
    return res;
  }

  guardarOrdenLaboratorio(OrdenLaboratorioSvModelo modelo) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('vigilancia_orden_sv', modelo.toJson());
    return res;
  }

  guardarProvinciaSincronizada(LocalizacionCatalogo localizacion) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawInsert(
        "INSERT Into provincia_sincronizada_vigilancia_sv (id_localizacion, codigo, nombre, id_localizacion_padre, categoria) values (?,?,?,?,?)",
        [
          localizacion.idguia,
          localizacion.codigo,
          localizacion.nombre,
          localizacion.idGuiaPadre,
          localizacion.categoria
        ]);
    return res;
  }

  //Deletes
  Future<int> eliminarProvinciaSincronizada() async {
    final db = await dataBase.dataBase;
    final res = await db!.delete('provincia_sincronizada_vigilancia_sv');
    return res;
  }

  Future<int> eliminarMonitoreoVigilanciaOrdenes() async {
    final db = await dataBase.dataBase;
    final res = await db!.delete('vigilancia_orden_sv');
    return res;
  }

  Future<int> eliminarMonitoreoVigilancia() async {
    final db = await dataBase.dataBase;
    final res = await db!.delete('monitoreo_vigilancia_sv');
    return res;
  }
}
