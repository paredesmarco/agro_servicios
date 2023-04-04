import 'package:agro_servicios/app/core/widgets/boton_tarjeta_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_controller.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/common/comunes.dart';

class TrampeoMfPaso2 extends StatelessWidget {
  TrampeoMfPaso2({Key? key}) : super(key: key);

  final ctrTrampeo = Get.find<TrampeoMfSvController>();

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Espaciador(
              alto: altoPantalla * 0.02,
            ),
            const Text(
              'Orden de trabajo de laboratorio',
              style: TextStyle(fontSize: 18, color: Color(0xFF69949C)),
            ),
            const Espaciador(alto: 15),
            _ordenesLaboratorio(),
          ],
        ),
      ),
    );
  }

  Widget _ordenesLaboratorio() {
    return Obx(
      () {
        if (ctrTrampeo.cantidadOrdenes > 0) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: ctrTrampeo.cantidadOrdenes.value,
            itemBuilder: (context, index) {
              return SizedBox(
                width: anchoPantalla * 0.9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BotonTarjetaPopup(
                    idHero: 'idBoton$index',
                    childrenBoton: [
                      TextosBotontarjetaPopup(
                        etiqueta: 'Orden:',
                        contenido: ctrTrampeo
                            .listaOrdenesLaboratorio[index].codigoMuestra,
                      ),
                      TextosBotontarjetaPopup(
                        etiqueta: 'Tipo:',
                        contenido:
                            '${ctrTrampeo.listaOrdenesLaboratorio[index].codigoTrampaPadre} - ${ctrTrampeo.listaOrdenesLaboratorio[index].tipoMuestra}',
                      ),
                    ],
                    childrenPopup: [
                      TextosTarjetaPopup(
                        etiqueta: 'Código de la trampa:',
                        contenido: ctrTrampeo
                            .listaOrdenesLaboratorio[index].codigoTrampaPadre,
                      ),
                      TextosTarjetaPopup(
                        etiqueta: '$CODIGO_MUESTRA:',
                        contenido: ctrTrampeo
                            .listaOrdenesLaboratorio[index].codigoMuestra,
                      ),
                      TextosTarjetaPopup(
                        etiqueta: 'Tipo de muestra:',
                        contenido: ctrTrampeo
                            .listaOrdenesLaboratorio[index].tipoMuestra,
                      ),
                      TextosTarjetaPopup(
                        etiqueta: 'Análisis:',
                        contenido: ctrTrampeo
                                .listaOrdenesLaboratorio[index].analisis ??
                            'N/A',
                      ),
                    ],
                    onPress: () => ctrTrampeo.eliminarOrdenLaboratorio(index),
                  ),
                ),
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
