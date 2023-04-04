import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_controller.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_laboratorio_controller.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/boton_tarjeta_popup.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';

class MuestreoMfSvPaso2 extends StatelessWidget {
  const MuestreoMfSvPaso2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioTabPage(
      children: <Widget>[
        const NombreSeccion(etiqueta: 'Orden de trabajo de laboratorio'),
        const Espaciador(alto: 20),
        _OrdenesLaboratorio(),
      ],
    );
  }
}

class _OrdenesLaboratorio extends StatelessWidget {
  _OrdenesLaboratorio();
  final controlador = Get.find<MuestreoMfSvLaboratorioController>();
  final ctrMuestreo = Get.find<MuestreoMfSvController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controlador.cantidadOrdenes > 0) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controlador.cantidadOrdenes.value,
            itemBuilder: (context, index) {
              return BotonTarjetaPopup(
                idHero: 'idBoton$index',
                onPress: () => ctrMuestreo.eliminarOrdenLaboratorio(index),
                childrenBoton: [
                  TextosBotontarjetaPopup(
                    etiqueta: 'Código Muestra:',
                    contenido:
                        '${ctrMuestreo.modeloLaboratorio[index].codigoMuestra}',
                  ),
                  TextosBotontarjetaPopup(
                    etiqueta: 'Especie:',
                    contenido:
                        '${ctrMuestreo.modeloLaboratorio[index].especieVegetal}',
                  ),
                ],
                childrenPopup: [
                  TextosTarjetaPopup(
                    etiqueta: 'Código de campo de la muestra:',
                    contenido:
                        ctrMuestreo.modeloLaboratorio[index].codigoMuestra,
                  ),
                  TextosTarjetaPopup(
                    etiqueta: 'Especie vegetal (fruto):',
                    contenido:
                        ctrMuestreo.modeloLaboratorio[index].especieVegetal,
                  ),
                  TextosTarjetaPopup(
                    etiqueta: 'Sitio de muestreo:',
                    contenido:
                        ctrMuestreo.modeloLaboratorio[index].sitioMuestreo,
                  ),
                  TextosTarjetaPopup(
                    etiqueta: 'Número de frutos recolectados:',
                    contenido: ctrMuestreo
                        .modeloLaboratorio[index].numeroFrutosColectados,
                  ),
                ],
              );
            },
          );
        }
        return SizedBox(
          height: altoPantalla - altoPantalla / 2,
          child: const Center(
            child: Text(INGRESAR_ORDEN_LAB),
          ),
        );
      },
    );
  }
}
