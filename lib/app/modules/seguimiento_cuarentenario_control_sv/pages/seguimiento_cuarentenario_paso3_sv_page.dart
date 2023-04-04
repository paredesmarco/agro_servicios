import 'package:agro_servicios/app/core/widgets/boton_tarjeta_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso3_sv_controller.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/common/comunes.dart';

class SeguimientoCuarentenarioPaso3SvPage extends StatefulWidget {
  const SeguimientoCuarentenarioPaso3SvPage({Key? key}) : super(key: key);

  @override
  State<SeguimientoCuarentenarioPaso3SvPage> createState() =>
      _SeguimientoCuarentenarioPaso3SvPageState();
}

class _SeguimientoCuarentenarioPaso3SvPageState
    extends State<SeguimientoCuarentenarioPaso3SvPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Orden de Trabajo de laboratorio'),
        _EnvioMuestra(),
        _OrdenesLaboratorio(),
      ],
    );
  }
}

class _EnvioMuestra extends StatelessWidget {
  const _EnvioMuestra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 15),
        const Text('Envío de muestra de laboratorio',
            style: EstilosTextos.etiquetasInputs),
        GetBuilder<SeguimientoCuarentenarioPaso3vController>(
          id: 'idEnvioMuestra',
          builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Si',
                      groupValue: _.envioMuestra.value,
                      onChanged: (dynamic valor) {
                        _.envioMuestra = valor;
                      },
                    ),
                    const Text('Si', style: EstilosTextos.radioYcheckbox),
                    Radio(
                      value: 'No',
                      groupValue: _.envioMuestra.value,
                      onChanged: (dynamic valor) {
                        _.envioMuestra = valor;
                      },
                    ),
                    const Text('No', style: EstilosTextos.radioYcheckbox),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _OrdenesLaboratorio
    extends GetView<SeguimientoCuarentenarioPaso3vController> {
  const _OrdenesLaboratorio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.envioMuestra.value == 'Si' &&
          controller.listaLaboratorio.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 0),
          itemCount: controller.listaLaboratorio.length,
          itemBuilder: (context, index) {
            return BotonTarjetaPopup(
              idHero: 'idBoton$index',
              childrenBoton: [
                TextosBotontarjetaPopup(
                  etiqueta: 'Código muestra:',
                  contenido: controller.listaLaboratorio[index].codigoMuestra,
                ),
                TextosBotontarjetaPopup(
                  etiqueta: 'Tipo muestra:',
                  contenido: controller.listaLaboratorio[index].tipoMuestra,
                )
              ],
              childrenPopup: [
                TextosTarjetaPopup(
                  etiqueta: CODIGO_MUESTRA,
                  contenido: controller.listaLaboratorio[index].codigoMuestra,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Tipo de muestra',
                  contenido: controller.listaLaboratorio[index].tipoMuestra,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Aplicación de producto químico',
                  contenido: controller
                      .listaLaboratorio[index].aplicacionProductoQuimico,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Prediagnóstico',
                  contenido: controller.listaLaboratorio[index].prediagnostico,
                ),
              ],
              onPress: () => controller.eliminarIndex = index,
            );
          },
        );
      } else if (controller.envioMuestra.value == 'Si' &&
          controller.listaLaboratorio.isEmpty) {
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
    });
  }
}
