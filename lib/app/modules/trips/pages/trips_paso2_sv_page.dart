import 'package:agro_servicios/app/modules/trips/controllers/trips_paso2_controller.dart';
import 'package:agro_servicios/app/modules/trips/widgets/nombre_seccion_pregunta.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_modelo.dart';
import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TripsPaso2SvPage extends StatefulWidget {
  const TripsPaso2SvPage({Key? key}) : super(key: key);

  @override
  State<TripsPaso2SvPage> createState() => _TripsPaso2SvPageState();
}

class _TripsPaso2SvPageState extends State<TripsPaso2SvPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  // final controlador = Get.find<TripsPaso2Controller>();
  bool prueba = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        Espaciador(alto: 20),
        BuildPreguntas(),
      ],
    );
  }
}

class BuildPreguntas extends GetView<TripsPaso2Controller> {
  const BuildPreguntas({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (controller.listaRespuestasModelo.isNotEmpty) {
      int contadorcito = 0;
      return MixinBuilder<TripsPaso2Controller>(
          id: 'preguntas',
          builder: (_) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (__, index) {
                final RespuestasModelo respuesta =
                    controller.listaRespuestasModelo[index];
                // int contadorcito = 0;
                if (_.listaRespuestasModelo[index].modoVisualizar ==
                    'Pregunta') {
                  contadorcito = contadorcito + 1;
                  return ListTile(
                    title: Text(
                        '$contadorcito.${controller.listaRespuestasModelo[index].pregunta}',
                        style:
                            TextStyle(fontSize: 14, color: Colors.grey[700])),
                    subtitle: Text(
                      "${controller.listaRespuestasModelo[index].respuesta}"
                          .toString(),
                      style: const TextStyle(
                          color: Colores.gradient1,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: CupertinoSwitch(
                      value: respuesta.isFavorite,
                      onChanged: (bool value) {
                        controller.onFavorite(index, value);
                      },
                    ),
                    onTap: () {},
                  );
                } else {
                  contadorcito = 0;
                  return NombreSeccionPregunta(
                      etiqueta: '${_.listaRespuestasModelo[index].pregunta}');
                }
              },
              itemCount: controller.listaRespuestasModelo.length,
            );
          });
    } else {
      return const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Seleccione el tipo de area para desplegar las preguntas.',
            style: TextStyle(color: Colors.red, fontSize: 14),
          ));
    }
  }
}
