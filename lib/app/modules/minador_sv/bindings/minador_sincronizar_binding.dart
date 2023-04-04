import 'package:agro_servicios/app/data/provider/local/db_ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_minador_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/minador_sv_provider.dart';
import 'package:agro_servicios/app/data/repository/minador_sv_repository.dart';
import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_form_sv_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_sincronizar_controller.dart';
import 'package:get/get.dart';

class MinadorSincronizarBinding implements Bindings {
  @override
  void dependencies() {
    /**
     * Controladores
     */
    Get.lazyPut<MinadorFormSvController>(() => MinadorFormSvController());
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

    /**
     * Repository
     */
    Get.lazyPut<MinadorRepository>(() => MinadorRepository());
  }
}
