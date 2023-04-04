import 'package:get/get.dart';

import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_salida_control_sv/registros_transito_ingreso_modelo.dart';
import 'package:agro_servicios/app/data/models/transito_salida_control_sv/verificacion_transito_salida_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_transito_salida_control_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_uath_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/transito_salida_control_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/uath_provider.dart';

class TransitoSalidaControlSvRepository {
  final _salidaProvider = Get.find<TransitoSalidaControlSvProvider>();
  final _loginProvider = Get.find<LoginProvider>();
  final _uathProvider = Get.find<UathProvider>();

  final _dbSalidaProvider = Get.find<DBTransitoSalidaControlSvProvider>();
  final _dbHomeProvider = Get.find<DBHomeProvider>();
  final _dbUathProvider = Get.find<DBUathProvider>();

  // Servicios Web

  /// Obtiene los registros de Verificación de tránsito de ingreso desde el Sistema GUIA
  ///
  /// Devuelve una lista de objetos [RegistrosTransitoIngresoModelo]
  Future<List<RegistrosTransitoIngresoModelo>> getRegistrosIngreso(
          String? provincia) async =>
      await _salidaProvider.obtenerRegistrosTransitoIngreso(
          _loginProvider.obtenerToken(), provincia);

  /// Sicroniza los registros de verificación de tránsito de salida hacia el Sistema GUIA
  Future sincronizarUp(Map<String, dynamic> verificacionSalida) async {
    return await _salidaProvider.sincronizarUp(
        verificacionSalida, _loginProvider.obtenerToken());
  }

  ///
  ///Obtiene la provincia donde esta creado el contrato del usuario en el Sistema GUIA
  ///
  Future<ProvinciaUsuarioContratoModelo> getUbicacionContrato(
          String identificador) async =>
      await _uathProvider.obtenerUbicacionContrato(
          identificador, _loginProvider.obtenerToken());

  // Local

  /**
   * Inserts
   */

  ///
  /// Guarda los registros de Verificación de tránsito de ingreso
  ///
  Future guardarRegistrosIngreso(
          RegistrosTransitoIngresoModelo registros) async =>
      await _dbSalidaProvider.guardarRegistrosIngreso(registros);

  ///
  /// Guarda los registros de Verificación de tránsito de ingreso
  ///
  Future guardarRegistrosIngresoProducto(
          IngresoTransitoProducto registros) async =>
      await _dbSalidaProvider.guardarRegistrosIngresoProducto(registros);

  ///
  /// Guarda los registros de Verificación de tránsito de ingreso
  ///
  Future guardarVerificacionSalida(
          VerificacionTransitoSalidaModelo registros) async =>
      await _dbSalidaProvider.guardarVerificacionSalida(registros);

  ///
  /// Recibe un objeto [ProvinciaUsuarioContratoModelo] para ser almacenado en DB local
  ///
  Future<void> guardarProvinciaContrato(
          ProvinciaUsuarioContratoModelo provincia) async =>
      await _dbUathProvider.guardarProvinciaContrato(provincia);

  /**
   * Selects
   */

  /// Obtiene los registros de Verificación de tránsito de ingreso almacenados localmente
  ///
  /// Devuelve una lista del objeto [RegistrosTransitoIngresoModelo]
  Future<List<RegistrosTransitoIngresoModelo>>
      getRegistrosIngresoSincronizados() async =>
          await _dbSalidaProvider.getRegistrosIngreso();

  ///
  /// Obtiene el producto de un registro de ingreso
  ///
  Future<IngresoTransitoProducto?> getRegistrosIngresoProducto(
          int idPadre) async =>
      await _dbSalidaProvider.getRegistrosIngresoProducto(idPadre);

  /// Obtiene el usuario logueado en la aplicación
  ///
  ///Devuelve un objeto[UsuarioModelo]
  Future<UsuarioModelo?> getUsuario() async =>
      await _dbHomeProvider.getUsuario();

  ///
  ///Devuelve un objeto[VerificacionTransitoSalidaModelo] si encuentra concidencia
  ///
  Future<VerificacionTransitoSalidaModelo?> getVerificacionSalidaLlenado(
          int idRegistro) async =>
      await _dbSalidaProvider.getVerificaionSalidaLLenada(idRegistro);

  ///Retorna el total de registros realizados de verificación de tránsito de salida
  ///
  ///Dato de retorno int
  Future getCantidadRegistrosRealizados() async =>
      await _dbSalidaProvider.getCantidadVerificacionSalida();

  ///Retorna todos los registros realizados de verificación de tránsito de salida
  ///
  ///Devuelve una lista del objeto [VerificacionTransitoSalidaModelo]
  Future<List<VerificacionTransitoSalidaModelo>>
      getRegistrosVerificacionSalida() async =>
          await _dbSalidaProvider.getRegistrosVerificacionSalida();

  /// Obtener la provincia del contrato activo del usuario
  ///
  /// Retorna una lista del objeto [ProvinciaUsuarioContratoModelo]
  Future<ProvinciaUsuarioContratoModelo?> getProvinciaContrato() async =>
      await _dbUathProvider.getProvinciaContrato();

  /// Obtener el usuario logueado
  ///
  /// Retorna una lista del objeto [UsuarioModelo]
  Future<UsuarioModelo?> getsusuario() async =>
      await _dbHomeProvider.getUsuario();

  /**
   * Deletes
   */

  ///
  ///Eliminar todos los registros sincronizados del formulario de Transito de ingreso
  ///
  Future eliminarRegistrosIngresoSincronizados() async =>
      await _dbSalidaProvider.eliminarRegistrosIngreso();

  ///
  ///Eliminar todos los registros sincronizados del formulario de Transito de ingreso
  ///
  Future eliminarRegistrosIngresoProductosSincronizados() async =>
      await _dbSalidaProvider.eliminarRegistrosIngresoProducto();

  ///
  ///Eliminar todos los registros de verificación de tránsito de salida realizados
  ///
  Future eliminarRegistrosVerificacionSalida() async =>
      await _dbSalidaProvider.eliminarRegistrosVerificacionSalida();

  ///
  ///Elimina la provincia del contrato activo del usuario sincronizado localmente
  ///
  Future eliminarProvinciaContrato() async =>
      await _dbUathProvider.eliminarProvinciaContrato();
}
