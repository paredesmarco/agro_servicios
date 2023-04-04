import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_producto_control_sv_controller.dart';
import 'package:agro_servicios/app/data/repository/transito_ingreso_control_sv_repository.dart';

class IngresoProductoControlSvBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransitoIngresoProductoControlSvController>(
        () => TransitoIngresoProductoControlSvController());

    Get.lazyPut<TransitoIngresoControlSvRepository>(
        () => TransitoIngresoControlSvRepository());
  }
}
