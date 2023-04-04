import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/pages/seguimiento_cuarentenario_seleccion_registros_sv_page.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/pages/seguimiento_cuarentenario_sincronizacion_sv_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeguimientoCuarentenarioSvPage extends StatelessWidget {
  SeguimientoCuarentenarioSvPage({Key? key}) : super(key: key);

  final controlador = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    if (controlador.online) {
      return const SeguimientoSuarentenarioSincronizacionSvPage();
    }
    return const SeguimientoCuarentenarioSeleccionRegistrosSvPage();
  }
}
