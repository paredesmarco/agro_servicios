import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_verificacion_control_sv.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/widgets/preguntas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmbalajeControlPaso2 extends StatefulWidget {
  const EmbalajeControlPaso2({Key? key}) : super(key: key);

  @override
  State<EmbalajeControlPaso2> createState() => _EmbalajeControlPaso2State();
}

class _EmbalajeControlPaso2State extends State<EmbalajeControlPaso2>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Verificación del embalaje y no conformidades'),
        Espaciador(alto: 10),
        _Pregunta1(),
        _Pregunta2(),
        _Pregunta3(),
        _Pregunta4(),
        _Pregunta5(),
        Espaciador(alto: 20),
      ],
    );
  }
}

class _Pregunta1 extends StatelessWidget {
  const _Pregunta1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeVerificacionControlSvController>(
      id: 'idPregunta1',
      builder: (_) {
        return Preguntas(
          error: _.errorPregunta1,
          groupValue: _.grupoPregunta1,
          label:
              'Los embalajes de madera cuentan con la marca autorizada del país de origen',
          onChangedTexto: (valor) => _.observacion1 = valor,
          onChangedRadio1: (valor) => _.setGrupoPregunta1 = valor,
          onChangedRadio2: (valor) => _.setGrupoPregunta1 = valor,
        );
      },
    );
  }
}

class _Pregunta2 extends GetView<EmbalajeVerificacionControlSvController> {
  const _Pregunta2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeVerificacionControlSvController>(
      id: 'idPregunta2',
      builder: (_) {
        return Preguntas(
          error: _.errorPregunta2,
          groupValue: _.grupoPregunta2,
          label: 'La marca es legible',
          onChangedTexto: (valor) => _.observacion2 = valor,
          onChangedRadio1: (valor) => controller.setGrupoPregunta2 = valor,
          onChangedRadio2: (valor) => controller.setGrupoPregunta2 = valor,
        );
      },
    );
  }
}

class _Pregunta3 extends StatelessWidget {
  const _Pregunta3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeVerificacionControlSvController>(
      id: 'idPregunta3',
      builder: (_) {
        return Preguntas(
          error: _.errorPregunta3,
          groupValue: _.grupoPregunta3,
          label: 'Ausencia de daño de insectos',
          onChangedTexto: (valor) => _.observacion3 = valor,
          onChangedRadio1: (valor) => _.setGrupoPregunta3 = valor,
          onChangedRadio2: (valor) => _.setGrupoPregunta3 = valor,
        );
      },
    );
  }
}

class _Pregunta4 extends StatelessWidget {
  const _Pregunta4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeVerificacionControlSvController>(
      id: 'idPregunta4',
      builder: (_) {
        return Preguntas(
          error: _.errorPregunta4,
          groupValue: _.grupoPregunta4,
          label: 'Ausencia insectos vivos en los embalajes',
          onChangedTexto: (valor) => _.observacion4 = valor,
          onChangedRadio1: (valor) => _.setGrupoPregunta4 = valor,
          onChangedRadio2: (valor) => _.setGrupoPregunta4 = valor,
        );
      },
    );
  }
}

class _Pregunta5 extends StatelessWidget {
  const _Pregunta5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeVerificacionControlSvController>(
      id: 'idPregunta5',
      builder: (_) {
        return Preguntas(
          error: _.errorPregunta5,
          groupValue: _.grupoPregunta5,
          label: 'Ausencia de corteza',
          onChangedTexto: (valor) => _.observacion5 = valor,
          onChangedRadio1: (valor) => _.setGrupoPregunta5 = valor,
          onChangedRadio2: (valor) => _.setGrupoPregunta5 = valor,
        );
      },
    );
  }
}
