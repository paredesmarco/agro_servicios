import 'package:agro_servicios/app/data/provider/local/db_embalaje_control_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_uath_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/uath_provider.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/data/provider/local/db_puertos_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/embalaje_control_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/puertos_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_lugar_inspeccion_provider.dart';
import 'package:agro_servicios/app/data/repository/embalaje_control_sv_repository.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_dictamen_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_incumplimiento_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_lugar_inspeccion_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_verificacion_control_sv.dart';

class EmbalajeControlBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmbalajeControlSvController>(
        () => EmbalajeControlSvController());

    Get.lazyPut<EmbalajeLugarInspeccionControlSvController>(
        () => EmbalajeLugarInspeccionControlSvController());

    Get.lazyPut<EmbalajeVerificacionControlSvController>(
        () => EmbalajeVerificacionControlSvController());

    Get.lazyPut<EmbalajeIncumplimientoControlSvController>(
        () => EmbalajeIncumplimientoControlSvController());

    Get.lazyPut<EmbalajeDictamenControlSvController>(
        () => EmbalajeDictamenControlSvController());

    Get.lazyPut<EmbalajeControlSvRepository>(
        () => EmbalajeControlSvRepository());

    Get.lazyPut<UathProvider>(() => UathProvider());

    Get.lazyPut<EmbalajeControlProvider>(() => EmbalajeControlProvider());

    Get.lazyPut<PuertosProvider>(() => PuertosProvider());

    Get.lazyPut<DBPuertosProvider>(() => DBPuertosProvider());

    Get.lazyPut<DBLugarInspeccionProvider>(() => DBLugarInspeccionProvider());

    Get.lazyPut<DBEmbalajeControlSvProvider>(
        () => DBEmbalajeControlSvProvider());

    Get.lazyPut<DBUathProvider>(() => DBUathProvider());
  }
}
