import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_datos_trampa_controller.dart';
import 'package:get/get.dart';

class TrampeoMfSvDatosTrampaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrampeoMfSvDatosTrampaController(), fenix: true);
  }
}
