import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Coordenadas {
  late Position _localizacionActual;

  double? _lt;
  double? _lg;
  double? _z;
  bool? _error;
  String? _mensaje;

  get latitud => _lt;
  get longitud => _lg;
  get altura => _z;
  get error => _error;
  get mensaje => _mensaje;

  Future getLocalizacion() async {
    var permisos = await _checkPermisoLocalizacion();

    if (permisos['estadoPermiso']) {
      try {
        _localizacionActual = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);

        _lt = _localizacionActual.latitude;
        _lg = _localizacionActual.longitude;
        _z = _localizacionActual.altitude;
      } catch (e) {
        debugPrint('$e');
        _mensaje =
            'Asegurate de usar el GPS del dispositivo como modo de ubicación o activar la Presición de ubicación de Google';
      }
    } else {
      _mensaje = permisos['error'];
    }
  }

  Future<Map> _checkPermisoLocalizacion() async {
    bool estadoPermiso = true;
    LocationPermission permission;
    String error = '';

    var serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      estadoPermiso = false;
      error = 'Asegurate de activar el GPS e intenta nuevamente';
      return {'estadoPermiso': estadoPermiso, 'error': error};
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      estadoPermiso = false;
      error =
          'Los permisos de ubicación fueron denegados permanentemente.  \n\nVe a los ajustes de aplicaciones para otorgar permisos';
      return {'estadoPermiso': estadoPermiso, 'error': error};
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        estadoPermiso = false;
        error = 'No se otorgaron permisos para acceder a tu ubicación';
        return {'estadoPermiso': estadoPermiso, 'error': error};
      }
    }

    return {'estadoPermiso': estadoPermiso, 'error': error};
  }
}
