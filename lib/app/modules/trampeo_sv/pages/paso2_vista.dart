import 'package:agro_servicios/app/core/widgets/boton_tarjeta_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/formulario_orden_trabajo_modelo.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/common/comunes.dart';

class OrdenLaboratorio extends StatelessWidget {
  const OrdenLaboratorio({super.key});
  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Espaciador(
                  alto: altoPantalla * 0.02,
                ),
                const Center(
                  child: Text(
                    'Orden de trabajo de laboratorio',
                    style: TextStyle(fontSize: 18, color: Color(0xFF69949C)),
                  ),
                ),
                const Espaciador(alto: 15),
                Selector<TrampeoBloc,
                    Tuple2<List<OrdenTrabajoLaboratorioModelo>, int>>(
                  selector: (_, provider) => Tuple2(
                      provider.listaMuestraLaboratorio,
                      provider.numeroMuestrasLaboratorioAgregadas),
                  builder: (_, data, w) {
                    if (data.item2 > 0) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 0.0),
                          itemCount: data.item1.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: BotonTarjetaPopup(
                                idHero: 'idBoton$index',
                                childrenBoton: [
                                  TextosBotontarjetaPopup(
                                      etiqueta: 'Orden:',
                                      contenido:
                                          data.item1[index].codigoMuestra),
                                  TextosBotontarjetaPopup(
                                      etiqueta: 'Código Trampa:',
                                      contenido:
                                          data.item1[index].codigoTrampa!),
                                ],
                                childrenPopup: [
                                  TextosTarjetaPopup(
                                    etiqueta: 'Código de la trampa:',
                                    contenido: data.item1[index].codigoTrampa,
                                  ),
                                  TextosTarjetaPopup(
                                    etiqueta: '$CODIGO_MUESTRA:',
                                    contenido: data.item1[index].codigoMuestra,
                                  ),
                                  TextosTarjetaPopup(
                                    etiqueta: 'Tipo de muestra:',
                                    contenido: data.item1[index].tipoMuestra,
                                  ),
                                  TextosTarjetaPopup(
                                    etiqueta: 'Análisis:',
                                    contenido:
                                        data.item1[index].analisis ?? 'N/A',
                                  ),
                                ],
                                onPress: () => context
                                    .read<TrampeoBloc>()
                                    .eliminarOrdenLaboratorio(
                                        index: index,
                                        codigoTrampa:
                                            data.item1[index].codigoTrampa),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Expanded(
                      child: Center(
                        child: Text(
                          INGRESAR_ORDEN_LAB,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
