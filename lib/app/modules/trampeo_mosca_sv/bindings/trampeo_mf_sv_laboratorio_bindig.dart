import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_laboratorio_controller.dart';
import 'package:get/get.dart';

class TrampeoMfSvLaboratorioBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrampeoMfSvLaboratorioController>(
        () => TrampeoMfSvLaboratorioController(),
        fenix: true);
  }
}
