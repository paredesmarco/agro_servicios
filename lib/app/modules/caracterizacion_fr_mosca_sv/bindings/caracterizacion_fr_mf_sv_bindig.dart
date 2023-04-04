import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_controller.dart';
import 'package:agro_servicios/app/data/provider/ws/caracterizacion_mf_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_caracterizacion_fr_mf_sv_provider.dart';
import 'package:agro_servicios/app/data/repository/caracterizacion_fr_mf_sv_repository.dart';
import 'package:get/get.dart';

class CaracterizacionFrMfSvBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaracterizacionFrMfSvController>(
        () => CaracterizacionFrMfSvController());

    Get.lazyPut<CaracterizacionFrMfSvRepository>(
        () => CaracterizacionFrMfSvRepository());

    Get.lazyPut<CaracterizacionFrMfSvProvider>(
        () => CaracterizacionFrMfSvProvider());

    Get.lazyPut<DBCaracterizacionFrMfSvProvider>(
        () => DBCaracterizacionFrMfSvProvider());
  }
}
