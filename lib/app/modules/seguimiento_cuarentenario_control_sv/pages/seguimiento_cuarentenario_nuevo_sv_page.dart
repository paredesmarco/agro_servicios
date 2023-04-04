import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso3_sv_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_sv_controller.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/pages/seguimiento_cuarentenario_paso1_sv_page.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/pages/seguimiento_cuarentenario_paso2_sv_page.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/pages/seguimiento_cuarentenario_paso3_sv_page.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso1_sv_controller.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso2_sv_controller.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso4_sv_controller.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/pages/seguimiento_cuarentenario_paso4_sv_page.dart';

class SeguimientoCuarentenarioNuevoSvPage
    extends GetView<SeguimientoCuarentenarioSvController> {
  const SeguimientoCuarentenarioNuevoSvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioTab(
      titulo: 'Seguimiento Cuarentenario SV',
      tabController: controller.tabController,
      tabs: const [
        Tab(icon: FaIcon(FontAwesomeIcons.locationDot)),
        Tab(icon: FaIcon(FontAwesomeIcons.clipboardCheck)),
        Tab(icon: FaIcon(FontAwesomeIcons.flask)),
        Tab(icon: Icon(Icons.verified_user)),
      ],
      tabsPages: const [
        SeguimientoCuarentenarioPaso1SvPage(),
        SeguimientoCuarentenarioPaso2SvPage(),
        SeguimientoCuarentenarioPaso3SvPage(),
        SeguimientoCuarentenarioPaso4SvPage(),
      ],
      fab: const _Fab(),
    );
  }
}

class _Fab extends StatelessWidget {
  const _Fab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioSvController>(
      id: 'fab',
      builder: (_) {
        if (_.index == 3) {
          return FloatingActionButton(
            tooltip: 'Guardar',
            child: const Icon(Icons.save, color: Colors.white),
            onPressed: () async {
              bool esValidoPaso1 =
                  Get.find<SeguimientoCuarentenarioPaso1SvController>()
                      .validarFormulario();
              bool esValidoPaso2 =
                  Get.find<SeguimientoCuarentenarioPaso2SvController>()
                      .validarFormulario();
              bool esValidoPaso3 =
                  Get.find<SeguimientoCuarentenarioPaso3vController>()
                      .validarFormulario();
              bool esValidoPaso4 =
                  Get.find<SeguimientoCuarentenarioPaso4vController>()
                      .validarFormulario();

              if (esValidoPaso1 && esValidoPaso2 && esValidoPaso4) {
                if (esValidoPaso3) {
                  _.guardarFormulario(
                      titulo: ALMACENANDO,
                      mensaje: const _MensajeModal(),
                      icono: const _IconoModal());
                } else {
                  snackBarExterno(
                      mensaje: 'No se han registrado órdenes de laboratorio',
                      context: context);
                }
              } else {
                snackBarExterno(mensaje: SNACK_OBLIGATORIOS, context: context);
              }
            },
          );
        } else if (_.index == 2) {
          if (_.envioMuestra) {
            return FloatingActionButton(
              tooltip: 'Añadir orden laboratorio',
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                Get.toNamed(Rutas.SEGUIMIENTOCUARENTENARIOLABORATORIOSV);
              },
            );
          }
        }
        return Container();
      },
    );
  }
}

class _MensajeModal extends GetView<SeguimientoCuarentenarioSvController> {
  const _MensajeModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Modal.mensajeSincronizacion(
            mensaje: controller.mensajeSincronizacion.value, fontSize: 12);
      },
    );
  }
}

class _IconoModal extends GetView<SeguimientoCuarentenarioSvController> {
  const _IconoModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.validandoBajada.value) return Modal.cargando();
      if (controller.estadoSincronizacion == 'error') {
        return Modal.iconoError();
      } else if (controller.estadoSincronizacion == 'advertencia') {
        return Modal.iconoAdvertencia();
      } else {
        return Modal.iconoValido();
      }
    });
  }
}
