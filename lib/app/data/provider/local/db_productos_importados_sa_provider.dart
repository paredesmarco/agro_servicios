import 'package:agro_servicios/app/data/models/productos_importados/inspeccion_productos_importados_modelo.dart';
import 'package:agro_servicios/app/data/models/productos_importados/producto_importado_lote_modelo.dart';
import 'package:agro_servicios/app/data/models/productos_importados/productos_importados_orden_modelo.dart';
import 'package:agro_servicios/app/data/models/productos_importados/solicitud_productos_importados_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_provider.dart';

class DBProductosImportadosSaProvider {
  var database = DBProvider.db;

  //Inserts

  ///Guardar las solicitudes de productos importados
  Future guardarSolicitudesProductosImportados(
      SolicitudProductosImportadosModelo solicitud) async {
    final db = await database.dataBase;

    final res = await db!
        .insert('solicitud_productos_importados_sa', solicitud.toJson());
    return res;
  }

  ///
  ///Guardar los productos de las solicitudes de productos importados
  ///
  Future guardarProductos(ProductoImportadoModelo producto) async {
    final db = await database.dataBase;

    final res = await db!.insert(
        'productos_solictud_productos_importados_sa', producto.toJson());
    return res;
  }

  ///Guardar la inspeccion
  Future guardarInspeccion(
      InspeccionProductosImportadosModelo inspeccion) async {
    final db = await database.dataBase;

    final res = await db!.insert('control_f01_sa', inspeccion.toMap());
    return res;
  }

  ///Guardar los lotes registrados en la inspección
  Future guardarInspeccionLote(ProductoImportadoLoteModelo lote) async {
    final db = await database.dataBase;
    final res = await db!.insert('control_f01_lote_sa', lote.toJson());
    return res;
  }

  ///Guardar las productos registrados en la inspección
  Future guardarInspeccionProductos(ProductoImportadoModelo producto) async {
    final db = await database.dataBase;

    final res = await db!.insert('control_f01_producto_sa', producto.toJson());

    return res;
  }

  ///Guardar las órdenes de laboratorio registradas en la inspección
  Future guardarInspeccionOrdenLaboratorio(
      ProductosImportadosOrdenModelo orden) async {
    final db = await database.dataBase;

    final res = await db!.insert('control_f01_orden_sa', orden.toJson());
    return res;
  }

  //Deletes

  ///
  ///Eliminar todos los registros de las solicitudes de productos importados
  ///
  Future eliminarLugarInspeccion() async {
    final db = await database.dataBase;

    final res = await db!.delete('solicitud_productos_importados_sa');
    return res;
  }

  ///
  ///Eliminar todos los productos de las solicitudes de productos importados
  ///
  Future eliminarProductos() async {
    final db = await database.dataBase;

    final res = await db!.delete('productos_solictud_productos_importados_sa');
    return res;
  }

  ///
  ///Eliminar todos los productos de las solicitudes de productos importados
  ///
  Future eliminarInspeccion() async {
    final db = await database.dataBase;

    final res = await db!.delete('control_f01_sa');
    return res;
  }

  ///
  ///Eliminar todos los productos de las solicitudes de productos importados
  ///
  Future eliminarInspeccionLotes() async {
    final db = await database.dataBase;

    final res = await db!.delete('control_f01_lote_sa');
    return res;
  }

  ///
  ///Eliminar todos los productos de las solicitudes de productos importados
  ///
  Future eliminarInspeccionProductos() async {
    final db = await database.dataBase;

    final res = await db!.delete('control_f01_producto_sa');
    return res;
  }

  ///
  ///Eliminar todos los productos de las solicitudes de productos importados
  ///
  Future eliminarInspeccionOrdenesLaboratorio() async {
    final db = await database.dataBase;

    final res = await db!.delete('control_f01_orden_sa');
    return res;
  }

  // Selects

  ///
  ///Obtener todas las solicitudes de productos importados sincronizadas
  ///
  Future<List<SolicitudProductosImportadosModelo>>
      getSolicitudesProductosImportados() async {
    final db = await database.dataBase;

    final res = await db!.query('solicitud_productos_importados_sa');

    List<SolicitudProductosImportadosModelo> lista = res.isNotEmpty
        ? res
            .map((e) => SolicitudProductosImportadosModelo.fromJson(e))
            .toList()
        : [];
    return lista;
  }

  ///
  ///Obtener todas los productos de las solicitudes de productos importados sincronizadas
  ///
  Future<List<ProductoImportadoModelo>> getProductosSolicitudes() async {
    final db = await database.dataBase;

    final res = await db!.query('productos_solictud_productos_importados_sa');

    List<ProductoImportadoModelo> lista = res.isNotEmpty
        ? res.map((e) => ProductoImportadoModelo.fromJson(e)).toList()
        : [];
    return lista;
  }

  ///
  ///Obtener todas los inspecciones almacenadas
  ///
  Future<List<InspeccionProductosImportadosModelo>> getInspecciones() async {
    final db = await database.dataBase;

    final res = await db!.query('control_f01_sa');

    List<InspeccionProductosImportadosModelo> lista = res.isNotEmpty
        ? res
            .map((e) => InspeccionProductosImportadosModelo.fromJson(e))
            .toList()
        : [];
    return lista;
  }

  ///
  ///Obtener todas los lotes de inspecciones almacenadas
  ///
  Future<List<ProductoImportadoLoteModelo>> getInspeccionesLotes() async {
    final db = await database.dataBase;

    final res = await db!.query('control_f01_lote_sa');

    List<ProductoImportadoLoteModelo> lista = res.isNotEmpty
        ? res.map((e) => ProductoImportadoLoteModelo.fromJson(e)).toList()
        : [];
    return lista;
  }

  ///
  ///Obtener todas los productos de inspecciones almacenados
  ///
  Future<List<ProductoImportadoModelo>> getInspeccionesProductos() async {
    final db = await database.dataBase;

    final res = await db!.query('control_f01_producto_sa');

    List<ProductoImportadoModelo> lista = res.isNotEmpty
        ? res.map((e) => ProductoImportadoModelo.fromJson(e)).toList()
        : [];
    return lista;
  }

  ///
  ///Obtener todas las órdenes de laboratorio de inspecciones almacenados
  ///
  Future<List<ProductosImportadosOrdenModelo>>
      getInspeccionesOrdenesLaboratorio() async {
    final db = await database.dataBase;

    final res = await db!.query('control_f01_orden_sa');

    List<ProductosImportadosOrdenModelo> lista = res.isNotEmpty
        ? res.map((e) => ProductosImportadosOrdenModelo.fromJson(e)).toList()
        : [];
    return lista;
  }

  ///
  ///Obtener la cantidad de inspecciones realizadas.
  ///
  Future<int> getCantidadInspeccioneso() async {
    final db = await database.dataBase;

    final res = await db!.query('control_f01_sa');

    int cantidad = res.isNotEmpty ? res.length : 0;

    return cantidad;
  }

  Future<InspeccionProductosImportadosModelo?> getVerificaionDDALlenado(
      String dda) async {
    final db = await database.dataBase;

    final res = await db!.query(
      'control_f01_sa',
      where: 'dda =?',
      whereArgs: [dda],
    );

    return res.isNotEmpty
        ? InspeccionProductosImportadosModelo.fromJson(res.first)
        : null;
  }
}
