import 'package:get/get.dart';

import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/seguimiento_cuarentenario_sv_provider.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_solicitud_sv_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_seguimiento_cuarentenario_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_uath_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_laboratorio_sv_modelo.dart';

class SeguimientoCuarentenarioSvRepository {
  final _loginRepository = Get.find<LoginProvider>();
  final _seguimientoProvider = Get.find<SeguimientoCuarentenarioSvProvider>();

  final _dbSeguimientoProvider = Get.find<DBSeguimientoCuarentenarioProvider>();

  final LocalizacionProvider _localizacionProvider =
      Get.find<LocalizacionProvider>();

  final DBLocalizacionProvider _dbProviderLocalizacion =
      Get.find<DBLocalizacionProvider>();

  final LoginProvider _loginProvider = Get.find<LoginProvider>();

  final DBLocalizacionProvider _dbLocalizacionProvider =
      Get.find<DBLocalizacionProvider>();

  final DBHomeProvider _dbHome = Get.find<DBHomeProvider>();

  final _dbUathProvider = Get.find<DBUathProvider>();

  // Servicios web

  ///
  ///Ontiene todas las solicitudes se seguimiento cuarentenario de SV a nivel nacional desde el Sistema GUIA
  ///
  Future getSolicitudesSeguimientoCuarentenario() async =>
      await _seguimientoProvider
          .obtenerSeguimientoCuarentnarioSv(_loginRepository.obtenerToken());

  ///Retorna el catálogo de localización por provización del servicio web
  ///
  ///Dato de retorno List[LocalizacionCatalogo]
  Future<List<LocalizacionCatalogo>> getCatalogoLocalizacion(
          int? localizacion) async =>
      await _localizacionProvider.obtenerCatalogoLocalizacion(
          localizacion, _loginProvider.obtenerToken());

  ///Sicroniza al Sistema GUIA los registros de seguimientos cuarentenarios
  Future sincronizarUp(Map<String, dynamic> embalaje) async =>
      await _seguimientoProvider.sincronizarUp(
          embalaje, _loginProvider.obtenerToken());

  // Locales

  /**
   * Inserts
   */

  ///Guarda solicitud de seguimiento cuarentenario sv en db local
  ///
  ///devuelve el id[int] del registro ingresado
  Future<int> guardarSolicitudesSeguimientoCuarentenario(
          SeguimientoCuarentenarioSolicitudSvModelo solicitud) async =>
      await _dbSeguimientoProvider.guardarSolicitudes(solicitud);

  ///Guarda los productos de la solicitud de seguimiento cuarentenario sv en db local
  ///
  ///devuelve el id[int] del registro ingresado
  Future<int> guardarSolicitudesProductoSeguimientoCuarentenario(
          SeguimientoCuarentenarioProductoSvModelo producto) async =>
      await _dbSeguimientoProvider.guardarProductoSolicitud(producto);

  ///Guarda las áreas de seguimiento cuarentenario
  ///
  ///devuelve el id[int] del registro ingresado
  Future<int> guardarSolicitudesAreasCuarentenaSeguimientoCuarentenario(
          SeguimientoCuarentenarioAreaCuarentenaSvModelo area) async =>
      await _dbSeguimientoProvider.guardarAreaSolicitud(area);

  ///Guarda el catálogo (cantones y parroquias) de una provincia.
  guardarLocalizacionCatalogo(LocalizacionCatalogo localizacion) async {
    await _dbProviderLocalizacion.guardarLocalizacionCatalogo(localizacion);
  }

  ///Guarda la inspección realizada en campo en el dispositvo localmente
  ///
  ///Retorna el id del registro[int]
  Future<int> guardarInspeccionSeguiminetoCuarentenario(
          SeguimientoCuarentenarioSvModelo inspeccion) async =>
      await _dbSeguimientoProvider
          .guardarInspeccionSeguimientoCuarentenario(inspeccion);

  ///Guarda las ordenes de laboratorio de la inspección realizada en campo en el dispositvo localmente
  Future<int> guardarInspeccionSeguiminetoCuarentenarioProducto(
          SeguimientoCuarentenarioLaboratorioSvModelo inspeccion) async =>
      await _dbSeguimientoProvider
          .guardarInspeccionSeguimientoCuarentenarioProducto(inspeccion);

  /*
   * Deletes
   */

  ///
  ///Elimina todas las solicitudes de seguimiento cuarentenario sv de db local
  ///
  Future<int> eliminarSolicitudes() async =>
      await _dbSeguimientoProvider.eliminarSolicitudes();

  ///
  ///Elimina todos los productos de las solicitudes de seguimiento cuarentenario sv de db local
  ///
  Future<int> eliminarSolicitudeProductos() async =>
      await _dbSeguimientoProvider.eliminarSolicitudProductos();

  ///
  ///Elimina todas las áreas de cuarentena de las solicitudes de seguimiento cuarentenario sv de db local
  ///
  Future<int> eliminarSolicitudAreasCuarentena() async =>
      await _dbSeguimientoProvider.eliminarSolicitudAreasCuarentena();

  ///
  ///Elimina todos los registros de las inspecciones de seguimiento cuarentenario sv realizadas en campo de db local
  ///
  Future<int> eliminarInspeccionesSeguimientos() async =>
      await _dbSeguimientoProvider.eliminarInspeccionesSeguimientos();

  ///
  ///Elimina todos los productos de las inspecciones de seguimiento cuarentenario sv realizadas en campo de db local
  ///
  Future<int> eliminarInspeccionesLaboratorio() async =>
      await _dbSeguimientoProvider.eliminarInspeccionesLaboratorio();

  /*
   * Selects
   */

  ///
  ///Obtener solicitudes de seguimineto cuarentenario sincronizadas en bd local
  ///
  Future<List<SeguimientoCuarentenarioSolicitudSvModelo>>
      getSolicitudesSincronizadas() async =>
          await _dbSeguimientoProvider.obtenerSolicitudesSincronizadas();

  ///
  ///Obtener los productos de las solicitudes de seguimineto cuarentenario sincronizadas en bd local
  ///
  Future<List<SeguimientoCuarentenarioProductoSvModelo>>
      getSolicitudesProductosSincronizados() async =>
          await _dbSeguimientoProvider
              .obtenerSolicitudesProductosSincronizados();

  ///
  ///Obtener los áreas de cuarentena de las solicitudes de seguimineto cuarentenario sincronizadas en bd local
  ///
  Future<List<SeguimientoCuarentenarioAreaCuarentenaSvModelo>>
      getSolicitudesAreasCuarentenaSincronizados(String identificador) async =>
          await _dbSeguimientoProvider
              .getSolicitudesAreasCuarentenaSincronizados(identificador);

  ///
  ///Obtener el área de cuarentena de las solicitudes de seguimineto cuarentenario sincronizadas en bd local por el identificador[String] del usuario
  ///
  Future<SeguimientoCuarentenarioAreaCuarentenaSvModelo?>
      getSolicitudeAreasCuarentenaPorId(int id) async =>
          await _dbSeguimientoProvider.getSolicitudeAreasCuarentenaPorId(id);

  ///
  ///Obtener localizaciones por categoría sincronizadas en bd local
  ///
  Future<List<LocalizacionModelo>> getLocalizacionPorCategoria(
          int categoria) async =>
      await _dbLocalizacionProvider.getLocalizacionPorCategoria(categoria);

  ///
  ///Obtener localizaciones por el idPadre sincronizadas en bd local
  ///
  Future<List<LocalizacionModelo>> getLocalizacionPorIdPadre(
          int idPadre) async =>
      await _dbLocalizacionProvider.getLocalizacionPorPadre(idPadre);

  ///Obtener localizaciones por el id sincronizadas en bd local
  ///
  ///Retorna un objeto [LocalizacionModelo]
  Future<LocalizacionModelo?> getLocalizacionPorId(int id) async =>
      await _dbLocalizacionProvider.getLocalizacionPorId(id);

  /// Obtener la provincia del contrato activo del usuario
  ///
  /// Retorna una lista del objeto [ProvinciaUsuarioContratoModelo]
  Future<ProvinciaUsuarioContratoModelo?> getProvinciaContrato() async =>
      await _dbUathProvider.getProvinciaContrato();

  /// Obtener la provincia del contrato activo del usuario
  ///
  /// Retorna una lista del objeto [UsuarioModelo]
  Future<UsuarioModelo?> getUsuario() async => await _dbHome.getUsuario();

  /// Obtener las ordenes de laboratio guardadas localmente
  ///
  /// Retorna una lista del objeto [SeguimientoCuarentenarioLaboratorioSvModelo]
  Future<List<SeguimientoCuarentenarioLaboratorioSvModelo>>
      getMuestraLaboratio() async =>
          await _dbSeguimientoProvider.obtenerMuestrasLaboratorio();

  /// Obtener los registros de seguimientos cuarentenarios realizados en campo
  ///
  /// Retorna una lista del objeto [SeguimientoCuarentenarioSvModelo]
  Future<List<SeguimientoCuarentenarioSvModelo>>
      getRegistrosSeguimientos() async =>
          await _dbSeguimientoProvider.obtenerRegistrosSeguimientos();

  /// Retorna la cantidad[int] de registros realizados en campo para seguimiento cuarentenario
  Future getCantidadRegistrosSeguimientos() async =>
      await _dbSeguimientoProvider.obtenerCantidadRegistrosSeguimiento();

  /// Retorna el id secuencial[int]+1 de la tabla control_f04
  Future getSecuencialRegistrosSeguimientos() async =>
      await _dbSeguimientoProvider.obtenerSecuenciaSeguimiento();
}
