import 'package:agro_servicios/app/data/models/catalogos/paises_origen_procedencia_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/productos_transito_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBRequistosTransitoProvider {
  final database = DBProvider.db;

  //Inserts

  ///
  ///Guardar catalogo de paises de origen y procedencia para tránsito internacionl
  ///
  Future guardarPaisesOrigenProcedencia(
      PaisesOrigenProcedenciaModelo paises) async {
    final db = await database.dataBase;

    final res = await db!.rawInsert(
        "INSERT Into paises_origen_procedencia (id_localizacion,nombre) values (?,?)",
        [
          paises.idLocalizacion,
          paises.nombre,
        ]);
    return res;
  }

  ///
  ///Guardar catalogo de productos para tránsito internacionl
  ///
  Future guardarProductosTransito(ProductosTransitoModelo productos) async {
    final db = await database.dataBase;

    // final res = await db!.rawInsert(
    //     "INSERT Into productos_transito (partida_arancelaria,nombre,subtipo) values (?,?,?)",
    //     [
    //       productos.partidaArancelaria,
    //       productos.nombre,
    //       productos.subtipo,
    //     ]);

    final res = await db!.insert('productos_transito', productos.toJson());
    return res;
  }

  // Selects

  ///
  ///Obtener el catálogo de paises para origen y procedencia de tránsito internacional
  ///
  Future<List<PaisesOrigenProcedenciaModelo>>
      getPaisesOrigenProcedencia() async {
    final db = await database.dataBase;

    final res = await db!.query('paises_origen_procedencia');

    List<PaisesOrigenProcedenciaModelo> lista = res.isNotEmpty
        ? res.map((e) => PaisesOrigenProcedenciaModelo.fromJson(e)).toList()
        : [];
    return lista;
  }

  ///
  ///Obtener el pais[PaisesOrigenProcedenciaModelo] para origen y procedencia de tránsito internacional
  ///
  Future<PaisesOrigenProcedenciaModelo> getPaisOrigenProcedencia(
      String nombre) async {
    final db = await database.dataBase;

    final res = await db!.query('paises_origen_procedencia',
        where: 'nombre=?', whereArgs: [nombre]);

    return PaisesOrigenProcedenciaModelo.fromJson(res.first);
  }

  ///
  ///Obtener el catálogo de productos para tránsito internacional
  ///
  Future<List<ProductosTransitoModelo>> getProductosTransito() async {
    final db = await database.dataBase;

    final res = await db!.query('productos_transito');

    List<ProductosTransitoModelo> lista = res.isNotEmpty
        ? res.map((e) => ProductosTransitoModelo.fromJson(e)).toList()
        : [];
    return lista;
  }

  //Deletes

  ///
  ///Eliminar todos los registros del catálogo de paises par origen y procedencia de tránsito internacional
  ///
  Future eliminarPaisesOrigenProcedencia() async {
    final db = await database.dataBase;

    final res = await db!.delete('paises_origen_procedencia');
    return res;
  }

  ///
  ///Eliminar todos los registros del catálogo de productos para transito internacional
  ///
  Future eliminarProductosTransito() async {
    final db = await database.dataBase;

    final res = await db!.delete('productos_transito');
    return res;
  }
}
