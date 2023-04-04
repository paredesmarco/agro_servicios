import 'package:agro_servicios/app/common/comunes.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_sa_controller.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';

class ProductosImportadosPaso1SaController extends GetxController
    with ControladorBase {
  final _controlador = Get.find<ProductosImportadosSaController>();

  bool errorPregunta01 = false;
  bool errorPregunta02 = false;
  bool errorPregunta03 = false;
  bool errorPregunta04 = false;
  bool errorPregunta05 = false;
  bool errorPregunta06 = false;
  bool errorPregunta07 = false;
  bool errorPregunta08 = false;

  String? errorNumeroEmbalajeEnvio;
  String? errorNumeroEmbalajeInspeccion;
  String? errorPalletsEnvio;
  String? errorContenedoresAforo;
  String? errorCriterio;
  String? errorRiesgo;

  @override
  void onInit() {
    _controlador.inspeccion.envioMuestra = 'No';
    super.onInit();
  }

  get descripcionProducto => _controlador.inspeccion.pregunta01;

  get cantidad => _controlador.inspeccion.pregunta02;

  get marcaAutorizada => _controlador.inspeccion.pregunta03;

  get marcaLegible => _controlador.inspeccion.pregunta04;

  get danioInsecto => _controlador.inspeccion.pregunta05;

  get insectosVivos => _controlador.inspeccion.pregunta06;

  get corteza => _controlador.inspeccion.pregunta07;

  get empaques => _controlador.inspeccion.pregunta08;

  set descripcionProducto(valor) {
    _controlador.inspeccion.pregunta01 = valor;
    update(['idDescripcion']);
  }

  set cantidad(valor) {
    _controlador.inspeccion.pregunta02 = valor;
    update(['idCantidad']);
  }

  set marcaAutorizada(valor) {
    _controlador.inspeccion.pregunta03 = valor;
    update(['idMarcaAutorizado']);
  }

  set marcaLegible(valor) {
    _controlador.inspeccion.pregunta04 = valor;
    update(['idMarcaLegible']);
  }

  set danioInsecto(valor) {
    _controlador.inspeccion.pregunta05 = valor;
    update(['idDanioInsecto']);
  }

  set insectosVivos(valor) {
    _controlador.inspeccion.pregunta06 = valor;
    update(['idInsectosVivos']);
  }

  set corteza(valor) {
    _controlador.inspeccion.pregunta07 = valor;
    update(['idCorteza']);
  }

  set empaques(valor) {
    _controlador.inspeccion.pregunta08 = valor;
    update(['idEmpaques']);
  }

  set numeroEmbalajeEnvio(valor) =>
      _controlador.inspeccion.numeroEmbalajesEnvio = valor;

  set numeroEmbalajeInspeccion(valor) =>
      _controlador.inspeccion.numeroEmbalajesInspeccionados = valor;

  set palletsEnvio(valor) => _controlador.inspeccion.pregunta09 =
      valor != '' ? int.parse(valor) : null;

  set contenedoresAforo(valor) => _controlador.inspeccion.pregunta10 =
      valor != '' ? int.parse(valor) : null;

  set criterio(valor) => _controlador.inspeccion.pregunta11 = valor;

  set categoriaRiesgo(valor) => _controlador.inspeccion.categoriaRiesgo = valor;

  bool validarFormulario() {
    bool esValido = true;

    if (descripcionProducto == null || descripcionProducto == '') {
      esValido = false;
      errorPregunta01 = true;
    } else {
      errorPregunta01 = false;
    }

    if (cantidad == null || cantidad == '') {
      esValido = false;
      errorPregunta02 = true;
    } else {
      errorPregunta02 = false;
    }

    if (_controlador.inspeccion.pregunta09 == null) {
      esValido = false;
      errorPalletsEnvio = CAMPO_REQUERIDO;
    } else {
      errorPalletsEnvio = null;
    }

    if (_controlador.inspeccion.pregunta10 == null) {
      esValido = false;
      errorContenedoresAforo = CAMPO_REQUERIDO;
    } else {
      errorContenedoresAforo = null;
    }

    if (_controlador.inspeccion.pregunta11 == null ||
        _controlador.inspeccion.pregunta11 == ''.trim()) {
      esValido = false;
      errorCriterio = CAMPO_REQUERIDO;
    } else {
      errorCriterio = null;
    }

    if (_controlador.inspeccion.categoriaRiesgo == null ||
        _controlador.inspeccion.categoriaRiesgo == ''.trim()) {
      esValido = false;
      errorRiesgo = CAMPO_REQUERIDO;
    } else {
      errorRiesgo = null;
    }

    update([
      'idValidacion',
      'idDescripcion',
      'idCantidad',
      'idMarcaAutorizado',
      'idMarcaLegible',
      'idDanioInsecto',
      'idInsectosVivos',
      'idCorteza',
      'idEmpaques'
    ]);

    return esValido;
  }
}
