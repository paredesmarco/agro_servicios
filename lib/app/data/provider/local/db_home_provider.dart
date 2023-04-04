import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

import 'package:agro_servicios/app/data/models/aplicaciones/aplicaciones_modelo.dart';
import 'package:agro_servicios/app/data/models/aplicaciones/areas_modelo.dart';
import 'package:agro_servicios/app/data/models/login/pin_modelo.dart';
import 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';

export 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';

class DBHomeProvider {
  static final DBHomeProvider db = DBHomeProvider._();

  DBHomeProvider._();
  DBProvider dataBase = DBProvider.db;

  /*
   * INSERTS CREAR Registros
   */

  nuevoUsuarioRaw(UsuarioModelo usuario) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawInsert(
        "INSERT Into usuario (identificador, nombre, tipo, foto)"
        "VALUES ('${usuario.identificador}','${usuario.nombre}','${usuario.tipo}','${usuario.foto}')");
    return res;
  }

  nuevoUsuario(UsuarioModelo usuario) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('usuario', usuario.toJson());
    return res;
  }

  nuevoAplicacion(AplicacionesModelo aplicacion) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('aplicacion', aplicacion.toJson());
    return res;
  }

  nuevoAreas(AreasModelo areas) async {
    final db = await dataBase.dataBase;
    final res = await db!.insert('area', areas.toJson());
    return res;
  }

  /*
  * SELECTS Obtener Registros
  */

  Future<UsuarioModelo?> getUsuario() async {
    final db = await dataBase.dataBase;
    final res = await db!.query(
      'usuario',
    );
    return res.isNotEmpty ? UsuarioModelo.fromJson(res.first) : null;
  }

  Future<UsuarioModelo?> getUsuarioPorIdentificador(
      String identificador) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('usuario',
        where: 'identificador = ?', whereArgs: [identificador]);
    return res.isNotEmpty ? UsuarioModelo.fromJson(res.first) : null;
  }

  Future<List<UsuarioModelo>> getTodosUsuarios() async {
    final db = await dataBase.dataBase;
    final res = await db!.query('usuario');

    List<UsuarioModelo> list = res.isNotEmpty
        ? res.map((e) => UsuarioModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<UsuarioModelo>> getTodosUsuariosPorTipo(String tipo) async {
    final db = await dataBase.dataBase;
    final res =
        await db!.rawQuery("SELECT * FROM usuario WHERE tipo = '$tipo'");

    List<UsuarioModelo> list = res.isNotEmpty
        ? res.map((e) => UsuarioModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<AplicacionesModelo>> getTodosAplicaciones() async {
    final db = await dataBase.dataBase;
    String campoOrden = BD_VERSION <= 3 ? 'nombre' : 'orden';
    final res = await db!.query('aplicacion', orderBy: campoOrden);

    List<AplicacionesModelo> list = res.isNotEmpty
        ? res.map((e) => AplicacionesModelo.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<AreasModelo>> getAreas(
      {String idAreaPadre = 'CGSV', String? orderBy}) async {
    final db = await dataBase.dataBase;
    final res = await db!.query('area',
        where: "id_area_padre = ?", whereArgs: [idAreaPadre], orderBy: orderBy);

    List<AreasModelo> list =
        res.isNotEmpty ? res.map((e) => AreasModelo.fromJson(e)).toList() : [];

    return list;
  }

  /*
   * UPDATES Actualizar Registros
   */

  Future<int> updateUsuarios(UsuarioModelo nuevoUsuario) async {
    final db = await dataBase.dataBase;
    final res = await db!.update('usuario', nuevoUsuario.toJson(),
        where: "identificador = ?",
        whereArgs: ['${nuevoUsuario.identificador}']);

    return res;
  }

  Future<int> updatePin(PinModelo nuevoPin) async {
    final db = await dataBase.dataBase;
    final res = await db!.rawUpdate(
        'UPDATE usuario SET pin = ?, fecha_caducidad = ? WHERE identificador = ?',
        [
          nuevoPin.cuerpo![0].pin,
          nuevoPin.cuerpo![0].fechaCaducidad.toString(),
          nuevoPin.cuerpo![0].identificador
        ]);

    return res;
  }

  // DELETES Eliminar Registros

  Future<int> deleteUsuarios(String identificador) async {
    final db = await dataBase.dataBase;
    final res = await db!.delete('usuario',
        where: "identificador = ?", whereArgs: [identificador]);
    return res;
  }

  Future<int> eliminarTodosUsuarios() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM usuario');
    return res;
  }

  Future<int> eliminarTodosAplicaciones() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM aplicacion');
    return res;
  }

  Future<int> eliminarTodosAreas() async {
    final db = await dataBase.dataBase;
    final res = await db!.rawDelete('DELETE FROM area');
    return res;
  }
}
