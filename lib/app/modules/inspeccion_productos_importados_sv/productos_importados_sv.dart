import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/pages/productos_importados_registros_sv.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/pages/sincronizacion_productos_importados_sv.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';

class ProductosImportadosSv extends StatelessWidget {
  const ProductosImportadosSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.find<LoginController>().online) {
      return const SincronizacionProductosImportadosSv();
    } else {
      return const ProductosImportadosSeleccionRegistrolSv();
    }
  }
}
