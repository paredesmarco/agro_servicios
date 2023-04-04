import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

mostrarModalBottomSheet(
    {BuildContext? context,
    required String titulo,
    required Widget icono,
    required Widget mensaje,
    bool mostrarBotones = false,
    VoidCallback? bajarDatos,
    double alto = 200}) {
  if (!mostrarBotones) {
    Get.bottomSheet(
      Modal(titulo: titulo, mensaje: mensaje, icono: icono),
      shape: Modal.borde(),
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: false,
    );
  } else {
    Get.bottomSheet(
      Modal(
        titulo: titulo,
        mensaje: mensaje,
        icono: icono,
        alto: alto,
        mostrarBotones: mostrarBotones,
        bajarDatos: bajarDatos,
      ),
      shape: Modal.borde(),
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: true,
    );
  }
}
