import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/pages/productos_importados_registros_sa.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/pages/sincronizacion_productos_importados_sa.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';

class ProductosImportadosSa extends StatelessWidget {
  const ProductosImportadosSa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.find<LoginController>().online) {
      return const SincronizacionProductosImportadosSa();
    } else {
      return const ProductosImportadosSeleccionRegistrolSa();
    }
  }
}
