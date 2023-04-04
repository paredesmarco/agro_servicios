import 'package:agro_servicios/app/data/provider/ws/trampeo_mf_sv_provider.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_controller.dart';
import 'package:agro_servicios/app/data/provider/local/db_trampeo_mf_sv_provider.dart';
import 'package:agro_servicios/app/data/repository/trampeo_mf_sv_repository.dart';
import 'package:get/get.dart';

class TrampeoMfSvBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrampeoMfSvController>(() => TrampeoMfSvController(),
        fenix: true);
    Get.lazyPut<TrampeoMfSvRepository>(() => TrampeoMfSvRepository());
    Get.lazyPut<DBTrampeoMfSvProvider>(() => DBTrampeoMfSvProvider());
    Get.lazyPut<TrampeoMfSvProvider>(() => TrampeoMfSvProvider());
  }
}
