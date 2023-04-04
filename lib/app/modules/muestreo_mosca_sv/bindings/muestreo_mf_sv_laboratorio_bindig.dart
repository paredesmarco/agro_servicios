import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_laboratorio_ingreso_controller.dart';
import 'package:get/get.dart';

class MuestreoMfSvLaboratorioBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MuestreoMfSvLaboratorioIngresoController>(
        () => MuestreoMfSvLaboratorioIngresoController(),
        fenix: true);
  }
}
