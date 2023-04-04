import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_paso3_sv_controller.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/core/widgets/boton_tarjeta_popup.dart';

class ProductoImportadoPaso3Sv extends StatefulWidget {
  const ProductoImportadoPaso3Sv({Key? key}) : super(key: key);

  @override
  State<ProductoImportadoPaso3Sv> createState() =>
      _ProductoImportadoPaso3SvState();
}

class _ProductoImportadoPaso3SvState extends State<ProductoImportadoPaso3Sv>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Orden de trabajo de laboratorio'),
        _OrdenLaboratorio(),
        _OrdenesLaboratorio(),
      ],
    );
  }
}

class _OrdenLaboratorio extends StatelessWidget {
  const _OrdenLaboratorio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Envío de muestra a laboratorio',
        ),
        GetBuilder<ProductosImportadosPaso3SvController>(
          id: 'idOrdenLaboratorio',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.ordenLaboratorio,
                  onChanged: (String? valor) => _.setOrdenLaboratorio = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.ordenLaboratorio,
                  onChanged: (String? valor) => _.setOrdenLaboratorio = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                // if (_.sinCambioTrampa == true) _mensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _OrdenesLaboratorio
    extends GetView<ProductosImportadosPaso3SvController> {
  const _OrdenesLaboratorio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.listaOrdenes.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 0),
          itemCount: controller.listaOrdenes.length,
          itemBuilder: (context, index) {
            return BotonTarjetaPopup(
              idHero: 'idBoton$index',
              onPress: () => controller.eliminarLote = index,
              childrenBoton: [
                TextosBotontarjetaPopup(
                  etiqueta: 'Producto:',
                  contenido: controller.listaOrdenes[index].nombreProducto,
                ),
                TextosBotontarjetaPopup(
                  etiqueta: 'Código Muestra:',
                  contenido: controller.listaOrdenes[index].codigoMuestra,
                ),
              ],
              childrenPopup: [
                TextosTarjetaPopup(
                  etiqueta: 'Producto:',
                  contenido: controller.listaOrdenes[index].nombreProducto!,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Código de campo de la muestra:',
                  contenido: controller.listaOrdenes[index].codigoMuestra!,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Peso de la muestra:',
                  contenido: controller.listaOrdenes[index].pesoMuestra!,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Prediagnóstico:',
                  contenido: controller.listaOrdenes[index].prediagnostico!,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Fase fenólogica producto:',
                  contenido: controller.listaOrdenes[index].faseFenologica!,
                ),
              ],
            );
          },
        );
      } else {
        if (controller.envioMuesta.value) {
          return SizedBox(
            height: altoPantalla - altoPantalla / 2,
            child: const Center(
              child: Text(
                INGRESAR_ORDEN_LAB,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return Container();
      }
    });
  }
}
