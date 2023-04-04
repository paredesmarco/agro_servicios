import 'dart:io';
import 'dart:math';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';
import 'package:agro_servicios/app/data/models/muestreo_mosca_sv/muestreo_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/muestreo_mf_sv_repository.dart';

class MuestreoMfSvUbicacionController extends GetxController {
  final _repository = Get.find<MuestreoMfSvRepository>();

  LocalizacionModelo? _provincia;
  // final muestreoModelo = MuestreoMfSvModelo();
  // MuestreoMfSvDatosModelo muestreoModelo = new MuestreoMfSvDatosModelo();
  MuestreoMfSvModelo muestreoModelo = MuestreoMfSvModelo();
  TextEditingController coordenadaXcontrolador = TextEditingController();
  TextEditingController coordenadaYcontrolador = TextEditingController();
  TextEditingController coordenadaZcontrolador = TextEditingController();

  File? _image;

  String ruta = "img/previo-carga.png";
  String? errorCanton;
  String? errorParroquia;
  String? errorSitio;
  String? errorCoordenadaX;
  String? errorCoordenadaY;
  String? errorCoordenadaZ;

  var mensajeUbicacionError = ''.obs;

  int? idParroquia;
  int? valorParroquia;

  var numeroFotosTrampa = 0.obs;
  var provincia = "".obs;

  List<LocalizacionModelo> listaCanton = <LocalizacionModelo>[];
  List<LocalizacionModelo> listaParroquia = <LocalizacionModelo>[];

  RxBool obteniendoUbicacion = false.obs;

  @override
  void onInit() {
    obtenerProvinciaSincronizada();
    super.onInit();
  }

  @override
  void onClose() {
    coordenadaXcontrolador.dispose();
    coordenadaYcontrolador.dispose();
    coordenadaZcontrolador.dispose();
    super.onClose();
  }

  get imagen => _image;

  set setImagenFile(String valor) {
    _image = File(valor);
    muestreoModelo.imagen = valor;
    update(['idFoto']);
  }

  set setCoordenadaX(valor) => muestreoModelo.coordenadaX = valor;

  set setCoordenadaY(valor) => muestreoModelo.coordenadaY = valor;

  set setCoordenadaZ(valor) => muestreoModelo.coordenadaZ = valor;

  set setSitio(valor) => muestreoModelo.sitio = valor;

  void setCanton(id) async {
    LocalizacionModelo localizacion = await _repository.getLocalizacion(id);
    muestreoModelo.codigoCanton = localizacion.idGuia!.toString();
    muestreoModelo.nombreCanton = localizacion.nombre!;
    muestreoModelo.codigoParroquia = null;
    idParroquia = null;
  }

  void setParroquia(id) async {
    LocalizacionModelo localizacion = await _repository.getLocalizacion(id);
    muestreoModelo.codigoParroquia = localizacion.idGuia!.toString();
    muestreoModelo.nombreParroquia = localizacion.nombre!;
    idParroquia = id;
  }

  void eliminarImagen() {
    muestreoModelo.imagen = null;
    _image?.deleteSync();
    _image = null;
    numeroFotosTrampa.value = 0;
    update(['idFoto']);
  }

  Future<void> obtenerProvinciaSincronizada() async {
    _provincia = await _repository.getProvinciaSincronizada();
    provincia.value = _provincia?.nombre == null ? '' : _provincia!.nombre!;
    if (_provincia?.idGuia != null) {
      muestreoModelo.codigoProvincia = _provincia!.idGuia.toString();
      muestreoModelo.nombreProvincia = _provincia!.nombre;
      obtenerCantones(_provincia!.idGuia!);
    }
  }

  Future<void> obtenerCantones(int provincia) async {
    listaCanton = await _repository.getCanton(provincia);
    update(['idCanton']);
  }

  Future<void> obtenerParroquia(int canton) async {
    listaParroquia = await _repository.getParroquia(canton);
    update(['idParroquia']);
  }

  Future getPosicion() async {
    var permisos = await _checkPermisoLocalizacion();

    obteniendoUbicacion.value = true;

    late Position localizacionActual;
    if (permisos['estadoPermiso']) {
      try {
        localizacionActual = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);

        double lt = localizacionActual.latitude;
        double lg = localizacionActual.longitude;
        double z = localizacionActual.altitude;

        debugPrint('coordenadas $lt $lg');

        muestreoModelo.coordenadaX = '$lg';
        muestreoModelo.coordenadaY = '$lt';
        muestreoModelo.coordenadaZ = '$z';

        coordenadaXcontrolador.text = '$lg';
        coordenadaYcontrolador.text = '$lt';
        coordenadaZcontrolador.text = '$z';
      } catch (e) {
        debugPrint('Error: $e');
        mensajeUbicacionError.value =
            'Asegurate de usar el GPS del dispositivo como modo de ubicación o activar la Presición de ubicación de Google';
      }
    } else {
      mensajeUbicacionError.value = permisos['error'];
    }

    obteniendoUbicacion.value = false;
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
          'Los permisos de ubicación fueron denegados permanentemente.  \n\nVe a los ajustes de aplicaciones para otorgar los permisos';
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

  Future<bool> validarFormulario() async {
    bool esValido = true;

    if (muestreoModelo.codigoCanton == null) {
      errorCanton = 'Campo requerido';
      esValido = false;
    } else {
      errorCanton = null;
    }

    if (muestreoModelo.codigoParroquia == null) {
      errorParroquia = 'Campo requerido';
      esValido = false;
    } else {
      errorParroquia = null;
    }

    if (muestreoModelo.sitio == null || muestreoModelo.sitio == '') {
      errorSitio = 'Campo requerido';
      esValido = false;
    } else {
      errorSitio = null;
    }

    if (muestreoModelo.coordenadaX == null ||
        muestreoModelo.coordenadaX == '') {
      errorCoordenadaX = 'Campo requerido';
      esValido = false;
    } else {
      errorCoordenadaX = null;
    }

    if (muestreoModelo.coordenadaY == null ||
        muestreoModelo.coordenadaY == '') {
      errorCoordenadaY = 'Campo requerido';
      esValido = false;
    } else {
      errorCoordenadaY = null;
    }

    if (muestreoModelo.coordenadaZ == null ||
        muestreoModelo.coordenadaZ == '') {
      errorCoordenadaZ = 'Campo requerido';
      esValido = false;
    } else {
      errorCoordenadaZ = null;
    }

    if (esValido) await completarFOrmulario();

    update(['idCanton', 'idParroquia', 'idValidacion']);
    return esValido;
  }

  Future<void> completarFOrmulario() async {
    UsuarioModelo? usuario = UsuarioModelo();

    Random random = Random();

    usuario = await _repository.getUsuario();

    muestreoModelo.usuarioId = usuario!.identificador;
    muestreoModelo.usuario = usuario.nombre;
    muestreoModelo.idTablet = (random.nextInt(90) + 1);
    muestreoModelo.semana = Jiffy(DateTime.now()).week;
    muestreoModelo.fechaInspeccion =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString();
    muestreoModelo.tabletId = usuario.identificador;
    muestreoModelo.tabletVersionBase = SCHEMA_VERSION;
  }
}
