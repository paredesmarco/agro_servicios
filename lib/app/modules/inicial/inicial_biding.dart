import 'package:agro_servicios/app/modules/registroInformacion/controllers/registroInformacionController.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:agro_servicios/app/data/repository/login_repository.dart';
import 'package:agro_servicios/app/data/repository/home_repository.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/data/provider/ws/uath_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_uath_provider.dart';

class InicialBinding implements Bindings {
  @override
  void dependencies() {
    /**
     * Providers
     */
    Get.lazyPut<DBLocalizacionProvider>(() => DBLocalizacionProvider(),
        fenix: true);
    Get.lazyPut<LoginProvider>(() => LoginProvider(), fenix: true);
    Get.lazyPut<UathProvider>(() => UathProvider());
    Get.lazyPut<DBUathProvider>(() => DBUathProvider());

    /**
     * Repository
     */
    Get.lazyPut<LoginRepository>(() => LoginRepository(), fenix: true);
    Get.put<HomeRepository>(HomeRepository());

    /**
     * Controladores
     */
    Get.put<LoginController>(LoginController());
    Get.put<RegistroInformacionController>(RegistroInformacionController());
  }
}
