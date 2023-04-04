import 'package:agro_servicios/app/data/models/catalogos/envases_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBTiposEnvaseProvider {
  final databse = DBProvider.db;

  // Inserts

  ///
  /// Guardar el catálogo d tipos de envase
  ///
  Future guardarEnvase(EnvaseModelo envase) async {
    final db = await databse.dataBase;
    db!.insert('tipos_envase', envase.toJson());
  }

  // Selects

  ///
  /// Obtener el catálogo de tipos de envase para tránsito
  ///
  Future<List<EnvaseModelo>> getEnvases() async {
    final db = await databse.dataBase;
    final res = await db!.query('tipos_envase');

    List<EnvaseModelo> lista =
        res.isNotEmpty ? res.map((e) => EnvaseModelo.fromJson(e)).toList() : [];
    return lista;
  }

  // Deletes

  ///
  /// Obtener el catálogo de tipos de envase para tránsito
  ///
  Future eliminarEnvases() async {
    final db = await databse.dataBase;
    final res = await db!.delete('tipos_envase');

    return res;
  }
}
