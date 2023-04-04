import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'dart:developer';

import 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/login/ingreo_usuario_modelo.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/data/repository/home_repository.dart';
import 'package:agro_servicios/app/data/repository/login_repository.dart';

class LoginController extends GetxController with ControladorBase {
  final LocalAuthentication _auth = LocalAuthentication();
  final LoginRepository _loginRepository = Get.find<LoginRepository>();
  final HomeRepository _homeRepository = Get.find<HomeRepository>();
  IngresoUsuarioModelo _ingresoUsuarioModelo = IngresoUsuarioModelo();
  UsuarioModelo? _usuarioModelo = UsuarioModelo();

  bool _online = true;

  String _usuario = '';
  String _clave = '';
  String _tipoIngreso = 'usuario';

  var mensajeLogin = 'Validando...'.obs;
  var estadoLogin = ''.obs;

  var _autenticado = false;
  var validandoLogin = true.obs;
  var estaValidando = true.obs;

  get online => _online;

  get usuario => _usuario;

  get clave => _clave;

  get tipoIngreso => _tipoIngreso;

  UsuarioModelo? get usuarioModelo => _usuarioModelo;

  set setOnline(valor) => _online = valor;

  set setUsuario(valor) => _usuario = valor;

  set setClave(valor) => _clave = valor;

  set setTipoIngreso(valor) => _tipoIngreso = valor;

  void _iniciarValidacion({String? mensaje}) {
    validandoLogin.value = true;
    mensajeLogin.value = mensaje ?? 'Validando...';
  }

  void _finalizarValidacion(String mensaje) {
    validandoLogin.value = false;
    mensajeLogin.value = mensaje;
  }

  ///Muestra la autenticación con los datos biométricos propios del dispositivo y SO
  ///
  ///Si los datos biómetricos son correctos accede a la pantalla de Home
  Future<void> validarBiometricos({
    required String titulo,
    required Widget mensaje,
    required Widget icono,
  }) async {
    try {
      const iosStrings = IOSAuthMessages(
          cancelButton: 'Cancelar',
          goToSettingsButton: 'ajustes',
          goToSettingsDescription: 'Por favor configura tu Touch/Face ID.',
          lockOut: 'Por favor activa tu Touch/Face ID');

      const androidStrings = AndroidAuthMessages(
          signInTitle: 'Autenticación con huella digital',
          biometricHint: '',
          biometricRequiredTitle: 'Huella digital requerida',
          cancelButton: 'Cancelar',
          goToSettingsButton: 'ajustes',
          goToSettingsDescription: 'Por favor configura tu huella digital.');

      _autenticado = await _auth.authenticate(
        localizedReason: 'Accede con tu huella digital',
        authMessages: const <AuthMessages>[
          iosStrings,
          androidStrings,
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
          sensitiveTransaction: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint('$e');
    }

    if (_autenticado) {
      estadoLogin.value = 'exito';
      _iniciarValidacion();
      mostrarModalBottomSheet(
        titulo: titulo,
        icono: icono,
        mensaje: mensaje,
      );

      await Future.delayed(const Duration(seconds: 1));
      await _loginBiometrico();
    } else {
      estadoLogin.value = 'error';
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  ///
  ///Inicia sesión en la aplicación a través de los datos biométricos
  ///
  Future<void> _loginBiometrico() async {
    if (_online) {
      int tiempo = 4;
      String? mensaje;
      RespuestaProvider res = await ejecutarConsulta(() {
        return _loginRepository.loginToken(
            usuario, clave, 'biometrico', PUBLIC_KEY);
      });

      debugPrint('${res.cuerpo}');
      if (res.estado == 'exito') {
        _ingresoUsuarioModelo = res.cuerpo;
        if (_ingresoUsuarioModelo.estado == 'exito') {
          _loginRepository.guardarSesionToken(_ingresoUsuarioModelo.token!);
          _usuarioModelo = await _homeRepository.getUsuario();
          mensaje = 'Usuario validado con éxito';
          tiempo = 2;
          _obtenerProvinciaContrato();
        } else {
          mensaje = _ingresoUsuarioModelo.mensaje;
          estadoLogin.value = 'error';
        }
      } else {
        _ingresoUsuarioModelo.estado = 'error';
        mensaje = res.mensaje;
        estadoLogin.value = 'error';
      }

      // debugPrint(_ingresoUsuarioModelo.estado);

      _finalizarValidacion(mensaje!);
      await Future.delayed(Duration(seconds: tiempo));
      Get.back();
      if (_ingresoUsuarioModelo.estado == 'exito') Get.offNamed(Rutas.HOME);
    } else {
      _usuarioModelo = await _homeRepository.getUsuario();
      _finalizarValidacion('Usuario validado con éxito');
      estadoLogin.value = 'exito';
      await Future.delayed(const Duration(seconds: 1));
      Get.back();
      Get.offNamed(Rutas.HOME);
    }
    update(['idUsuario']);
  }

  Future validarUsuarioOnline(
      {required String titulo,
      required Widget icono,
      required Widget mensaje}) async {
    _ingresoUsuarioModelo.estado = 'error';

    _iniciarValidacion();

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));

    _loginRepository.eliminarSesionToken();

    final RespuestaProvider res = await ejecutarConsulta(() async {
      if (_tipoIngreso == 'pin') {
        UsuarioModelo? usuario = await _homeRepository.getUsuario();
        _usuario = usuario!.identificador!;
      }
      return await _loginRepository.login(_usuario, _clave, _tipoIngreso);
    });

    try {
      if (res.estado == 'exito') {
        _ingresoUsuarioModelo = res.cuerpo;
        if (AMBIENTE == 'DE') debugPrint('$_ingresoUsuarioModelo');
        if (_ingresoUsuarioModelo.estado == 'exito') {
          if (_ingresoUsuarioModelo.token != null &&
              _ingresoUsuarioModelo.token?.estado == 'exito') {
            _loginRepository.guardarSesionToken(_ingresoUsuarioModelo.token!);

            _usuarioModelo = await _homeRepository.getUsuario();

            if (_usuarioModelo == null) {
              UsuarioModelo usuario = UsuarioModelo(
                  identificador: _ingresoUsuarioModelo.cuerpo![0].identificador,
                  nombre: _ingresoUsuarioModelo.cuerpo![0].nombre,
                  tipo: _ingresoUsuarioModelo.cuerpo![0].tipo,
                  foto: _ingresoUsuarioModelo.cuerpo![0].fotografia);
              await _homeRepository.guardarUsuario(usuario);
              _usuarioModelo = await _homeRepository.getUsuario();
            }
            _obtenerProvinciaContrato();

            _finalizarValidacion('Usuario validado con éxito');
            estadoLogin.value = 'exito';
            await Future.delayed(const Duration(seconds: 2));
            Get.back();
            Get.offNamed(Rutas.HOME);
          } else {
            _finalizarValidacion(
                'Ocurrió un error al crear la sesión de usuario');
            await Future.delayed(const Duration(seconds: 4));
            estadoLogin.value = 'error';
            Get.back();
          }
        } else {
          _finalizarValidacion(res.cuerpo.mensaje);
          estadoLogin.value = 'error';
          await Future.delayed(const Duration(seconds: 4));
          update(['idUsuario']);
          Get.back();
        }
      } else {
        _finalizarValidacion(res.mensaje!);
        estadoLogin.value = 'error';
        await Future.delayed(const Duration(seconds: 4));
        Get.back();
      }
    } catch (e) {
      _finalizarValidacion(e.toString());
      await Future.delayed(const Duration(seconds: 4));
      estadoLogin.value = 'error';
      Get.back();
    }
  }

  Future<void> validarUsuarioPin(
      {required String titulo,
      required Widget icono,
      required Widget mensaje}) async {
    _ingresoUsuarioModelo.estado = 'error';

    _iniciarValidacion();

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));

    RespuestaProvider res = await ejecutarConsulta((() async {
      return await _loginRepository.obtenerPin();
    }));

    if (res.estado == 'exito') {
      if (res.cuerpo.pin != null) {
        String pin = res.cuerpo.pin;
        DateTime fechaCaducidad = DateTime.parse(res.cuerpo.fechaCaducidad);
        if (pin == _clave) {
          if (DateTime.now().isBefore(fechaCaducidad)) {
            log('pin vlido');
            _usuarioModelo = await _homeRepository.getUsuario();
            _finalizarValidacion('Usuario validado con éxito');
            estadoLogin.value = 'exito';
            await Future.delayed(const Duration(seconds: 1));
            Get.back();
            Get.offNamed(Rutas.HOME);
          } else {
            _finalizarValidacion('El pin ingresado se encuentra caducado');
            estadoLogin.value = 'error';
            await Future.delayed(const Duration(seconds: 3));
            Get.back();
          }
        } else {
          _finalizarValidacion('El pin ingresado es incorrecto');
          estadoLogin.value = 'error';
          await Future.delayed(const Duration(seconds: 3));
          Get.back();
        }
      } else {
        _finalizarValidacion('No ha generado un Pin de acceso');
        estadoLogin.value = 'error';
        await Future.delayed(const Duration(seconds: 3));
        Get.back();
      }
    } else {
      _finalizarValidacion(res.mensaje!);
      estadoLogin.value = 'error';
      await Future.delayed(const Duration(seconds: 3));
      Get.back();
    }
  }

  Future<void> _obtenerProvinciaContrato() async {
    final UsuarioModelo? usuarioLogueado = await _homeRepository.getUsuario();

    RespuestaProvider res = await ejecutarConsulta(() {
      return _loginRepository
          .obtenerProvinciaContrato(usuarioLogueado!.identificador!);
    });

    if (res.estado == 'exito') {
      _loginRepository.eliminarProvincia();
      _loginRepository.guardarProvinciaContrato(res.cuerpo);
    } else {
      _loginRepository.eliminarProvincia();
    }
  }
}
