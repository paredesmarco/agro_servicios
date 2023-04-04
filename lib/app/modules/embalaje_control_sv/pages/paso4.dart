import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_dictamen_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/widgets/preguntas.dart'
    show MensajeErrorRadioButton;

class EmbalajeControlPaso4 extends StatefulWidget {
  const EmbalajeControlPaso4({Key? key}) : super(key: key);

  @override
  State<EmbalajeControlPaso4> createState() => _EmbalajeControlPaso4State();
}

class _EmbalajeControlPaso4State extends State<EmbalajeControlPaso4>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Dictamen'),
        Espaciador(alto: 10),
        _DictamenFinal(),
      ],
    );
  }
}

class _DictamenFinal extends GetView<EmbalajeDictamenControlSvController> {
  const _DictamenFinal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dictamen final', style: _labelStyle()),
        Obx(
          () {
            return Column(
              children: [
                Row(
                  children: [
                    Radio(
                        value: 'Aprobar',
                        groupValue: controller.dictamen.value,
                        onChanged: (String? valor) {
                          controller.setDictamen = valor!;
                        }),
                    const Text('Aprobar',
                        style: TextStyle(color: Color(0xFF75808f))),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: 'Detener',
                        groupValue: controller.dictamen.value,
                        onChanged: (String? valor) {
                          controller.setDictamen = valor!;
                        }),
                    const Text('Detener',
                        style: TextStyle(color: Color(0xFF75808f))),
                  ],
                ),
                if (controller.errorDictamen.value)
                  const MensajeErrorRadioButton(),
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
