import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/contenedor_sin_registros.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/widgets/tarjeta_registros.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/controllers/seleccion_registro_salida_control_sv_controller.dart';

class SeleccionRegistroSalidaControlSv
    extends GetView<SeleccionRegistroSalidaControlSvController> {
  const SeleccionRegistroSalidaControlSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CuerpoFormularioIngreso(
      titulo: 'Formularios',
      widgets: [_Registros()],
    );
  }
}

class _Registros extends GetView<SeleccionRegistroSalidaControlSvController> {
  const _Registros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.registrosIngreso.isEmpty) {
        return const ContenedorSinRegistros();
      }
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 0),
        shrinkWrap: true,
        itemCount: controller.registrosIngreso.length,
        itemBuilder: (context, index) {
          return TarjetaRegistros(
            registro: controller.registrosIngreso[index],
          );
        },
      );
    });
  }
}
