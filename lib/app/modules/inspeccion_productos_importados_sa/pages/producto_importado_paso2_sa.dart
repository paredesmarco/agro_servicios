import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_paso2_sa_controller.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/boton_tarjeta.dart';

class ProductoImportadoPaso2Sa extends StatelessWidget {
  const ProductoImportadoPaso2Sa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CuerpoFormularioTabPage(
      children: [NombreSeccion(etiqueta: 'Lote'), _Lotes()],
    );
  }
}

class _Lotes extends GetView<ProductosImportadosPaso2SaController> {
  const _Lotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.listaLote.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 0),
          itemCount: controller.listaLote.length,
          itemBuilder: (context, index) {
            return BotonTarjeta(
              children: [
                TextosBotontarjeta(
                  etiqueta: 'Descripción:',
                  contenido: controller.listaLote[index].descripcion,
                ),
                TextosBotontarjeta(
                  etiqueta: 'Dictamen:',
                  contenido: controller.listaLote[index].dictamen,
                )
              ],
              onPress: () {
                controller.eliminarLote = index;
              },
            );
          },
        );
      } else {
        return SizedBox(
          height: altoPantalla - altoPantalla / 2,
          child: const Center(
            child: Text(
              'Ingrese un lote desde el botón "+"',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    });
  }
}
