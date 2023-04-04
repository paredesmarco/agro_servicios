import 'package:get/get.dart';

import 'package:agro_servicios/app/data/provider/local/db_seguimiento_cuarentenario_sv_provider.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso1_sv_controller.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_seleccion_sv_controller.dart';
import 'package:agro_servicios/app/data/provider/ws/seguimiento_cuarentenario_sv_provider.dart';
import 'package:agro_servicios/app/data/repository/seguimiento_cuarentenario_sv_repository.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_sv_controller.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_laboratorio_sv_controller.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso2_sv_controller.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso3_sv_controller.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso4_sv_controller.dart';

class SeguimientoCuarentenarioSvBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeguimientoCuarentenarioSvController>(
        () => SeguimientoCuarentenarioSvController());

    Get.lazyPut<SeguimientoCuarentenarioSeleccionSvController>(
        () => SeguimientoCuarentenarioSeleccionSvController());

    Get.lazyPut<SeguimientoCuarentenarioPaso1SvController>(
        () => SeguimientoCuarentenarioPaso1SvController());

    Get.lazyPut<SeguimientoCuarentenarioPaso2SvController>(
        () => SeguimientoCuarentenarioPaso2SvController());

    Get.lazyPut<SeguimientoCuarentenarioPaso3vController>(
        () => SeguimientoCuarentenarioPaso3vController());

    Get.lazyPut<SeguimientoCuarentenarioPaso4vController>(
        () => SeguimientoCuarentenarioPaso4vController());

    Get.lazyPut<SeguimientoCuarentenarioLaboratorioSvController>(
        () => SeguimientoCuarentenarioLaboratorioSvController());

    Get.lazyPut<SeguimientoCuarentenarioSvRepository>(
        () => SeguimientoCuarentenarioSvRepository());

    Get.lazyPut<SeguimientoCuarentenarioSvProvider>(
        () => SeguimientoCuarentenarioSvProvider());

    Get.lazyPut<DBSeguimientoCuarentenarioProvider>(
        () => DBSeguimientoCuarentenarioProvider());
  }
}
