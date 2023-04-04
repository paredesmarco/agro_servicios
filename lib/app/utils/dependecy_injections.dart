import 'package:agro_servicios/app/core/controllers/sincronizacion_controller.dart';
import 'package:agro_servicios/app/data/provider/ws/localizacion_provider.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';

import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_cultivo_controller.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_productor_controller.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_ubicacion_controller.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_laboratorio_controller.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_ubicacion_controller.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_lugar_controller.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_pasos_controller.dart';

class DependecyInjections {
  static void init() {
    /**
     * Local provider 
     */

    Get.lazyPut<DBHomeProvider>(() => DBHomeProvider.db, fenix: true);

    /**
     * WS provider 
     */

    Get.lazyPut<LocalizacionProvider>(() => LocalizacionProvider(),
        fenix: true);

    /**
    * Controllers
    */

    Get.lazyPut<SincronizacionController>(() => SincronizacionController(),
        fenix: true);

    Get.lazyPut<TrampeoMfSvLugarController>(() => TrampeoMfSvLugarController(),
        fenix: true);

    Get.lazyPut<TrampeoMfSvTrampasController>(
        () => TrampeoMfSvTrampasController(),
        fenix: true);

    Get.lazyPut<MuestreoMfSvUbicacionController>(
        () => MuestreoMfSvUbicacionController(),
        fenix: true);

    Get.lazyPut<MuestreoMfSvLaboratorioController>(
        () => MuestreoMfSvLaboratorioController(),
        fenix: true);

    Get.lazyPut<CaracterizacionFrMfSvProductorController>(
        () => CaracterizacionFrMfSvProductorController(),
        fenix: true);

    Get.lazyPut<CaracterizacionFrMfSvUbicacionController>(
        () => CaracterizacionFrMfSvUbicacionController(),
        fenix: true);

    Get.lazyPut<CaracterizacionFrMfSvCultivoController>(
        () => CaracterizacionFrMfSvCultivoController(),
        fenix: true);
  }
}
