import 'package:agro_servicios/app/core/widgets/boton_tarjeta_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_orden_laboratorio.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/common/comunes.dart';

class OrdenLaboratorio extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const OrdenLaboratorio({Key? key, this.scaffoldKey}) : super(key: key);

  @override
  State<OrdenLaboratorio> createState() => _OrdenLaboratorioState();
}

class _OrdenLaboratorioState extends State<OrdenLaboratorio>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Espaciador(
              alto: altoPantalla * 0.02,
            ),
            Center(
              child: Column(
                children: const [
                  Text(
                    'Orden de trabajo de laboratorio',
                    style: TextStyle(fontSize: 18, color: Color(0xFF69949C)),
                  ),
                ],
              ),
            ),
            const Espaciador(alto: 15),
            Padding(
              padding: EdgeInsets.only(
                  left: anchoPantalla * 0.04, right: anchoPantalla * 0.04),
              child: _buildEnvioLaboratorio(context),
            ),
            _buildObservacion(context),
            const Espaciador(alto: 15),
            Padding(
              padding: EdgeInsets.only(
                  left: anchoPantalla * 0.04, right: anchoPantalla * 0.04),
              child: const Divider(thickness: 1),
            ),
            const Espaciador(alto: 15),
            _ordenesLaboratorio(context),
            const Espaciador(alto: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvioLaboratorio(context) {
    final provider = Provider.of<OrdenLaboratorioSvBloc>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 15),
        const Text('Envío de muestra de laboratorio',
            style: EstilosTextos.etiquetasInputs),
        Selector<OrdenLaboratorioSvBloc, String?>(
          selector: (_, provider) => provider.envioMuestra,
          builder: (_, data, w) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Si',
                      groupValue: provider.envioMuestra,
                      onChanged: (dynamic valor) {
                        provider.setEnvioMuestra = valor;
                      },
                    ),
                    const Text('Si', style: EstilosTextos.radioYcheckbox),
                    Radio(
                      value: 'No',
                      groupValue: provider.envioMuestra,
                      onChanged: (dynamic valor) {
                        provider.setEnvioMuestra = valor;
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

  Widget _buildObservacion(context) {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(
          left: anchoPantalla * 0.04, right: anchoPantalla * 0.04),
      child: CampoTexto(
        label: 'Observación',
        maxLength: 512,
        onChanged: (valor) {
          provider.setObservacion = valor;
        },
      ),
    );
  }

  Widget _ordenesLaboratorio(context) {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Selector<OrdenLaboratorioSvBloc,
        Tuple3<List<OrdenLaboratorioSvModelo>, String?, int>>(
      selector: (_, provider) => Tuple3(
          provider.listaOrdenes as List<OrdenLaboratorioSvModelo>,
          provider.envioMuestra,
          provider.numeroOrdenesAgregadas),
      builder: (_, data, w) {
        if (provider.listaOrdenes.isNotEmpty && data.item2 == 'Si') {
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 0.0),
              itemCount: data.item1.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BotonTarjetaPopup(
                    idHero: 'idBoton$index',
                    onPress: () => provider.eliminarOrdenLaboratorio(index),
                    childrenBoton: [
                      TextosBotontarjetaPopup(
                        etiqueta: 'Código Muestra:',
                        contenido: data.item1[index].codigoMuestra!,
                      ),
                      TextosBotontarjetaPopup(
                        etiqueta: 'Tipo:',
                        contenido: data.item1[index].tipoMuestra!,
                      ),
                    ],
                    childrenPopup: [
                      TextosTarjetaPopup(
                        etiqueta: 'Código de campo de la muestra:',
                        contenido: data.item1[index].codigoMuestra!,
                      ),
                      TextosTarjetaPopup(
                        etiqueta: 'Tipo de muestra:',
                        contenido: data.item1[index].tipoMuestra!,
                      ),
                      TextosTarjetaPopup(
                        etiqueta: 'Conservación de la muestra:',
                        contenido: data.item1[index].conservacion!,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return _buildMensajeInicial(context);
      },
    );
  }

  Widget _buildMensajeInicial(context) {
    return Selector<OrdenLaboratorioSvBloc, String?>(
      selector: (_, p) => p.envioMuestra,
      builder: (_, data, w) {
        if (data == 'Si') {
          return Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                color: Colors.transparent,
                height: altoPantalla - altoPantalla / 1.2,
                child: Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: anchoPantalla * 0.03),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        INGRESAR_ORDEN_LAB,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
