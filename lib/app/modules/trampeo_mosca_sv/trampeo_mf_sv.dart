import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/pages/lugar_trampeo_mf_sv.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/pages/sincronizacion_trampeo_mf_sv.dart';

class TrampeoMfSv extends StatelessWidget {
  const TrampeoMfSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controlador = Get.find<LoginController>();

    if (controlador.online) return SincronizacionTrampeoMfSv();
    return const LugarTrampeoMfSv();
  }
}
