import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/controllers/salida_verificacion_control_sv_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';

class TransitoSalidaVerificacionControlSv
    extends GetView<SalidaVerificacionControlSvController> {
  const TransitoSalidaVerificacionControlSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioIngreso(
      titulo: 'Verificación de salida',
      widgets: const [
        NombreSeccion(
            etiqueta:
                'Datos de las plantas, productos vegetales y artículos reglamentados'),
        _Tabla(),
        Espaciador(alto: 15),
        Divider(color: Colores.divider),
        _Verificacion(),
        _EstadoPrecinto(),
      ],
      fab: FloatingActionButton(
        onPressed: () {
          bool esValido = controller.validarFormulario();
          if (esValido) {
            controller.guardarFormulario(
              titulo: 'Almacenando',
              mensaje: const _MensajeModal(),
              icono: const _IconoModal(),
            );
          }
        },
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _Verificacion extends GetView<SalidaVerificacionControlSvController> {
  const _Verificacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(etiqueta: 'Verificación'),
        Obx(
          () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        value: 'Fitosanitaria',
                        groupValue: controller.verificacion.value,
                        onChanged: (String? valor) {
                          controller.verificacion.value = valor!;
                        }),
                    const Text('Fitosanitaria',
                        style: EstilosTextos.radioYcheckbox),
                    Radio(
                        value: 'Por medio de Senae',
                        groupValue: controller.verificacion.value,
                        onChanged: (String? valor) {
                          controller.verificacion.value = valor!;
                        }),
                    const Text('Por medio de Senae',
                        style: EstilosTextos.radioYcheckbox),
                  ],
                ),
                if (controller.errorVerificacion.value)
                  const Text(CAMPO_REQUERIDO, style: EstilosTextos.errorTexto)
              ],
            );
          },
        ),
      ],
    );
  }
}

class _EstadoPrecinto extends GetView<SalidaVerificacionControlSvController> {
  const _EstadoPrecinto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CampoDescripcion(etiqueta: 'Estado del Precinto'),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                      value: 'Buen estado',
                      groupValue: controller.estado.value,
                      onChanged: (String? valor) {
                        controller.estado.value = valor!;
                      }),
                  const Text(
                    'Buen estado',
                    style: EstilosTextos.radioYcheckbox,
                  ),
                  Radio(
                      value: 'Mal estado',
                      groupValue: controller.estado.value,
                      onChanged: (String? valor) {
                        controller.estado.value = valor!;
                      }),
                  const Text('Mal estado', style: EstilosTextos.radioYcheckbox),
                ],
              ),
              if (controller.errorEstado.value)
                const Text(CAMPO_REQUERIDO, style: EstilosTextos.errorTexto)
            ],
          ),
        ),
      ],
    );
  }
}

class _Tabla extends GetView<SalidaVerificacionControlSvController> {
  const _Tabla({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: GetBuilder<SalidaVerificacionControlSvController>(
        initState: (_) {},
        builder: (_) {
          return DataTable(
            sortAscending: false,
            columns: const [
              DataColumn(
                  label: Text("Partida Arancelaria",
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: Colores.TituloFormulario))),
              DataColumn(
                  label: Text("Descripción",
                      style: TextStyle(color: Colores.TituloFormulario))),
              DataColumn(
                  label: Text("Cantidad (kg)",
                      style: TextStyle(color: Colores.TituloFormulario)),
                  numeric: true),
              DataColumn(
                  label: Text("Tipo Envase",
                      style: TextStyle(color: Colores.TituloFormulario))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text(
                    controller.productoModelo?.partidaArancelaria ?? '',
                    style: const TextStyle(color: Colores.radio_chechbox))),
                DataCell(Text(controller.productoModelo?.producto ?? '',
                    style: const TextStyle(color: Colores.radio_chechbox))),
                DataCell(Text(
                    controller.productoModelo?.cantidad.toString() ?? '',
                    style: const TextStyle(color: Colores.radio_chechbox))),
                DataCell(Text(controller.productoModelo?.tipoEnvase ?? '',
                    style: const TextStyle(color: Colores.radio_chechbox))),
              ]),
            ],
          );
        },
      ),
    );
  }
}

class _MensajeModal extends GetView<SalidaVerificacionControlSvController> {
  const _MensajeModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Modal.mensajeSincronizacion(
            mensaje: controller.mensajeModal.value, fontSize: 12);
      },
    );
  }
}

class _IconoModal extends GetView<SalidaVerificacionControlSvController> {
  const _IconoModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.validandoGuardado.value) return Modal.cargando();
      if (controller.estadoGuardado == 'error') {
        return Modal.iconoError();
      } else if (controller.estadoGuardado == 'advertencia') {
        return Modal.iconoAdvertencia();
      } else {
        return Modal.iconoValido();
      }
    });
  }
}
