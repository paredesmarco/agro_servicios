import 'package:agro_servicios/app/data/provider/local/db_ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_respuestas_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_minador_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/respuestas_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/minador_sv_provider.dart';
import 'package:agro_servicios/app/data/repository/minador_sv_repository.dart';
import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_form_sv_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_paso2_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_paso3_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_sincronizar_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_paso1_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_ver_controller.dart';
import 'package:get/get.dart';

class MinadorBinding implements Bindings {
  @override
  void dependencies() {
    /**
     * Controladores
     */
    Get.lazyPut<MinadorFormSvController>(() => MinadorFormSvController());
    Get.lazyPut<MinadorPaso1Controller>(() => MinadorPaso1Controller());
    Get.lazyPut<MinadorPaso2Controller>(() => MinadorPaso2Controller());
    Get.lazyPut<MinadorPaso3Controller>(() => MinadorPaso3Controller());
    Get.lazyPut<MinadorVerController>(() => MinadorVerController());
    Get.lazyPut<MinadorSincronizarController>(
        () => MinadorSincronizarController());
    /**
     * Providers
     */
    Get.lazyPut<DBMinadorProvider>(() => DBMinadorProvider.db);
    Get.lazyPut<MinadorProvider>(() => MinadorProvider());

    Get.lazyPut<DBPreguntasProvider>(() => DBPreguntasProvider.db);
    Get.lazyPut<PreguntasProvider>(() => PreguntasProvider());
    Get.lazyPut<DBPonderacionProvider>(() => DBPonderacionProvider.db);
    Get.lazyPut<PonderacionProvider>(() => PonderacionProvider());

    Get.lazyPut<DBRespuestasProvider>(() => DBRespuestasProvider.db);
    Get.lazyPut<RespuestasProvider>(() => RespuestasProvider());

    /**
     * Repository
     */
    Get.lazyPut<MinadorRepository>(() => MinadorRepository());
  }
}
