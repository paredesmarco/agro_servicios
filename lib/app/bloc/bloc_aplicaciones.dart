import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bloc_base.dart';
import 'package:agro_servicios/app/data/models/aplicaciones/aplicaciones_modelo.dart';
import 'package:agro_servicios/app/data/models/aplicaciones/area_aplicacion_modelo.dart';
import 'package:agro_servicios/app/data/models/aplicaciones/areas_modelo.dart';
import 'package:agro_servicios/app/data/models/login/pin_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/repository/login_repository.dart';

export 'package:agro_servicios/app/data/models/login/pin_modelo.dart';
export 'package:agro_servicios/app/data/models/aplicaciones/areas_modelo.dart';

class AplicacionesBloc extends BlocBase with ChangeNotifier {
  List<AplicacionesModelo> listaAplicaciones = List.empty();
  List<AreasModelo> listaCoordinaciones = List.empty();
  List<AreasModelo> listaAreas = List.empty();
  List<AreaAplicacionModelo> listaAreaAplicacion = List.empty();
  PinModelo pinUsuario = PinModelo();
  bool _isLoading = true;
  bool _estaValidado = false;
  String? _mensajeValidacion = '';
  String? _estadoGeneracionPin = '';

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

  Icon? _icono;

  bool get estaValidando => _estaValidado;

  Icon? get icono => _icono;

  PinModelo get pinUsuarioModelo => pinUsuario;

  List<AreasModelo> get areas => listaAreas;

  bool get isLoading => _isLoading;

  String? get mensajeValidacion => _mensajeValidacion;

  String? get estadoGeneracionPin => _estadoGeneracionPin;

  int indexCoordinacion = 0;

  String coordicacionSeleccionada = '';

  Future<void> cambiarCoordinaciones(int index) async {
    if (index != indexCoordinacion) {
      for (var area in listaCoordinaciones) {
        area.seleccionado = false;
      }
      listaCoordinaciones[index].seleccionado = true;

      indexCoordinacion = index;

      coordicacionSeleccionada = listaCoordinaciones[index].nombreCorto!;

      await _cambiarAreas(listaCoordinaciones[index].idArea!);

      notifyListeners();
    }
  }

  getAplicacionesOnline(usuario, online) async {
    final loginProvider = Get.find<LoginRepository>();
    final token = await loginProvider.obtenerSesionToken();
    final res = await httpRequestWS(
        endPoint: 'RestWsAplicaciones/obtenerAplicaciones',
        parametros: usuario,
        token: token);
    if (res.statusCode == 200) {
      final cuerpo = json.decode(res.body);

      List lista = cuerpo['cuerpo'];

      listaAplicaciones =
          lista.map((model) => AplicacionesModelo.fromJson(model)).toList();

      await _eliminarAplicaciones();
      if (listaAplicaciones.isNotEmpty) {
        await _guardarAplicaciones();
        await _guardarAreas(usuario);
        await _obtenerAreas();
      }

      _isLoading = false;

      notifyListeners();
    } else {
      throw ('Ocurrió un problema de red');
    }
  }

  getAplicacionesOffline() async {
    listaAplicaciones = await DBHomeProvider.db.getTodosAplicaciones();
    await _obtenerAreas();
    _isLoading = false;
    notifyListeners();
  }

  _eliminarAplicaciones() async {
    await DBHomeProvider.db.eliminarTodosAplicaciones();
  }

  _guardarAplicaciones() async {
    for (var item in listaAplicaciones) {
      await DBHomeProvider.db.nuevoAplicacion(item);
    }
  }

  _guardarAreas(usuario) async {
    final loginProvider = Get.find<LoginRepository>();
    final token = await loginProvider.obtenerSesionToken();
    final res = await httpRequestWS(
        endPoint: 'RestWsAreas/obtenerAreas',
        parametros: usuario,
        token: token);
    if (res.statusCode == 200) {
      final cuerpo = json.decode(res.body);

      List lista = cuerpo['cuerpo'];

      await DBHomeProvider.db.eliminarTodosAreas();

      listaAreas = lista.map((model) => AreasModelo.fromJson(model)).toList();

      for (int i = 0; i <= listaAreas.length - 1; i++) {
        await DBHomeProvider.db.nuevoAreas(listaAreas[i]);

        for (int j = 0; j <= listaAreas[i].areas!.length - 1; j++) {
          await DBHomeProvider.db.nuevoAreas(listaAreas[i].areas![j]);
        }
      }
    }
  }

  void reset() {
    _estaValidado = false;
    _mensajeValidacion = '';
  }

  _obtenerAreas() async {
    listaCoordinaciones = await DBHomeProvider.db
        .getAreas(idAreaPadre: 'DE', orderBy: 'nombre_corto desc');

    listaCoordinaciones.first.seleccionado = true;
    coordicacionSeleccionada = listaCoordinaciones.first.nombreCorto!;

    listaAreas = await DBHomeProvider.db
        .getAreas(idAreaPadre: listaCoordinaciones.first.idArea!);
  }

  _cambiarAreas(String areaPadre) async {
    listaAreas = await DBHomeProvider.db.getAreas(idAreaPadre: areaPadre);
  }

  getPin(usuario, tipo) async {
    final res = await httpRequestWS(
        endPoint: 'RestWsPin/generarPin', parametros: '$usuario/$tipo');
    if (res.statusCode == 200) {
      final lista = json.decode(res.body);
      pinUsuario = PinModelo.fromJson(lista);

      if (pinUsuario.estado == 'exito') {
        await DBHomeProvider.db.updatePin(pinUsuario);
        _estadoGeneracionPin = 'exito';
        _mensajeValidacion = pinUsuario.mensaje;
        _icono = _iconoCheck;
      } else {
        _estadoGeneracionPin = 'error';
        _mensajeValidacion = pinUsuario.mensaje;
        _icono = _iconoError;
      }
      await Future.delayed(const Duration(seconds: 1));
      _estaValidado = true;
      notifyListeners();
    } else {
      _estadoGeneracionPin = 'error';
      notifyListeners();
    }
  }
}
