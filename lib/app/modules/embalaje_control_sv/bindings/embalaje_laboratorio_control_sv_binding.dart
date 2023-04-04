import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_laboratorio_control_sv_controller.dart';
import 'package:get/get.dart';

class EmbalajeOrdenControlSvBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmbalajeLaboratorioControlSvController>(
        () => EmbalajeLaboratorioControlSvController());
  }
}
