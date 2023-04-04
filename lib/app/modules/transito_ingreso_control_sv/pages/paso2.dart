import 'package:agro_servicios/app/core/widgets/boton_tarjeta_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_control_sv_controller.dart';
import 'package:agro_servicios/app/utils/medidas.dart';

class IngresoControlSvPaso2 extends StatefulWidget {
  const IngresoControlSvPaso2({Key? key}) : super(key: key);

  @override
  State<IngresoControlSvPaso2> createState() => _IngresoControlSvPaso1State();
}

class _IngresoControlSvPaso1State extends State<IngresoControlSvPaso2>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(
          etiqueta:
              'Datos de las plantas, productos vegetales y artículos reglamentarios',
        ),
        Espaciador(alto: 20),
        _Productos()
      ],
    );
  }
}

class _Productos extends GetView<TransitoIngresoControlSvController> {
  const _Productos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.listaProductoModelo.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 0),
          itemCount: controller.listaProductoModelo.length,
          itemBuilder: (context, index) {
            return BotonTarjetaPopup(
              idHero: 'idBoton$index',
              childrenBoton: [
                TextosBotontarjetaPopup(
                  etiqueta: 'Partida',
                  contenido:
                      controller.listaProductoModelo[index].partidaArancelaria,
                ),
                TextosBotontarjetaPopup(
                  etiqueta: 'Descripción',
                  contenido:
                      controller.listaProductoModelo[index].descripcionProducto,
                ),
              ],
              childrenPopup: [
                TextosTarjetaPopup(
                  etiqueta: 'Partida arancelaria:',
                  contenido:
                      controller.listaProductoModelo[index].partidaArancelaria,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Descripción:',
                  contenido:
                      controller.listaProductoModelo[index].descripcionProducto,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Cantidad (Kg):',
                  contenido:
                      controller.listaProductoModelo[index].cantidad.toString(),
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Tipo de envase:',
                  contenido: controller.listaProductoModelo[index].tipoEnvase,
                )
              ],
              onPress: () => controller.eliminarItemProducto(index),
            );
          },
        );
      } else {
        return SizedBox(
          height: altoPantalla - altoPantalla / 2,
          child: const Center(
            child: Text('Ingrese un producto desde el botón "+"'),
          ),
        );
      }
    });
  }
}
