import 'package:agro_servicios/app/data/provider/local/db_ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_trips_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/trips_sv_provider.dart';
import 'package:agro_servicios/app/data/repository/trips_sv_repository.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_form_sv_controller.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_sincronizar_controller.dart';
import 'package:get/get.dart';

class TripsSincronizarBinding implements Bindings {
  @override
  void dependencies() {
    /**
     * Controladores
     */
    Get.lazyPut<TripsFormSvController>(() => TripsFormSvController());
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

    /**
     * Repository
     */
    Get.lazyPut<TripsRepository>(() => TripsRepository());
  }
}
