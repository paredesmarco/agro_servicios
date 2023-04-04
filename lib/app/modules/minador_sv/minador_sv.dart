import 'package:agro_servicios/app/modules/minador_sv/pages/minador_sincronizar_sv.dart';
import 'pages/minador_form_sv.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MinadorSv extends StatelessWidget {
  const MinadorSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrLogin = Get.find<LoginController>();
    // if (ctrLogin.online) return const MinadorFormSv();
    // return MinadorSincronizarSv();
    if (ctrLogin.online) return MinadorSincronizarSv();
    return const MinadorFormSv();
  }
}
