import 'package:agro_servicios/app/data/provider/local/db_ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_respuestas_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_trips_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/respuestas_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/trips_sv_provider.dart';
import 'package:agro_servicios/app/data/repository/trips_sv_repository.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_form_sv_controller.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_paso2_controller.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_paso3_controller.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_sincronizar_controller.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_paso1_controller.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_ver_controller.dart';
import 'package:get/get.dart';

class TripsBinding implements Bindings {
  @override
  void dependencies() {
    /**
     * Controladores
     */
    Get.lazyPut<TripsFormSvController>(() => TripsFormSvController());
    Get.lazyPut<TripsPaso1Controller>(() => TripsPaso1Controller());
    Get.lazyPut<TripsPaso2Controller>(() => TripsPaso2Controller());
    Get.lazyPut<TripsPaso3Controller>(() => TripsPaso3Controller());
    Get.lazyPut<TripsVerController>(() => TripsVerController());
    Get.lazyPut<TripsSincronizarController>(() => TripsSincronizarController());
    /**
     * Providers
     */
    Get.lazyPut<DBTripsProvider>(() => DBTripsProvider());
    Get.lazyPut<TripsProvider>(() => TripsProvider());

    Get.lazyPut<DBPreguntasProvider>(() => DBPreguntasProvider.db);
    Get.lazyPut<PreguntasProvider>(() => PreguntasProvider());
    Get.lazyPut<DBPonderacionProvider>(() => DBPonderacionProvider.db);
    Get.lazyPut<PonderacionProvider>(() => PonderacionProvider());

    Get.lazyPut<DBRespuestasProvider>(() => DBRespuestasProvider.db);
    Get.lazyPut<RespuestasProvider>(() => RespuestasProvider());

    /**
     * Repository
     */
    Get.lazyPut<TripsRepository>(() => TripsRepository());
  }
}
