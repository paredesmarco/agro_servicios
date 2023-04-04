import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso4_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/widgets/preguntas.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';

class SeguimientoCuarentenarioPaso4SvPage extends StatefulWidget {
  const SeguimientoCuarentenarioPaso4SvPage({Key? key}) : super(key: key);

  @override
  State<SeguimientoCuarentenarioPaso4SvPage> createState() =>
      _SeguimientoCuarentenarioPaso4SvPageState();
}

class _SeguimientoCuarentenarioPaso4SvPageState
    extends State<SeguimientoCuarentenarioPaso4SvPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Resultado inspección'),
        _DictamenFinal(),
        _NumeroPlantas(),
        _Observaciones(),
        Espaciador(alto: 30),
      ],
    );
  }
}

class _DictamenFinal extends GetView<SeguimientoCuarentenarioPaso4vController> {
  const _DictamenFinal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<SeguimientoCuarentenarioPaso4vController>(
      id: 'idResultado',
      builder: (_) {
        return Column(
          children: [
            Row(
              children: [
                Radio(
                    value: 'Continuar cuarentena pos entrada',
                    groupValue: controller.resultadoInspeccionRx.value,
                    onChanged: (String? valor) {
                      controller.resultadoInspeccion = valor!;
                    }),
                const Text('Continuar cuarentena pos entrada',
                    style: EstilosTextos.radioYcheckbox),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 'Finalizar cuarentena pos entrada',
                    groupValue: controller.resultadoInspeccionRx.value,
                    onChanged: (String? valor) {
                      controller.resultadoInspeccion = valor!;
                    }),
                const Text('Finalizar cuarentena pos entrada',
                    style: EstilosTextos.radioYcheckbox),
              ],
            ),
            if (controller.errorResultado)
              const MensajeErrorRadioButton()
            else
              Container(),
          ],
        );
      },
    );
  }
}

class _NumeroPlantas extends StatelessWidget {
  const _NumeroPlantas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso4vController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 20,
          errorText: _.errorNumeroPlantas,
          keyboardType: TextInputType.number,
          textInputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'([0-9])'))
          ],
          label: 'Número de plantas en la inspección',
          onChanged: (valor) {
            _.numeroPlantasInspeccion = valor;
          },
        );
      },
    );
  }
}

class _Observaciones extends StatelessWidget {
  const _Observaciones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso4vController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          errorText: _.errorObservaciones,
          maxLength: 256,
          label: 'Observaciones',
          onChanged: (valor) {
            _.observaciones = valor;
          },
        );
      },
    );
  }
}
