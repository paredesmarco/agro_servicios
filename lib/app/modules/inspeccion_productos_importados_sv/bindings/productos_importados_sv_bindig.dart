import 'package:get/get.dart';

import 'package:agro_servicios/app/data/provider/local/db_productos_importados_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/productos_importados_provider.dart';
import 'package:agro_servicios/app/data/repository/productos_importados_sv_repository.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/seleccion_productos_importados_sv_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_sv_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_lotes_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_orden_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_paso1_sv_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_paso2_sv_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_paso3_sv_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_paso4_sv_controller.dart';

class ProductosImportadosSvBinding implements Bindings {
  @override
  void dependencies() {
    /**
     * Controladores
     */
    Get.lazyPut<ProductosImportadosSvController>(
        () => ProductosImportadosSvController());

    Get.lazyPut<SeleccionRegistroProductosImportadosSvController>(
        () => SeleccionRegistroProductosImportadosSvController());

    Get.lazyPut<ProductosImportadosPaso1SvController>(
        () => ProductosImportadosPaso1SvController());

    Get.lazyPut<ProductosImportadosPaso2SvController>(
        () => ProductosImportadosPaso2SvController());

    Get.lazyPut<ProductosImportadosPaso3SvController>(
        () => ProductosImportadosPaso3SvController());

    Get.lazyPut<ProductosImportadosPaso4SvController>(
        () => ProductosImportadosPaso4SvController());

    Get.lazyPut<ProductosImportadosOrdenController>(
        () => ProductosImportadosOrdenController());

    Get.lazyPut<ProductosImportadosLotesController>(
        () => ProductosImportadosLotesController());

    /**
     * Repository
     */

    Get.lazyPut<ProductosImportadosSvRepository>(
        () => ProductosImportadosSvRepository());

    /**
     * Providers
     */

    // Servicios
    Get.lazyPut<ProductosImportadosProvider>(
        () => ProductosImportadosProvider());
    // Loca
    Get.lazyPut<DBProductosImportadosSvProvider>(
        () => DBProductosImportadosSvProvider());

    Get.lazyPut<DBLocalizacionProvider>(() => DBLocalizacionProvider());
  }
}
