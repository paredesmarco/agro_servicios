import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_importador_control_sv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransitoIngresoControlSvPaso1 extends StatefulWidget {
  const TransitoIngresoControlSvPaso1({Key? key}) : super(key: key);

  @override
  State<TransitoIngresoControlSvPaso1> createState() =>
      _TransitoIngresoControlSvPaso1State();
}

class _TransitoIngresoControlSvPaso1State
    extends State<TransitoIngresoControlSvPaso1>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Información del Importador'),
        _Nombre(),
        _RUC()
      ],
    );
  }
}

class _Nombre extends StatelessWidget {
  const _Nombre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransitoIngresoImportadorControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          errorText: _.errorNombre,
          maxLength: 250,
          onChanged: (valor) {
            _.nombre = valor;
          },
          label: 'Nombre o Razón social',
        );
      },
    );
  }
}

class _RUC extends StatelessWidget {
  const _RUC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransitoIngresoImportadorControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          errorText: _.errorRuc,
          maxLength: 13,
          onChanged: (valor) {
            _.ruc = valor;
          },
          label: 'RUC',
        );
      },
    );
  }
}
