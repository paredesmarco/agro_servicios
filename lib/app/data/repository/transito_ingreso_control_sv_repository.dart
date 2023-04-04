import 'package:get/get.dart';

import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_ingreso_control_sv/transito_ingreso_producto_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_ingreso_control_sv/transito_ingreso_sv_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_puertos_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_requisitos_transito_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_transito_ingreso_control_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/transito_ingreso_control_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_tipos_envase.dart';
import 'package:agro_servicios/app/data/models/catalogos/envases_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/paises_origen_procedencia_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/productos_transito_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/puertos_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/provider/ws/localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/puertos_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/requisitos_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';

class TransitoIngresoControlSvRepository {
  final _ingresoProvider = Get.find<TransitoIngresoControlSvProvider>();
  final _loginProvider = Get.find<LoginProvider>();
  final _localizacionProvider = Get.find<LocalizacionProvider>();
  final _puertosProvider = Get.find<PuertosProvider>();
  final _requisitosProvider = Get.find<RequisitosProvider>();
  final _dbTiposEnvaseProvider = Get.find<DBTiposEnvaseProvider>();
  final _dbPuertosProvider = Get.find<DBPuertosProvider>();
  final _dbRequisitosProvider = Get.find<DBRequistosTransitoProvider>();
  final _dbLocalizacionProvider = Get.find<DBLocalizacionProvider>();
  final _dbHomeProvider = Get.find<DBHomeProvider>();
  final _dbTransitoIngreso = Get.find<DBTransitoIngresoControlSvProvider>();

  // Servicios Web

  /// Obtener el catálogo de envases para productos de tránsito internacional
  /// por código categoría de área [categoria]
  ///
  /// Retorna una lista del objeto [EnvaseModelo]
  Future<List<EnvaseModelo>> getCatalogoEnvases(String categoria) async =>
      await _ingresoProvider.obtenerCatalogoEnvases(
          categoria, _loginProvider.obtenerToken());

  /// Obtener la lista de países dese el Sistema GUIA
  ///
  /// Retorna una lista del objeto [LocalizacionCatalogo]
  Future<List<LocalizacionCatalogo>> getPaises() async =>
      await _localizacionProvider.obtenerLocalizacionPorcategoria(
          0, _loginProvider.obtenerToken());

  /// Obtener el catálogo de los puertos de carga de ingreso y salida desde el Sistema GUIA
  /// por código categoría de área [categoria]
  ///
  /// Retorna una lista del objeto [PuertosCatalogoModelo]
  Future<List<PuertosCatalogoModelo>> getPuertos() async =>
      await _puertosProvider
          .obtenerCatalogoPuertos(_loginProvider.obtenerToken());

  /// Obtener el catálogo de los puertos de carga de ingreso y salida desde el Sistema GUIA
  /// por código categoría de área [categoria]
  ///
  /// Retorna una lista del objeto [PaisesOrigenProcedenciaModelo]
  Future<List<PaisesOrigenProcedenciaModelo>>
      getPaisesOrigenProcedenciaTransito(String categoria) async =>
          await _requisitosProvider
              .obtenerCatalogoPaisOrigenProcedenciaTransito(
                  categoria, _loginProvider.obtenerToken());

  /// Obtener el catálogo de los puertos de carga de ingreso y salida desde el Sistema GUIA
  /// por código categoría de área [categoria]
  ///
  /// Retorna una lista del objeto [ProductosTransitoModelo]
  Future<List<ProductosTransitoModelo>> getProductosTransito(
          String categoria) async =>
      await _requisitosProvider.obtenerProductosTransito(
          categoria, _loginProvider.obtenerToken());

  ///sicroniza al Sistema GUIA los registros de inspección de embalaje de madera
  Future sincronizarUp(Map<String, dynamic> registrosIngreso) async =>
      await _ingresoProvider.sincronizarUp(
          registrosIngreso, _loginProvider.obtenerToken());

  //Locales

  /*
   * Inserts
   */

  ///
  /// Recibe un objeto [EnvaseModelo] para ser almacenado en DB local
  ///
  Future<void> guardarEnvase(EnvaseModelo envase) async =>
      await _dbTiposEnvaseProvider.guardarEnvase(envase);

  ///
  /// Recibe un objeto [LocalizacionCatalogo] para ser almacenado en DB local
  ///
  Future<void> guardarPais(LocalizacionCatalogo localizacion) async =>
      await _dbLocalizacionProvider.guardarLocalizacionCatalogo(localizacion);

  ///
  /// Recibe un objeto [PuertosCatalogoModelo] para ser almacenado en DB local
  ///
  Future<void> guardarPuerto(PuertosCatalogoModelo puertos) async =>
      await _dbPuertosProvider.guardarPuertos(puertos);

  ///
  /// Recibe un objeto [PaisesOrigenProcedenciaModelo] para ser almacenado en DB local
  ///
  Future<void> guardarPaisOrigenrocedencia(
          PaisesOrigenProcedenciaModelo pais) async =>
      await _dbRequisitosProvider.guardarPaisesOrigenProcedencia(pais);

  ///
  /// Recibe un objeto [ProductosTransitoModelo] para ser almacenado en DB local
  ///
  Future<void> guardarProductoTransito(
          ProductosTransitoModelo producto) async =>
      await _dbRequisitosProvider.guardarProductosTransito(producto);

  ///
  /// Guarda los registros de Verificación de tránsito de ingreso
  ///
  Future guardarVerificacionIngreso(TransitoIngresoSvModelo registros) async =>
      await _dbTransitoIngreso.guardarVerificacionIngreso(registros);

  ///
  /// Guarda los registros de Verificación de tránsito de ingreso
  ///
  Future guardarVerificacionIngresoProducto(
          TransitoIngresoProductoSvModelo registros) async =>
      await _dbTransitoIngreso.guardarVerificacionIngresoProducto(registros);

  /*
  * Selects
  */

  ///Obtener los productos para tránsito internacional
  ///
  ///Devuelve una lista del objeto [ProductosTransitoModelo]
  Future<List<ProductosTransitoModelo>> getProductoTransito() async =>
      await _dbRequisitosProvider.getProductosTransito();

  ///Obtener los tipos de envase para tránsito internacional
  ///
  ///Devuelve una lista del objeto [EnvaseModelo]
  Future<List<EnvaseModelo>> getEnvases() async =>
      await _dbTiposEnvaseProvider.getEnvases();

  ///Obtener los países de origen y procedencia para tránsito internacional
  ///
  ///Devuelve una lista del objeto [PaisesOrigenProcedenciaModelo]
  Future<List<PaisesOrigenProcedenciaModelo>>
      getCatalogoPaisOrigenProcedencia() async =>
          await _dbRequisitosProvider.getPaisesOrigenProcedencia();

  ///Obtener los países de origen y procedencia para tránsito internacional
  ///
  ///Devuelve una lista del objeto [PaisesOrigenProcedenciaModelo]
  Future<PaisesOrigenProcedenciaModelo> getPaisOrigenProcedencia(
          String nombre) async =>
      await _dbRequisitosProvider.getPaisOrigenProcedencia(nombre);

  ///Obtener catálogo de paises internacional
  ///
  ///Devuelve una lista del objeto [LocalizacionModelo]
  Future<List<LocalizacionModelo>> getPaisCatalogo(int categoria) async =>
      await _dbLocalizacionProvider.getLocalizacionPorCategoria(categoria);

  ///Obtener catálogo de paises internacional
  ///
  ///Devuelve una lista del objeto [LocalizacionModelo]
  Future<LocalizacionModelo?> getPaisporNombre(String nombre) async =>
      await _dbLocalizacionProvider.getLocalizacionPorNombre(nombre);

  //Obtener catálogo de puertos guardados localmente en BD
  ///
  ///Devuelve una lista del objeto [PuertosCatalogoModelo]
  Future<List<PuertosCatalogoModelo>> getPuertosSincronizados() async =>
      await _dbPuertosProvider.getCatalogoPuertos();

  //Obtener un puerto por el nombre guardados localmente en BD
  ///
  ///Devuelve un objeto [PuertosCatalogoModelo]
  Future<PuertosCatalogoModelo?> getPuertoPorNombre(String nombre) async =>
      await _dbPuertosProvider.getPuertoPorNombre(nombre);

  /// Obtener el usuario logueado
  ///
  /// Retorna una lista del objeto [LocalizacionModelo]
  Future<UsuarioModelo?> getsusuario() async =>
      await _dbHomeProvider.getUsuario();

  /// Reetorna la secuencia[int] de la tabla control_f02_ingreso
  /// donde se guardan los registros realizados ene l formulario de
  /// Verificación de tránsito (ingreso)
  Future<int> getSecuenciaIngreso() async =>
      await _dbTransitoIngreso.getSecuenciaTransitoIngreso();

  /// Reetorna la secuencia[int] de la tabla control_f02_ingreso
  /// donde se guardan los registros realizados ene l formulario de
  /// Verificación de tránsito (ingreso)
  Future<int> getSecuenciaProducto() async =>
      await _dbTransitoIngreso.getSecuenciaTransitoIngresoProducto();

  ///
  /// Obtener la cantidad de registros [int] realizados en campo en la tabla control_f03
  ///
  Future getCantidadRegistros() async =>
      await _dbTransitoIngreso.getCantidadVerificacionIngreso();

  ///
  /// Obtener todos los registros de verificacion de ingreso realizados en campo
  ///
  Future<List<TransitoIngresoSvModelo>>
      getRegistrosVerificacionIngreso() async =>
          await _dbTransitoIngreso.getRegistrosVerificacionIngreso();

  ///
  /// Obtener todos los registros de verificacion de ingreso realizados en campo
  ///
  Future<List<TransitoIngresoProductoSvModelo>>
      getRegistrosVerificacionIngresoProductos() async =>
          await _dbTransitoIngreso.getRegistrosVerificacionIngresoProductos();

  /*
   * Deletes
   */

  ///
  /// Elimina todos los registros de los tipos de envase para tránsito en DB local
  ///
  Future<void> eliminarEnvases() async =>
      await _dbTiposEnvaseProvider.eliminarEnvases();

  ///
  /// Elimina el catálogo de puertos para tránsito internacional en DB local
  ///
  Future<void> eliminarPuertos() async =>
      await _dbPuertosProvider.eliminarPuertos();

  ///
  /// Elimina el catálogo de puertos para tránsito internacional en DB local
  ///
  Future<void> eliminarPaisesOrigenProcedencia() async =>
      await _dbRequisitosProvider.eliminarPaisesOrigenProcedencia();

  ///
  /// Elimina el catálogo de los productos para tránsito internacional en DB local
  ///
  Future<void> eliminarProductosTransito() async =>
      await _dbRequisitosProvider.eliminarProductosTransito();

  /// Elimina los productos ingresados en campos en el formulario de
  ///
  /// Verificación de tránsito (ingreso) en la DB local
  Future<void> eliminarVerificacionTransitoIngresosProductos() async =>
      await _dbTransitoIngreso.eliminarRegistrosVerificacionProductos();

  /// Elimina todos los registros de ingreso realizados en campos en el formulario de
  ///
  /// Verificación de tránsito (ingreso) en la DB local
  Future<void> eliminarVerificacionTransitoIngresos() async =>
      await _dbTransitoIngreso.eliminarRegistrosVerificacionIngreso();
}
