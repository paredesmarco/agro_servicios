import 'package:get/get.dart';

import 'package:agro_servicios/app/data/provider/local/db_productos_importados_sa_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/productos_importados_provider.dart';
import 'package:agro_servicios/app/data/repository/productos_importados_sa_repository.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/seleccion_productos_importados_sa_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_sa_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_lotes_sa_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_orden_sa_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_paso1_sa_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_paso2_sa_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_paso3_sa_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_paso4_sa_controller.dart';

class ProductosImportadosSaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductosImportadosSaController>(
        () => ProductosImportadosSaController());

    Get.lazyPut<SeleccionRegistroProductosImportadosSaController>(
        () => SeleccionRegistroProductosImportadosSaController());

    Get.lazyPut<ProductosImportadosPaso1SaController>(
        () => ProductosImportadosPaso1SaController());

    Get.lazyPut<ProductosImportadosPaso2SaController>(
        () => ProductosImportadosPaso2SaController());

    Get.lazyPut<ProductosImportadosPaso3SaController>(
        () => ProductosImportadosPaso3SaController());

    Get.lazyPut<ProductosImportadosPaso4SaController>(
        () => ProductosImportadosPaso4SaController());

    Get.lazyPut<ProductosImportadosOrdenSaController>(
        () => ProductosImportadosOrdenSaController());

    Get.lazyPut<ProductosImportadosLotesSaController>(
        () => ProductosImportadosLotesSaController());

    Get.lazyPut<ProductosImportadosSaRepository>(
        () => ProductosImportadosSaRepository());

    Get.lazyPut<ProductosImportadosProvider>(
        () => ProductosImportadosProvider());

    Get.lazyPut<DBProductosImportadosSaProvider>(
        () => DBProductosImportadosSaProvider());

    Get.lazyPut<DBLocalizacionProvider>(() => DBLocalizacionProvider());
  }
}
