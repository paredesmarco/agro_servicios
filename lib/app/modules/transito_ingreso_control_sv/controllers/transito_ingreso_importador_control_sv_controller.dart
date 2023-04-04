import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_control_sv_controller.dart';
import 'package:get/get.dart';

class TransitoIngresoImportadorControlSvController extends GetxController {
  final _controlador = Get.find<TransitoIngresoControlSvController>();
  String? errorNombre;
  String? errorRuc;

  set nombre(valor) => _controlador.ingresoModelo.nombreRazonSocial = valor;

  set ruc(valor) => _controlador.ingresoModelo.rucCi = valor.toString();

  bool validarFormulario() {
    bool esValido = true;

    if (_controlador.ingresoModelo.nombreRazonSocial == null ||
        _controlador.ingresoModelo.nombreRazonSocial == '') {
      esValido = false;
      errorNombre = CAMPO_REQUERIDO;
    } else {
      errorNombre = null;
    }

    if (_controlador.ingresoModelo.rucCi == null ||
        _controlador.ingresoModelo.rucCi == '') {
      esValido = false;
      errorRuc = CAMPO_REQUERIDO;
    } else {
      errorRuc = null;
    }

    update(['idValidacion']);

    return esValido;
  }
}
