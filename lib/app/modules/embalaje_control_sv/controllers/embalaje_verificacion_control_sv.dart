import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_control_sv_controller.dart';
import 'package:get/get.dart';

class EmbalajeVerificacionControlSvController extends GetxController {
  final EmbalajeControlSvController controlador =
      Get.find<EmbalajeControlSvController>();
  String? grupoPregunta1;
  String? grupoPregunta2;
  String? grupoPregunta3;
  String? grupoPregunta4;
  String? grupoPregunta5;

  bool? errorPregunta1;
  bool? errorPregunta2;
  bool? errorPregunta3;
  bool? errorPregunta4;
  bool? errorPregunta5;

  set observacion1(valor) =>
      controlador.embalajeModelo.marcaAutorizadaDescripcion = valor;
  set observacion2(valor) =>
      controlador.embalajeModelo.marcaLegibleDescripcion = valor;
  set observacion3(valor) =>
      controlador.embalajeModelo.ausenciaDanoInsectosDescripcion = valor;
  set observacion4(valor) =>
      controlador.embalajeModelo.ausenciaInsectosVivosDescripcion = valor;
  set observacion5(valor) =>
      controlador.embalajeModelo.ausenciaCortezaDescripcion = valor;

  set setGrupoPregunta1(valor) {
    controlador.embalajeModelo.marcaAutorizada = valor;
    grupoPregunta1 = valor;
    update(['idPregunta1']);
  }

  set setGrupoPregunta2(valor) {
    controlador.embalajeModelo.marcaLegible = valor;
    grupoPregunta2 = valor;
    update(['idPregunta2']);
  }

  set setGrupoPregunta3(valor) {
    controlador.embalajeModelo.ausenciaDanoInsectos = valor;
    grupoPregunta3 = valor;
    update(['idPregunta3']);
  }

  set setGrupoPregunta4(valor) {
    controlador.embalajeModelo.ausenciaInsectosVivos = valor;
    grupoPregunta4 = valor;
    update(['idPregunta4']);
  }

  set setGrupoPregunta5(valor) {
    controlador.embalajeModelo.ausenciaCorteza = valor;
    grupoPregunta5 = valor;
    update(['idPregunta5']);
  }

  bool validarIncumplimiento() {
    bool incumple = false;
    if (grupoPregunta1 == 'No' ||
        grupoPregunta2 == 'No' ||
        grupoPregunta3 == 'No' ||
        grupoPregunta4 == 'No' ||
        grupoPregunta5 == 'No') {
      incumple = true;
    }
    return incumple;
  }

  bool validarFormulario() {
    bool esValido = true;

    if (grupoPregunta1 == null) {
      errorPregunta1 = true;
      esValido = false;
    } else {
      errorPregunta1 = false;
    }

    if (grupoPregunta2 == null) {
      errorPregunta2 = true;
      esValido = false;
    } else {
      errorPregunta2 = false;
    }

    if (grupoPregunta3 == null) {
      errorPregunta3 = true;
      esValido = false;
    } else {
      errorPregunta3 = false;
    }

    if (grupoPregunta4 == null) {
      errorPregunta4 = true;
      esValido = false;
    } else {
      errorPregunta4 = false;
    }

    if (grupoPregunta5 == null) {
      errorPregunta5 = true;
      esValido = false;
    } else {
      errorPregunta5 = false;
    }

    update([
      'idPregunta1',
      'idPregunta2',
      'idPregunta3',
      'idPregunta4',
      'idPregunta5'
    ]);

    return esValido;
  }
}
