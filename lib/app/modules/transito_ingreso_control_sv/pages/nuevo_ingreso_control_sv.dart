import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sin_registros.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/pages/paso1.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/pages/paso2.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/pages/paso3.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_importador_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_internacional_sv_controller.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_control_sv_controller.dart';

class NuevoIngresoControlSv
    extends GetView<TransitoIngresoControlSvController> {
  const NuevoIngresoControlSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<TransitoIngresoInternacionalControlSvController>()
          .listaPaisOrigen
          .isEmpty) {
        return const CuerpoFormularioSinRegistros(
            titulo: 'Verificación de Tránsito (Ingreso)');
      } else {
        return CuerpoFormularioTab(
          titulo: 'Verificación de Tránsito (Ingreso)',
          tabController: controller.tabController!,
          tabs: const [
            Tab(icon: Icon(FontAwesomeIcons.user)),
            Tab(icon: Icon(FontAwesomeIcons.seedling)),
            Tab(icon: Icon(FontAwesomeIcons.plane)),
          ],
          tabsPages: const <Widget>[
            TransitoIngresoControlSvPaso1(),
            IngresoControlSvPaso2(),
            IngresoControlSvPaso3(),
          ],
          fab: const _Fab(),
        );
      }
    });
  }
}

class _Fab extends StatelessWidget {
  const _Fab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransitoIngresoControlSvController>(
      id: 'fab',
      builder: (_) {
        if (_.index == 3) {
          return FloatingActionButton(
            tooltip: 'Guardar',
            child: const Icon(Icons.save, color: Colors.white),
            onPressed: () async {
              bool esValidoImportador =
                  Get.find<TransitoIngresoImportadorControlSvController>()
                      .validarFormulario();
              bool esValidoTransito =
                  Get.find<TransitoIngresoInternacionalControlSvController>()
                      .validarFormulario();
              if (esValidoImportador && esValidoTransito) {
                _.guardarFormulario(
                    titulo: ALMACENANDO,
                    mensaje: const _MensajeModal(),
                    icono: const _IconoModal());
              } else {
                snackBarExterno(mensaje: SNACK_OBLIGATORIOS, context: context);
              }
            },
          );
        } else if (_.index == 2) {
          return FloatingActionButton(
            tooltip: 'Añadir producto',
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              Get.toNamed(Rutas.INGRESOPRODUCTOCONTROLSV);
            },
          );
        }
        return Container();
      },
    );
  }
}

class _MensajeModal extends GetView<TransitoIngresoControlSvController> {
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

class _IconoModal extends GetView<TransitoIngresoControlSvController> {
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
