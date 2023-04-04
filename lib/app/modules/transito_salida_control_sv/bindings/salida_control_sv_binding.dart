import 'package:agro_servicios/app/modules/transito_salida_control_sv/controllers/seleccion_registro_salida_control_sv_controller.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/data/provider/local/db_transito_salida_control_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/transito_salida_control_provider.dart';
import 'package:agro_servicios/app/data/repository/transito_salida_control_sv_repository.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/controllers/salida_control_sv_controller.dart';

class SalidaControlSvBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalidaControlSvController>(() => SalidaControlSvController());

    Get.lazyPut<SeleccionRegistroSalidaControlSvController>(
        () => SeleccionRegistroSalidaControlSvController());

    Get.lazyPut<TransitoSalidaControlSvProvider>(
        () => TransitoSalidaControlSvProvider());

    Get.lazyPut<DBTransitoSalidaControlSvProvider>(
        () => DBTransitoSalidaControlSvProvider());

    Get.lazyPut<TransitoSalidaControlSvRepository>(
        () => TransitoSalidaControlSvRepository());
  }
}
