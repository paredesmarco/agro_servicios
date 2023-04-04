import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_control_sv_controller.dart';
import 'package:get/get.dart';

class EmbalajeDictamenControlSvController extends GetxController {
  final controlador = Get.find<EmbalajeControlSvController>();
  RxString dictamen = ''.obs;
  RxBool errorDictamen = false.obs;

  set setDictamen(valor) {
    dictamen.value = valor;
    controlador.embalajeModelo.dictamenFinal = valor;
  }

  bool validarFormulario() {
    bool esValido = true;

    if (dictamen.value == '') {
      errorDictamen.value = true;
      esValido = false;
    } else {
      errorDictamen.value = false;
    }

    return esValido;
  }
}
