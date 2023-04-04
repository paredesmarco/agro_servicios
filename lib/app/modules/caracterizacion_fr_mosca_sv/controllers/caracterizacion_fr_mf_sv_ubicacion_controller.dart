import 'dart:io';

import 'package:agro_servicios/app/data/models/caracterizacion_fr_mosca_sv/caracterizacion_fr_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/repository/caracterizacion_fr_mf_sv_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CaracterizacionFrMfSvUbicacionController extends GetxController {
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

  List<LocalizacionModelo> canton = [];
  LocalizacionModelo? _provincia;
  List<LocalizacionModelo> listaCanton = <LocalizacionModelo>[];
  List<LocalizacionModelo> listaParroquia = <LocalizacionModelo>[];
  final _repository = Get.find<CaracterizacionFrMfSvRepository>();

  TextEditingController coordenadaXcontrolador = TextEditingController();
  TextEditingController coordenadaYcontrolador = TextEditingController();
  TextEditingController coordenadaZcontrolador = TextEditingController();

  File? _image;
  // var numeroFotosTrampa = 0.obs;
  var provincia = "".obs;
  var mensajeUbicacionError = ''.obs;

  String ruta = "img/previo-carga.png";
  String? errorCanton;
  String? errorParroquia;
  String? errorSitio;
  String? errorCoordenadaX;
  String? errorCoordenadaY;
  String? errorCoordenadaZ;

  int? idParroquia;
  int? valorParroquia;

  RxBool obteniendoCoordenadas = false.obs;

  CaracterizacionFrMfSvModelo caracteizacionModelo =
      CaracterizacionFrMfSvModelo();

  get imagen => _image;

  set setCoordenadaX(valor) => caracteizacionModelo.coordenadaX = valor;

  set setCoordenadaY(valor) => caracteizacionModelo.coordenadaY = valor;

  set setCoordenadaZ(valor) => caracteizacionModelo.coordenadaZ = valor;

  set setSitio(valor) => caracteizacionModelo.sitio = valor;

  set setImagenFile(String valor) {
    _image = File(valor);
    caracteizacionModelo.imagen = valor;
    update(['idFoto']);
  }

  eliminarImagen() {
    caracteizacionModelo.imagen = null;
    _image?.deleteSync();
    _image = null;
    update(['idFoto']);
  }

  void setCanton(id) async {
    LocalizacionModelo localizacion = await _repository.getLocalizacion(id);
    caracteizacionModelo.codigoCanton = localizacion.idGuia!.toString();
    caracteizacionModelo.canton = localizacion.nombre!;
    caracteizacionModelo.codigoParroquia = null;
    caracteizacionModelo.parroquia = null;
    idParroquia = null;
  }

  void setParroquia(id) async {
    LocalizacionModelo localizacion = await _repository.getLocalizacion(id);
    caracteizacionModelo.codigoParroquia = localizacion.idGuia!.toString();
    caracteizacionModelo.parroquia = localizacion.nombre!;
    idParroquia = id;
  }

  Future<void> obtenerProvinciaSincronizada() async {
    _provincia = await _repository.getProvinciaSincronizada();
    provincia.value = _provincia?.nombre == null ? '' : _provincia!.nombre!;

    if (_provincia?.idGuia != null) {
      caracteizacionModelo.codigoProvincia = _provincia!.idGuia.toString();
      caracteizacionModelo.provincia = _provincia!.nombre;
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
    obteniendoCoordenadas.value = true;

    var permisos = await _checkPermisoLocalizacion();

    late Position localizacionActual;
    if (permisos['estadoPermiso']) {
      try {
        localizacionActual = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);

        double lt = localizacionActual.latitude;
        double lg = localizacionActual.longitude;
        double z = localizacionActual.altitude;

        caracteizacionModelo.coordenadaX = '$lg';
        caracteizacionModelo.coordenadaY = '$lt';
        caracteizacionModelo.coordenadaZ = '$z';

        coordenadaXcontrolador.text = '$lg';
        coordenadaYcontrolador.text = '$lt';
        coordenadaZcontrolador.text = '$z';
      } catch (e) {
        mensajeUbicacionError.value =
            'Asegurate de usar el GPS del dispositivo como modo de ubicación o activar la Presición de ubicación de Google';
      }
    } else {
      mensajeUbicacionError.value = permisos['error'];
    }

    obteniendoCoordenadas.value = false;
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

  bool validarFormulario() {
    bool esValido = true;

    if (caracteizacionModelo.canton == null ||
        caracteizacionModelo.canton == '') {
      errorCanton = 'Campo requerido';
      esValido = false;
    } else {
      errorCanton = null;
    }

    if (caracteizacionModelo.parroquia == null ||
        caracteizacionModelo.parroquia == '') {
      errorParroquia = 'Campo requerido';
      esValido = false;
    } else {
      errorParroquia = null;
    }

    if (caracteizacionModelo.coordenadaX == null ||
        caracteizacionModelo.coordenadaX == '') {
      errorCoordenadaX = 'Campo requerido';
      esValido = false;
    } else {
      errorCoordenadaX = null;
    }

    if (caracteizacionModelo.coordenadaY == null ||
        caracteizacionModelo.coordenadaY == '') {
      errorCoordenadaY = 'Campo requerido';
      esValido = false;
    } else {
      errorCoordenadaY = null;
    }

    if (caracteizacionModelo.coordenadaZ == null ||
        caracteizacionModelo.coordenadaZ == '') {
      errorCoordenadaZ = 'Campo requerido';
      esValido = false;
    } else {
      errorCoordenadaZ = null;
    }

    if (caracteizacionModelo.sitio == null ||
        caracteizacionModelo.sitio == '') {
      errorSitio = 'Campo requerido';
      esValido = false;
    } else {
      errorSitio = null;
    }

    update(['idValidacion', 'idParroquia']);

    return esValido;
  }
}
