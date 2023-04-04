import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_detalle_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_laboratorio_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_padre_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_trampeo_mf_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/trampeo_mf_sv_provider.dart';
import 'package:get/get.dart';

class TrampeoMfSvRepository {
  final TrampeoMfSvProvider _trampeoProvider = Get.find<TrampeoMfSvProvider>();
  final DBTrampeoMfSvProvider _bdProvider = Get.find<DBTrampeoMfSvProvider>();
  final LoginProvider _loginProvider = Get.find<LoginProvider>();

  getTodasProvincias() => _trampeoProvider.obtenerTodasProvincia();

  /// Retorna trampas desde el Sistema GUIA
  ///
  /// Dato de retorno List[TrampasMfSvModelo]
  Future<List<TrampasMfSvModelo>> getTrampas(String localizacion) async =>
      await _trampeoProvider.obtenerTrampasMosca(
          localizacion, _loginProvider.obtenerToken());

  ///Retorna el total de registros de trampeo
  ///
  ///Dato de retorno int
  Future getCantidadTrampas() async =>
      await _bdProvider.getCantidadTrampasCompletadas();

  /// Limpia todas las trampas de Mosca de la Fruta
  Future limpiarTrampas() async => await _bdProvider.limpiarTrampas();

  /// Guarda trampa de Mosca de la Fruta
  Future guardarTrampas(TrampasMfSvModelo trampa) async =>
      await _bdProvider.guardarNuevaTrampa(trampa);

  /// Retorna las provincias de donde se sincronizaron las trampas de mosca.
  ///
  /// Tipo de dato de retorno List< LocalizacionModelo >
  Future<List<LocalizacionModelo?>> getTodasProvinciasSincronizadas() async =>
      await _bdProvider.getProvinciasSincronizadas();

  /// Retorna los cantones de donde se sincronizaron las trampas de mosca por provincia
  ///
  /// Dato de retorno List< LocalizacionModelo >
  Future<List<LocalizacionModelo?>> getCantonPorProvincia(
          int provincia) async =>
      await _bdProvider.getCantonesPorProvincia(provincia);

  /// Retorna los lugares de instalacion de la trampa
  ///
  /// Dato de retorno List< TrampasMfSvModelo >
  Future<List<TrampasMfSvModelo>> getLugarInstalacion(int canton) async =>
      await _bdProvider.getLugarInstalacion(canton);

  /// Retorna el nombre del lugar de instalación
  ///
  /// Dato de retorno TrampasMfSvModelo
  Future<TrampasMfSvModelo?> getNombreLugarInstalacion(
          int canton, int lugarInstalacion) async =>
      await _bdProvider.getNombreInstalacion(canton, lugarInstalacion);

  /// Retorna el número del lugar de instalación
  ///
  /// Dato de retorno List< TrampasMfSvModelo >
  Future<List<TrampasMfSvModelo>> getNumeroLugarInstalacion(
          int canton, int lugarInstalacion) async =>
      await _bdProvider.getNumeroLugarIsntalacion(canton, lugarInstalacion);

  /// Retorna las parroquias de instalación
  ///
  /// Dato de retorno List< LocalizacionModelo >
  Future<List<LocalizacionModelo>> getParroquiaInstalacion(
          int canton, int lugarInstalacion) async =>
      await _bdProvider.getParroquias(canton, lugarInstalacion);

  /// Retorna las trampas filtradas por número de instalación
  ///
  /// Dato de retorno List< TrampasMfSvModelo >
  Future<List<TrampasMfSvModelo>> getTrampasPorNumero(
          int canton, int lugarInstalacion, int numero) async =>
      await _bdProvider.getTrampasPorNumero(canton, lugarInstalacion, numero);

  /// Retorna las trampas filtradas por parroquias
  ///
  /// Dato de retorno List< TrampasMfSvModelo >
  Future<List<TrampasMfSvModelo>> getTrampasPorParroquia(
          int canton, int lugarInstalacion, int parroquia) async =>
      await _bdProvider.getTrampasPorParroquia(
          canton, lugarInstalacion, parroquia);

  /// Retorna las trampas filtradas por parroquias
  ///
  /// Dato de retorno List< TrampasMfSvModelo >
  getSecuencialOrden(String codigoTrampa) async =>
      await _bdProvider.getSecuencialOrden(codigoTrampa);

  /// Retorna todos las cabeceras de los detalles de las trampas realizadas
  ///
  /// Dato de retorno List< TrampasMfSvPadreModelo >
  Future<List<TrampasMfSvPadreModelo>> getDetalleTrampasPadreTodos() async =>
      await _bdProvider.getDetallesTrampasPadre();

  /// Retorna todos los detalles de las trampas completadas
  ///
  /// Dato de retorno List< TrampasMfSvDetalleModelo >
  Future<List<TrampasMfSvDetalleModelo>> getDetallesTrampasTodos() async =>
      await _bdProvider.getDetallesTrampas();

  /// Retorna todos las ordenes de muestra de laboratorio ingresadas
  ///
  /// Dato de retorno List< TrampasMfSvLaboratorioModelo >
  Future<List<TrampasMfSvLaboratorioModelo>>
      getOrdenesLaboratorioTodos() async => await _bdProvider.getOrdenesTodas();

  /**
    * INSERTS 
    */

  /// Guarda trampeo padre localmente
  guardarTrampasPadre(TrampasMfSvPadreModelo inspeccionPadre) async =>
      await _bdProvider.guardarInspeccionPadre(inspeccionPadre);

  /// Guarda el detalle de las trampas localmente
  guardarDetalleTrampas(TrampasMfSvDetalleModelo trampaDetalle) async =>
      await _bdProvider.guardarDetalleTrampa(trampaDetalle);

  /// Guarda las ordenes de laboratorio localmente
  guardarOrdenes(TrampasMfSvLaboratorioModelo ordenLaboratorio) async =>
      await _bdProvider.guardarMuestralaboratorio(ordenLaboratorio);

  /// Actualiza el estado de
  updateTrampaCompletada(int condicion, String codigoTrampa) async =>
      await _bdProvider.updateTrampaCompletada(condicion, codigoTrampa);

  ///sicroniza los trampeos realizados al Ssitema Guia con cabecera y detalle
  sincronizarUp(Map<String, dynamic> trampeo) async {
    return await _trampeoProvider.sincronizarUp(
        trampeo, _loginProvider.obtenerToken());
  }

  /**
  * Deletes
  */

  ///Eliminar todas los registros de cabecera por cada inspeccion realizada
  eliminarTrampasInspeccionPadre() async {
    await _bdProvider.eliminarTrampasInspeccionPadre();
  }

  ///Eliminar todas los detalles de las trampas realizados
  eliminarTrampasDetalle() async {
    await _bdProvider.eliminarTrampasDetalle();
  }

  ///Eliminar todaos las ordenes de laboratorio
  eliminarOrdenesLaboratorio() async {
    await _bdProvider.eliminarOrdenesLaboratorio();
  }

  ///Eliminar todas las trampas sincronizadas
  eliminarTrampasSincronizadas() async {
    await _bdProvider.eliminarTrampasSincronizadas();
  }
}
