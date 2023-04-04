import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/pages/nuevo_caracterizacion_fr_mf_sv.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/pages/sincronizacion_caracterizacion_fr_mf_sv.dart';

class CaracterizacionFrMfSv extends StatelessWidget {
  CaracterizacionFrMfSv({Key? key}) : super(key: key);

  final controlador = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    if (controlador.online) return CaracterizacionFrMfSvSincronizacion();
    return CaracterizacionFrMfSvNuevo();
  }
}
