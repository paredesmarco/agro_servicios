import 'package:agro_servicios/app/data/models/productos_importados/producto_importado_lote_modelo.dart';
import 'package:agro_servicios/app/data/models/productos_importados/productos_importados_orden_modelo.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/data/provider/local/db_productos_importados_sv_provider.dart';
import 'package:agro_servicios/app/data/models/productos_importados/solicitud_productos_importados_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/puertos_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_uath_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/productos_importados_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/productos_importados/inspeccion_productos_importados_modelo.dart';

class ProductosImportadosSvRepository {
  final _loginProvider = Get.find<LoginProvider>();
  final _productosImportadosProvider = Get.find<ProductosImportadosProvider>();
  final _dbHomeProvider = Get.find<DBHomeProvider>();
  final _dbUathProvider = Get.find<DBUathProvider>();
  final _dbProductosImportadosProvider =
      Get.find<DBProductosImportadosSvProvider>();
  final _dbLocalizacion = Get.find<DBLocalizacionProvider>();

  // Servicios web

  /// Obtiene los DDA en estado inspección desde el Sistema GUIA
  ///
  ///Devuelve una lista del tipo [PuertosCatalogoModelo]
  ///
  ///El [tipoCertificado] puede ser 'VEGETAL' o 'ANIMAL'
  Future<List<SolicitudProductosImportadosModelo>> getProductosImportados(
      String identificador, String tipoCertificado) async {
    final res = await _productosImportadosProvider.obtenerProductosImportados(
        identificador, tipoCertificado, _loginProvider.obtenerToken());
    return res;
  }

  ///Sicroniza al Sistema GUIA los registros de inspeccion de productos importados
  Future sincronizarUp(Map<String, dynamic> embalaje) async =>
      await _productosImportadosProvider.sincronizarUp(
          embalaje, _loginProvider.obtenerToken());

  // Locales

  /**
   * Selects
   */

  /// Obtiene el usuario logueado en la aplicación
  ///
  ///Devuelve un objeto[UsuarioModelo]
  Future<UsuarioModelo?> getUsuario() async =>
      await _dbHomeProvider.getUsuario();

  /// Obtiene la provincia del contrato el usuario logueado en la aplicación
  ///
  ///Devuelve un objeto[ProvinciaUsuarioContratoModelo]
  Future<ProvinciaUsuarioContratoModelo?> getProvinciaContrato() async =>
      await _dbUathProvider.getProvinciaContrato();

  ///Obtener todas las solicitudes de productos importados sincronizadas
  ///
  ///Devuelve una lista de tipo [SolicitudProductosImportadosModelo]
  Future<List<SolicitudProductosImportadosModelo>>
      getSolicitudesProductosImportados() async =>
          await _dbProductosImportadosProvider
              .getSolicitudesProductosImportados();

  ///Obtener todas los productos de las solicitudes de productos importados sincronizadas
  ///
  ///Devuelve una lista de tipo [ProductoImportadoModelo]
  Future<List<ProductoImportadoModelo>> getProductosSolicitudes() async =>
      await _dbProductosImportadosProvider.getProductosSolicitudes();

  ///Obtener todas las provincias
  ///
  ///Devuelve una lista de tipo [LocalizacionModelo]
  Future<List<LocalizacionModelo>> getProvincias() async =>
      await _dbLocalizacion.getLocalizacionPorCategoria(1);

  ///Obtener provincia por ID
  ///
  ///Devuelve una lista de tipo [LocalizacionModelo]
  Future<LocalizacionModelo?> getProvinciaPorId(int provincia) async =>
      await _dbLocalizacion.getLocalizacionPorId(provincia);

  ///Obtener todas las inspecciones registradas
  ///
  ///Devuelve una lista de tipo [InspeccionProductosImportadosModelo]
  Future<List<InspeccionProductosImportadosModelo?>> getInspecciones() async =>
      await _dbProductosImportadosProvider.getInspecciones();

  ///Obtener todos los lotes regitrados en las inspecciones
  ///
  ///Devuelve una lista de tipo [ProductoImportadoLoteModelo]
  Future<List<ProductoImportadoLoteModelo?>> getInspeccionesLotes() async =>
      await _dbProductosImportadosProvider.getInspeccionesLotes();

  ///Obtener todos las ordenes de laboratorio regitradas en las inspecciones
  ///
  ///Devuelve una lista de tipo [ProductosImportadosOrdenModelo]
  Future<List<ProductosImportadosOrdenModelo?>>
      getInspeccionesOrdenesLaboratorio() async =>
          await _dbProductosImportadosProvider
              .getInspeccionesOrdenesLaboratorio();

  ///Obtener todos las productos inspeccionados
  ///
  ///Devuelve una lista de tipo [ProductoImportadoModelo]
  Future<List<ProductoImportadoModelo?>> getInspeccionesProductos() async =>
      await _dbProductosImportadosProvider.getInspeccionesProductos();

  ///Obtener la cantidad de los registros en la tabla de inspecciones
  ///
  ///Devuelve un [int]
  Future<int> getCantidadInspecciones() async =>
      await _dbProductosImportadosProvider.getCantidadInspeccioneso();

  ///Verificar si el DDA ya fue inspeccionado
  ///
  ///Devuelve un objeto[InspeccionProductosImportadosModelo]
  Future<InspeccionProductosImportadosModelo?> getVerificaionDDALlenado(
          String dda) async =>
      await _dbProductosImportadosProvider.getVerificaionDDALlenado(dda);

  /**
   * Inserts
   */

  /// Guardar las solicitudes de documentos de destinación aduanera
  Future<int> guardarSolictudProductosImportados(
          SolicitudProductosImportadosModelo solicitud) async =>
      await _dbProductosImportadosProvider
          .guardarSolicitudesProductosImportados(solicitud);

  /// Guardar las solicitudes de documentos de destinación aduanera
  Future<int> guardarProductosSolictudProductosImportados(
          ProductoImportadoModelo producto) async =>
      await _dbProductosImportadosProvider.guardarProductos(producto);

  /// Guardar las solicitudes de documentos de destinación aduanera
  Future<int> guardarInspeccion(
          InspeccionProductosImportadosModelo producto) async =>
      await _dbProductosImportadosProvider.guardarInspeccion(producto);

  /// Guardar las solicitudes de documentos de destinación aduanera
  Future<int> guardarInspeccionLote(ProductoImportadoLoteModelo lote) async =>
      await _dbProductosImportadosProvider.guardarInspeccionLote(lote);

  /// Guardar las solicitudes de documentos de destinación aduanera
  Future<int> guardarInspeccionProductos(
          ProductoImportadoModelo producto) async =>
      await _dbProductosImportadosProvider.guardarInspeccionProductos(producto);

  /// Guardar las solicitudes de documentos de destinación aduanera
  Future<int> guardarInspeccionOrdenLaboratorio(
          ProductosImportadosOrdenModelo orden) async =>
      await _dbProductosImportadosProvider
          .guardarInspeccionOrdenLaboratorio(orden);

  /**
   * Deletes
   */

  /// Eliminar todos los registros de las solicitudes de productos importados
  Future<int> eliminarSolictudProductosImportados() async =>
      await _dbProductosImportadosProvider.eliminarLugarInspeccion();

  /// Eliminar todos los productos de las solicitudes de productos importados
  Future<int> eliminarProductosSolicitudes() async =>
      await _dbProductosImportadosProvider.eliminarProductos();

  /// Eliminar todas las inspecciones registradas en campo
  Future<int> eliminarInspeccionLotes() async =>
      await _dbProductosImportadosProvider.eliminarInspeccionLotes();

  /// Eliminar todos los lotes de las inspecciones registradas en campo
  Future<int> eliminarInspeccion() async =>
      await _dbProductosImportadosProvider.eliminarInspeccion();

  /// Eliminar todas las productos de las inspecciones realizadas en campo
  Future<int> eliminarInspeccionProductos() async =>
      await _dbProductosImportadosProvider.eliminarInspeccionProductos();

  /// Eliminar todas las órdenes de laboratorio de las inspecciones realizadas en campo
  Future<int> eliminarInspeccionOrdenesLaboratorio() async =>
      await _dbProductosImportadosProvider
          .eliminarInspeccionOrdenesLaboratorio();
}
