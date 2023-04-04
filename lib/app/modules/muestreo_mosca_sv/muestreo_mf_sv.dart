import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/pages/nuevo_muestreo_mf_sv.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/pages/sincronizacion_muestreo_mf_sv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MuestreoMfSv extends StatelessWidget {
  MuestreoMfSv({Key? key}) : super(key: key);

  final controlador = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    if (controlador.online) return SincronizacionMuestreoMfSv();
    return MuestreoMfSvNuevo();
  }
}
