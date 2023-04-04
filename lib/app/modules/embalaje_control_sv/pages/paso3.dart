import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_incumplimiento_control_sv_controller.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/boton_tarjeta_popup.dart';

class EmbalajeControlPaso3 extends StatefulWidget {
  const EmbalajeControlPaso3({Key? key}) : super(key: key);

  @override
  State<EmbalajeControlPaso3> createState() => _EmbalajeControlPaso3State();
}

class _EmbalajeControlPaso3State extends State<EmbalajeControlPaso3>
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
                'Datos requeridos en caso de detección de incumplimiento'),
        _RazonSocial(),
        _Manifiesto(),
        _Producto(),
        _EnvioMuestra(),
        _SeccionOrdenLaboratorio(),
        _OrdenLaboratorio(),
      ],
    );
  }
}

class _RazonSocial extends StatelessWidget {
  const _RazonSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeIncumplimientoControlSvController>(
      id: 'idRazonSocial',
      builder: (_) {
        return CampoTexto(
          maxLength: 250,
          errorText: _.errorRazonSocial,
          onChanged: (valor) => _.razonSocial = valor,
          label: 'Razón social del importador',
        );
      },
    );
  }
}

class _Manifiesto extends StatelessWidget {
  const _Manifiesto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeIncumplimientoControlSvController>(
      id: 'idManifiesto',
      builder: (_) {
        return CampoTexto(
          maxLength: 250,
          errorText: _.errorManiifiestoCarga,
          onChanged: (valor) => _.manifiestoCarga = valor,
          label: 'B/L/Manifiesto de carga/Guía de área',
        );
      },
    );
  }
}

class _Producto extends StatelessWidget {
  const _Producto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeIncumplimientoControlSvController>(
      id: 'idProducto',
      builder: (_) {
        return CampoTexto(
          maxLength: 250,
          errorText: _.errorProducto,
          onChanged: (valor) => _.producto = valor,
          label: 'Producto',
        );
      },
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
        Text('Envío de muestra a laboratorio', style: _labelStyle()),
        GetBuilder<EmbalajeIncumplimientoControlSvController>(
          id: 'idMuestra',
          builder: (_) {
            return Row(
              children: [
                Radio(
                    value: 'Si',
                    groupValue: _.envioMuestra,
                    onChanged: (valor) {
                      _.envioMuestra = valor;
                      Get.find<EmbalajeControlSvController>().setTieneMuestra =
                          true;
                    }),
                const Text('Si', style: TextStyle(color: Color(0xFF75808f))),
                Radio(
                    value: 'No',
                    groupValue: _.envioMuestra,
                    onChanged: (valor) {
                      _.envioMuestra = valor;
                      Get.find<EmbalajeControlSvController>().setTieneMuestra =
                          false;
                    }),
                const Text('No', style: TextStyle(color: Color(0xFF75808f)))
              ],
            );
          },
        ),
      ],
    );
  }

  TextStyle _labelStyle() {
    return TextStyle(fontSize: 13, color: Colors.grey[500]);
  }
}

class _SeccionOrdenLaboratorio
    extends GetView<EmbalajeIncumplimientoControlSvController> {
  const _SeccionOrdenLaboratorio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: controller.tieneMuestra.value,
        child: const NombreSeccion(etiqueta: 'Orden de trabajo de laboratorio'),
      );
    });
  }
}

class _OrdenLaboratorio
    extends GetView<EmbalajeIncumplimientoControlSvController> {
  const _OrdenLaboratorio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.tieneMuestra.value == true &&
          controller.listaLaboratorio.isNotEmpty) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10),
          itemCount: controller.listaLaboratorio.length,
          itemBuilder: (_, index) {
            return BotonTarjetaPopup(
              idHero: 'idBoton$index',
              childrenBoton: [
                TextosBotontarjetaPopup(
                  etiqueta: 'Orden:',
                  contenido: controller.listaLaboratorio[index].codigoMuestra,
                ),
                TextosBotontarjetaPopup(
                  etiqueta: 'PM:',
                  contenido: controller.listaLaboratorio[index].pesoMuestra,
                ),
                TextosBotontarjetaPopup(
                  etiqueta: 'Prediagnóstico:',
                  contenido: controller.listaLaboratorio[index].prediagnostico,
                ),
              ],
              childrenPopup: [
                TextosTarjetaPopup(
                  etiqueta: 'Producto',
                  contenido: controller.listaLaboratorio[index].nombreProducto,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Código de muestra de laboratorio',
                  contenido: controller.listaLaboratorio[index].codigoMuestra,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Conservación de la muestra',
                  contenido: controller.listaLaboratorio[index].conservacion,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Actividad de origen',
                  contenido: controller.listaLaboratorio[index].actividadOrigen,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Peso',
                  contenido: controller.listaLaboratorio[index].pesoMuestra,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Prediagnóstico',
                  contenido: controller.listaLaboratorio[index].prediagnostico,
                ),
                TextosTarjetaPopup(
                  etiqueta: 'Descripción de síntomas o daños',
                  contenido:
                      controller.listaLaboratorio[index].descripcionSintomas,
                )
              ],
              onPress: () => controller.eliminarOrdenLaboratorio(),
            );
          },
        );
      } else if (controller.tieneMuestra.value == true &&
          controller.listaLaboratorio.isEmpty) {
        return const SizedBox(
          height: 80,
          child: Center(
            child: Text(INGRESAR_ORDEN_LAB),
          ),
        );
      }
      return Container();
    });
  }
}
