import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/pages/transito_salida_seleccion_registro_control_sv.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/pages/transito_salida_sincronizacion_control_sv.dart';

class TransitoSalidaControlSv extends StatelessWidget {
  const TransitoSalidaControlSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controlador = Get.find<LoginController>();
    if (controlador.online) {
      return const TransitoSalidaSincronizacionControlSv();
    }
    return const SeleccionRegistroSalidaControlSv();
  }
}
