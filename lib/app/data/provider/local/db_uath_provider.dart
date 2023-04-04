import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBUathProvider {
  var database = DBProvider.db;

  //Inserts

  ///Guardar provincia del contrato activo del usuario
  Future guardarProvinciaContrato(
      ProvinciaUsuarioContratoModelo provincia) async {
    final db = await database.dataBase;

    final res =
        await db!.insert('provincia_usuario_contrato', provincia.toJson());
    return res;
  }

  //Deletes

  ///Elimina la provincia del contrato activo del usuario
  Future eliminarProvinciaContrato() async {
    final db = await database.dataBase;

    final res = await db!.delete('provincia_usuario_contrato');
    return res;
  }

  //Selects

  ///Obtiene la provincia del contrato activo del usuario
  Future<ProvinciaUsuarioContratoModelo?> getProvinciaContrato() async {
    final db = await database.dataBase;

    final res = await db!.query('provincia_usuario_contrato');

    return res.isNotEmpty
        ? ProvinciaUsuarioContratoModelo.fromJson(res.first)
        : null;
  }
}
