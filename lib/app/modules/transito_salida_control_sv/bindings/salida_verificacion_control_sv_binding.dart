import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/transito_salida_control_sv/controllers/salida_verificacion_control_sv_controller.dart';

class SalidaVerificacionContrlSvBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalidaVerificacionControlSvController>(
        () => SalidaVerificacionControlSvController());
  }
}
