import 'package:agro_servicios/app/modules/embalaje_control_sv/pages/nuevo_embalaje_control_sv.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/pages/sincronizacion_embalaje_control_sv.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmbaleControlSv extends StatelessWidget {
  const EmbaleControlSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controlador = Get.find<LoginController>();
    if (controlador.online) return const SincronizacionEmbalajeControlSv();
    return EmbalajeControlNuevo();
  }
}
