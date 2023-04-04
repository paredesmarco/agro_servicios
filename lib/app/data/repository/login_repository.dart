import 'package:get/get.dart';

import 'package:agro_servicios/app/data/models/token/token_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/uath_provider.dart';
import 'package:agro_servicios/app/bloc/bloc_login.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_uath_provider.dart';

class LoginRepository {
  final LoginProvider _loginProvider = Get.find<LoginProvider>();
  final DBHomeProvider _homeProvider = Get.find<DBHomeProvider>();
  final UathProvider _uathProvider = Get.find<UathProvider>();
  final DBUathProvider _dbUathProvider = Get.find<DBUathProvider>();
  final _dbUath = Get.find<DBUathProvider>();

  /// Valida el usuario y contraseña del Sistema GUIA
  ///
  /// Devuelve un objeto [IngresoUsuarioModelo] con los datos de usuario y un [Token]
  Future<IngresoUsuarioModelo> login(
          String usuario, String clave, String tipoIngreso,
          {String publicKey = ''}) async =>
      await _loginProvider.login(usuario, clave, tipoIngreso,
          publicKey: publicKey);

  /// Valida la llave pública para devolver un token de sesión
  ///
  /// Devuelve un objeto [IngresoUsuarioModelo] con los datos de usuario y un [Token]
  Future<IngresoUsuarioModelo?> loginToken(String usuario, String clave,
          String tipoIngreso, String publicKey) async =>
      await _loginProvider.loginToken(publicKey: publicKey);

  /// Obtener el pin para inicio de sesión generado en la aplicación
  ///
  /// Devuelve un objeto [UsuarioModelo] con los datos de usuario
  Future<UsuarioModelo?> obtenerPin() async => await _homeProvider.getUsuario();

  ///
  /// Permite obtener un token que fue almacenado localmente
  ///
  Future<String?> obtenerSesionToken() async =>
      await _loginProvider.obtenerToken();

  ///
  /// Obtiene la provincia donde esta creado el contrato del usuario en el Sistema GUIA
  ///
  Future<ProvinciaUsuarioContratoModelo> obtenerProvinciaContrato(
          String identificador) async =>
      await _uathProvider.obtenerUbicacionContrato(
          identificador, _loginProvider.obtenerToken());

  /**
   * Inserts
   */

  ///
  /// Permite guardar un token localmente para utilizarlo en los servicios
  ///
  Future<void> guardarSesionToken(TokenModelo token) async =>
      await _loginProvider.guardarSesionToken(token);

  ///
  /// Recibe un objeto [ProvinciaUsuarioContratoModelo] para ser almacenado en DB local
  ///
  Future<void> guardarProvinciaContrato(
          ProvinciaUsuarioContratoModelo provincia) async =>
      await _dbUath.guardarProvinciaContrato(provincia);

  /**
   * Deletes
   */

  ///
  /// Permite eliminar un token almacenado localmente
  ///
  Future<void> eliminarSesionToken() async =>
      await _loginProvider.eliminarSesionToken();

  ///
  /// Elimina la provincia del contrato activo del usuario sincronizado localmente
  ///
  Future<void> eliminarProvincia() async =>
      await _dbUathProvider.eliminarProvinciaContrato();
}
