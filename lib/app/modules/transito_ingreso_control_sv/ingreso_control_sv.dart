import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/pages/nuevo_ingreso_control_sv.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/pages/sincronizacion_ingreso_control_sv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IngresoControlSv extends StatelessWidget {
  IngresoControlSv({Key? key}) : super(key: key);
  final controlador = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    if (controlador.online) return const SincronizacionIngresoControlSv();
    return const NuevoIngresoControlSv();
  }
}
