import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_dictamen_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_incumplimiento_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_lugar_inspeccion_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_verificacion_control_sv.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/pages/paso1.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/pages/paso2.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/pages/paso3.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/pages/paso4.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_control_sv_controller.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sin_registros.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab.dart';

class EmbalajeControlNuevo extends StatelessWidget {
  EmbalajeControlNuevo({Key? key}) : super(key: key);

  final controlador = Get.find<EmbalajeControlSvController>();
  final ctrVerificacion = Get.find<EmbalajeVerificacionControlSvController>();
  final ctrLugarInspeccion =
      Get.find<EmbalajeLugarInspeccionControlSvController>();
  final ctrIncumplimiento =
      Get.find<EmbalajeIncumplimientoControlSvController>();
  final ctrDictamen = Get.find<EmbalajeDictamenControlSvController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ctrLugarInspeccion.puertos.isEmpty) {
        return const CuerpoFormularioSinRegistros(
            titulo: 'Inspeccion de embalajes de madera');
      }
      return CuerpoFormularioTab(
        titulo: 'Inspeccion de embalajes de madera',
        tabController: controlador.tabController!,
        tabs: const [
          Tab(icon: FaIcon(FontAwesomeIcons.locationDot)),
          Tab(icon: FaIcon(FontAwesomeIcons.clipboardCheck)),
          Tab(icon: FaIcon(FontAwesomeIcons.flask)),
          Tab(icon: Icon(Icons.verified_user)),
        ],
        tabsPages: const [
          EmbalajeControlPaso1(),
          EmbalajeControlPaso2(),
          EmbalajeControlPaso3(),
          EmbalajeControlPaso4()
        ],
        fab: _buildFab(),
      );
    });
  }

  Widget _buildFab() {
    return GetBuilder<EmbalajeControlSvController>(
      id: 'fab',
      builder: (_) {
        if (controlador.index == 3) {
          return FloatingActionButton(
            tooltip: 'Guardar',
            child: const Icon(Icons.save, color: Colors.white),
            onPressed: () async {
              bool validoLugar = ctrLugarInspeccion.validarFormulario();
              bool validoVerificacion = ctrVerificacion.validarFormulario();
              bool validoIncumplimiento = ctrIncumplimiento.validarFormulario();
              bool validoDicamen = ctrDictamen.validarFormulario();

              if (validoVerificacion &&
                  validoLugar &&
                  validoIncumplimiento &&
                  validoDicamen) {
                _.guardarFormulario(
                    titulo: ALMACENANDO,
                    mensaje: const _MensajeModal(),
                    icono: const _IconoModal());
              } else {
                snackBarExterno(
                    mensaje: SNACK_OBLIGATORIOS, context: Get.context!);
              }
            },
          );
        } else if (controlador.index == 2) {
          if (_.tieneMuestra) {
            return FloatingActionButton(
              tooltip: 'Añadir muestra de laboratorio',
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                if (ctrIncumplimiento.listaLaboratorio.isEmpty) {
                  if (ctrIncumplimiento.producto == null ||
                      ctrIncumplimiento.producto == '') {
                    snackBarExterno(
                        mensaje: 'Ingrese el nombre de un producto',
                        context: Get.context!);
                  } else {
                    Get.toNamed(Rutas.EMBALAJELABORATORIOCONTROLSV,
                        arguments: ctrIncumplimiento.producto);
                  }
                } else {
                  snackBarExterno(
                      mensaje: 'Ya existe una orden registrada',
                      context: Get.context!);
                }
              },
            );
          }
        }
        return Container();
      },
    );
  }
}

class _MensajeModal extends GetView<EmbalajeControlSvController> {
  const _MensajeModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Modal.mensajeSincronizacion(
            mensaje: controller.mensajeBajarDatos.value, fontSize: 12);
      },
    );
  }
}

class _IconoModal extends GetView<EmbalajeControlSvController> {
  const _IconoModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.validandoBajada.value) return Modal.cargando();
      if (controller.estadoBajada == 'error') {
        return Modal.iconoError();
      } else if (controller.estadoBajada == 'advertencia') {
        return Modal.iconoAdvertencia();
      } else {
        return Modal.iconoValido();
      }
    });
  }
}
