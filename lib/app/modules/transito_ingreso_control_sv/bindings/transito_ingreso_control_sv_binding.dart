import 'package:agro_servicios/app/data/provider/local/db_transito_ingreso_control_sv_provider.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_importador_control_sv_controller.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/data/provider/local/db_puertos_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_requisitos_transito_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/transito_ingreso_control_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_tipos_envase.dart';
import 'package:agro_servicios/app/data/provider/ws/puertos_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/requisitos_provider.dart';
import 'package:agro_servicios/app/data/repository/transito_ingreso_control_sv_repository.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_internacional_sv_controller.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_control_sv_controller.dart';

class IngresoControlSvBinding implements Bindings {
  @override
  void dependencies() {
    /**
     * Controllers
     */
    Get.lazyPut<TransitoIngresoControlSvController>(
        () => TransitoIngresoControlSvController());
    Get.lazyPut<TransitoIngresoInternacionalControlSvController>(
        () => TransitoIngresoInternacionalControlSvController());
    Get.lazyPut<TransitoIngresoImportadorControlSvController>(
        () => TransitoIngresoImportadorControlSvController());

    /**
   * Repository
   */
    Get.lazyPut<TransitoIngresoControlSvRepository>(
        () => TransitoIngresoControlSvRepository());

    /**
   * Providers
   */
    Get.lazyPut<TransitoIngresoControlSvProvider>(
        () => TransitoIngresoControlSvProvider());
    Get.lazyPut<PuertosProvider>(() => PuertosProvider());
    Get.lazyPut<RequisitosProvider>(() => RequisitosProvider());
    Get.lazyPut<DBTiposEnvaseProvider>(() => DBTiposEnvaseProvider());
    Get.lazyPut<DBRequistosTransitoProvider>(
        () => DBRequistosTransitoProvider());
    Get.lazyPut<DBPuertosProvider>(() => DBPuertosProvider());
    Get.lazyPut<DBTransitoIngresoControlSvProvider>(
        () => DBTransitoIngresoControlSvProvider());
  }
}
