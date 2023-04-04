import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'bloc_base.dart';
import 'package:agro_servicios/app/data/models/login/ingreo_usuario_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';

export 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';
export 'package:agro_servicios/app/data/models/login/ingreo_usuario_modelo.dart';

class LoginBloc extends BlocBase with ChangeNotifier {
  IngresoUsuarioModelo _usuarioModelo = IngresoUsuarioModelo();
  UsuarioModelo? listaUsuario = UsuarioModelo();
  String? _usuario, _clave;
  String? _mensajeValidacion = '';
  String _mensajeBienvenido = 'Bienvenido!';
  String _mensajeTipoLogin = 'Usuario y Contraseña';
  String _mensajeBotonLogin = 'Iniciar Sesión';
  String _mensajeCampoClave = 'Contraseña';
  String _tipoIngreso = 'usuario';
  String _mensajeDescripcion =
      'Ingresa con tu usuario y contraseña del Sistema GUIA';
  String texto = '';

  double _margenBar = 20.0;

  bool _estaValidado = false;
  bool _online = true;
  bool _campoActivo = true;
  bool _esVisible = true;

  final Icon _iconoCheck = const Icon(
    Icons.check_circle_outline,
    size: 75.0,
    color: Colors.lightGreen,
  );

  final Icon _iconoError = const Icon(
    Icons.error_outline,
    size: 75.0,
    color: Colors.redAccent,
  );

  Icon _iconoVisible = const Icon(
    Icons.visibility,
    size: 20.0,
  );

  final Icon _iconoClaveVisible = const Icon(
    Icons.visibility,
    size: 20.0,
  );

  final Icon _iconoClaveNoVisible = const Icon(
    Icons.visibility_off,
    size: 20.0,
  );

  Icon? _icono;

  IngresoUsuarioModelo get usuarioModelo => _usuarioModelo;

  bool get estaValidando => _estaValidado;

  bool get getOnline => _online;

  bool get campoActivo => _campoActivo;

  bool get esVisible => _esVisible;

  Icon? get icono => _icono;

  double get margenBar => _margenBar;

  String? get mensajeValidacion => _mensajeValidacion;

  String? get usuarioSesion => _usuario;

  String get mensajeBienvenido => _mensajeBienvenido;

  String get mensajeTipoLogin => _mensajeTipoLogin;

  String get mensajeDescripcion => _mensajeDescripcion;

  String get mensajeBotonLogin => _mensajeBotonLogin;

  String get mensajeCampoClave => _mensajeCampoClave;

  String get tipoIngreso => _tipoIngreso;

  Icon get iconoVisible => _iconoVisible;

  set setMensajeDescripcion(String texto) {
    _mensajeDescripcion =
        'Ahora puedes acceder con diferentes métodos de autenticación a tu cuenta del Sistema GUIA';
  }

  set setMensajeCampoClave(String texto) {
    _mensajeCampoClave = texto;
  }

  set usuario(String? usuario) {
    _usuario = usuario;
  }

  set clave(String? clave) {
    _clave = clave;
  }

  set setOnline(bool conexion) {
    _online = conexion;
    notifyListeners();
  }

  set setMargenBar(double valor) {
    _margenBar = valor;
  }

  set setCampoActivo(bool activo) {
    _campoActivo = activo;
    notifyListeners();
  }

  set setMensajeTipoLogin(String texto) {
    _mensajeTipoLogin = texto;
    notifyListeners();
  }

  set setTipoIngreso(String texto) {
    _tipoIngreso = texto;
    notifyListeners();
  }

  set setVisible(bool valor) {
    _esVisible = !valor;
    _iconoVisible = _esVisible ? _iconoClaveVisible : _iconoClaveNoVisible;
    notifyListeners();
  }

  void reset() {
    _estaValidado = false;
    _mensajeValidacion = '';
  }

  Future<bool> checkInternet() async {
    bool estado = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 2));
        _mensajeValidacion = 'Validado con éxito';
        _usuarioModelo.estado = 'exito';
        _icono = _iconoCheck;
        estado = true;
      }
    } on SocketException catch (_) {
      await Future.delayed(const Duration(seconds: 2));
      _usuarioModelo.estado = 'error';
      _mensajeValidacion =
          'Sin acceso a la red, por favor verifica tu conexión a internet';
      _icono = _iconoError;
      estado = false;
    }

    _estaValidado = true;
    notifyListeners();
    return estado;
  }

  checkUsuario() async {
    await Future.delayed(const Duration(seconds: 1));
    _mensajeValidacion = 'Validado con éxito';
    _usuarioModelo.estado = 'exito';
    _icono = _iconoCheck;
    _estaValidado = true;
    notifyListeners();
  }

  Future validarUsuario({String? usuario, String? clave}) async {
    if (listaUsuario?.identificador == null) {
      await _validarUsuarioOnline();
    } else {
      if (_online) {
        if (_tipoIngreso == 'pin') {
          await _validarUsuarioLocal();
        } else {
          if (listaUsuario == null) {
            await _validarUsuarioOnline();
          } else {
            if (listaUsuario!.identificador == _usuario) {
              await _validarUsuarioOnline();
            } else {
              await Future.delayed(const Duration(seconds: 1));
              _usuarioModelo.estado = 'error';
              _icono = _iconoError;
              _mensajeValidacion =
                  'El usuario ingresado no corresponde al usuario registrado en este dispositivo móvil';
            }
          }
        }
      } else {
        await _validarUsuarioLocal();
      }
    }

    _estaValidado = true;

    await Future.delayed(const Duration(seconds: 1));

    notifyListeners();
  }

  Future _validarUsuarioLocal() async {
    await Future.delayed(const Duration(seconds: 1));
    await obtenerUsuarioLogueado();
    if (listaUsuario != null) {
      final fechaGuardada = listaUsuario!.fechaCaducidad;

      if (listaUsuario!.fechaCaducidad != null) {
        if (DateTime.now().isBefore(DateTime.parse(fechaGuardada!))) {
          if (listaUsuario!.pin == _clave) {
            _mensajeValidacion = 'El pin ingresado es correcto';
            _usuarioModelo.estado = 'exito';
            _icono = _iconoCheck;
          } else {
            _usuarioModelo.estado = 'error';
            _mensajeValidacion = 'El Pin ingresado no es válido';
            _icono = _iconoError;
          }
        } else {
          _usuarioModelo.estado = 'error';
          _mensajeValidacion = 'Su Pin de acceso ya expiró';
          _icono = _iconoError;
        }
      } else {
        _usuarioModelo.estado = 'error';
        _mensajeValidacion = 'No ha generado un Pin de acceso';
        _icono = _iconoError;
      }
    }
  }

  Future _validarUsuarioOnline() async {
    debugPrint("----- PRIMER TOKEN -----");

    _usuarioModelo.estado = 'error';
    try {
      final http.Response res = await httpRequestWS(
        endPoint: 'RestWsLogin/login',
        parametros: '$_usuario/$_clave/$_tipoIngreso',
      ).timeout(const Duration(seconds: 30));

      if (res.statusCode == 200) {
        final lista = json.decode(res.body);
        _usuarioModelo = IngresoUsuarioModelo.fromJson(lista);

        if (_usuarioModelo.estado == 'exito') {
          // debugPrint(await _apiProvider.loginToken);
          if (_usuarioModelo.cuerpo![0].fotografia != null) {
            File imagen = await urlToFile(_usuarioModelo.cuerpo![0].fotografia);
            String base64Image = base64Encode(imagen.readAsBytesSync());
            _usuarioModelo.cuerpo![0].fotografia = base64Image;
          }
          //debugPrint('${imagen.readAsBytesSync()}');
          //debugPrint(_usuarioModelo.cuerpo[0].fotografia);

          UsuarioModelo usuario = UsuarioModelo(
              identificador: _usuarioModelo.cuerpo![0].identificador,
              nombre: _usuarioModelo.cuerpo![0].nombre,
              tipo: _usuarioModelo.cuerpo![0].tipo,
              foto: _usuarioModelo.cuerpo![0].fotografia);

          listaUsuario = await DBHomeProvider.db.getUsuario();

          if (listaUsuario == null) {
            await DBHomeProvider.db.nuevoUsuario(usuario);
            listaUsuario = await DBHomeProvider.db.getUsuario();
          }

          _mensajeValidacion = _usuarioModelo.mensaje;
          _icono = _iconoCheck;
        } else {
          _mensajeValidacion = _usuarioModelo.mensaje;
          _icono = _iconoError;
        }
      }
    } on TimeoutException catch (e) {
      debugPrint('error Timeout: $e');
      _usuarioModelo.estado = 'error';
      _icono = _iconoError;
      _mensajeValidacion =
          'El servidor se está tardando en responder, intentalo mas tarde';
    } on SocketException catch (e) {
      debugPrint('error internet $e');
      _usuarioModelo.estado = 'error';
      _icono = _iconoError;
      _mensajeValidacion =
          'Sin acceso a la red, por favor verifica tu conexión a internet';
    } on HttpException catch (e) {
      _usuarioModelo.estado = 'error';
      debugPrint('Error en la petición del servicio web $e');
    } on FormatException catch (e) {
      _usuarioModelo.estado = 'error';
      debugPrint('Error en el formato de respuesta $e');
    }
  }

  obtenerUsuarioLogueado() async {
    listaUsuario = await DBHomeProvider.db.getUsuario();
    if (listaUsuario != null) {
      List<String> nombre = listaUsuario!.nombre.toString().split(' ');
      _mensajeBienvenido = 'Bienvenido de vuelta ${nombre[0]}!';
      _mensajeDescripcion =
          'Ahora puedes acceder con diferentes métodos de autenticación a tu cuenta del Sistema GUIA';
      _mensajeBotonLogin = 'Ingresar';
    } else {
      _mensajeBienvenido = 'Bienvenido!';
      _mensajeDescripcion =
          'Ingresa con tu usuario y contraseña del Sistema GUIA';
      _mensajeBotonLogin = 'Iniciar Sesión';
      _mensajeCampoClave = 'Contraseña';
      _campoActivo = true;
    }
    notifyListeners();
  }

  Future<File> urlToFile(String? imageUrl) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();

    String tempPath = tempDir.path;

    File file = File('$tempPath${rng.nextInt(100)}.jpg');
    http.Response response = await http
        .get(Uri.parse('https://i.blogs.es/594843/chrome/450_1000.jpg'));

    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  void cerrarSesion() async {
    await DBHomeProvider.db.eliminarTodosUsuarios();
    obtenerUsuarioLogueado();
    setMensajeTipoLogin = 'Usuario y Contraseña';
    notifyListeners();
  }
}
