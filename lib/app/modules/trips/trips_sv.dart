import 'package:agro_servicios/app/modules/trips/pages/trips_sincronizar_sv.dart';
import 'pages/trips_form_sv.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripsSv extends StatelessWidget {
  const TripsSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrLogin = Get.find<LoginController>();
    if (ctrLogin.online) return TripsSincronizarSv();
    return const TripsFormSv();
  }
}
