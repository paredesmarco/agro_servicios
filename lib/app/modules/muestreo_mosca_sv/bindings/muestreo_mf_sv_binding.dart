import 'package:get/get.dart';

import 'package:agro_servicios/app/data/provider/ws/muestreo_mf_sv_provider.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_controller.dart';
import 'package:agro_servicios/app/data/provider/local/db_muestreo_mf_sv_provider.dart';
import 'package:agro_servicios/app/data/repository/muestreo_mf_sv_repository.dart';

class MuestreoMfSvBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MuestreoMfSvController>(() => MuestreoMfSvController());
    Get.lazyPut<MuestreoMfSvRepository>(() => MuestreoMfSvRepository());
    Get.lazyPut<DBMuestreoMfSvProvider>(() => DBMuestreoMfSvProvider());
    Get.lazyPut<MuestreoMfSvProvider>(() => MuestreoMfSvProvider());
  }
}
