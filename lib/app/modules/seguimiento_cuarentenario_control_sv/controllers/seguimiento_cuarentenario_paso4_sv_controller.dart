import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_sv_controller.dart';
import 'package:get/get.dart';

class SeguimientoCuarentenarioPaso4vController extends GetxController {
  final _controlador = Get.find<SeguimientoCuarentenarioSvController>();

  String? errorNumeroPlantas;
  String? errorObservaciones;

  RxString resultadoInspeccionRx = ''.obs;
  bool errorResultado = false;

  set resultadoInspeccion(valor) {
    resultadoInspeccionRx.value = valor;
    _controlador.seguimientoModelo.resultadoInspeccion = valor;
  }

  set numeroPlantasInspeccion(valor) =>
      _controlador.seguimientoModelo.numeroPlantasInspeccion = valor;

  set observaciones(valor) =>
      _controlador.seguimientoModelo.observaciones = valor;

  bool validarFormulario() {
    bool esValido = true;

    if (_controlador.seguimientoModelo.resultadoInspeccion == null ||
        _controlador.seguimientoModelo.resultadoInspeccion == '') {
      esValido = false;
      errorResultado = true;
    } else {
      errorResultado = false;
    }

    if (_controlador.seguimientoModelo.numeroPlantasInspeccion == null ||
        _controlador.seguimientoModelo.numeroPlantasInspeccion == '') {
      esValido = false;
      errorNumeroPlantas = CAMPO_REQUERIDO;
    } else {
      errorNumeroPlantas = null;
    }

    if (_controlador.seguimientoModelo.observaciones == null ||
        _controlador.seguimientoModelo.observaciones == '') {
      esValido = false;
      errorObservaciones = CAMPO_REQUERIDO;
    } else {
      errorObservaciones = null;
    }

    update(['idValidacion', 'idResultado']);

    return esValido;
  }
}
