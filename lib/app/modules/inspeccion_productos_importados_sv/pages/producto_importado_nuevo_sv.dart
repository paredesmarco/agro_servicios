import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_sv_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/pages/producto_importado_paso1_sv.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/pages/producto_importado_paso2_sv.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/pages/producto_importado_paso3_sv.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/pages/producto_importado_paso4_sv.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_paso1_sv_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_paso4_sv_controller.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';

class NuevoProductoImportadoSv
    extends GetView<ProductosImportadosSvController> {
  const NuevoProductoImportadoSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioTab(
      titulo: 'Inspección de Productos Importados',
      tabController: controller.tabController,
      tabs: const [
        Tab(child: FaIcon(FontAwesomeIcons.clipboardCheck)),
        Tab(child: FaIcon(FontAwesomeIcons.dolly)),
        Tab(child: Icon(FontAwesomeIcons.flask)),
        Tab(child: Icon(Icons.verified_user)),
      ],
      tabsPages: const [
        ProductoImportadoPaso1Sv(),
        ProductoImportadoPaso2Sv(),
        ProductoImportadoPaso3Sv(),
        ProductoImportadoPaso4Sv(),
      ],
      fab: const _Fab(),
    );
  }
}

class _Fab extends StatelessWidget {
  const _Fab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrPaso1 = Get.find<ProductosImportadosPaso1SvController>();
    final ctrPaso4 = Get.find<ProductosImportadosPaso4SvController>();

    return GetBuilder<ProductosImportadosSvController>(
      id: 'fab',
      builder: (_) {
        if (_.index == 1) {
          return FloatingActionButton(
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Get.toNamed(Rutas.PRODUCTOSIMPORTADOSLOTESV);
              });
        } else if (_.index == 2) {
          // print(_.index);
          if (_.envioMuestra) {
            return FloatingActionButton(
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.toNamed(Rutas.PRODUCTOSIMPORTADOSORDENSV);
                });
          }
          return Container();
        } else if (_.index == 3) {
          return FloatingActionButton(
              child: const Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                bool esValidoPaso1 = ctrPaso1.validarFormulario();
                bool esValidoPaso4 = ctrPaso4.validarFormulario();
                String errorLitas = '';

                if (esValidoPaso1 && esValidoPaso4) {
                  if (_.listaLotes.isEmpty) {
                    errorLitas = 'No se han registrado Lotes';
                  }

                  if (_.inspeccion.envioMuestra == 'Si' &&
                      _.listaOrdenes.isEmpty) {
                    errorLitas = 'No se han registrado Órdenes de laboratorio';
                  }

                  if (errorLitas == '') {
                    _.guardarFormulario(
                        titulo: ALMACENANDO,
                        mensaje: const _MensajeModal(),
                        icono: const _IconoModal());
                  } else {
                    snackBarExterno(mensaje: errorLitas, context: context);
                  }
                } else {
                  snackBarExterno(
                      mensaje: SNACK_OBLIGATORIOS, context: context);
                }
              });
        } else {
          return Container();
        }
      },
    );
  }
}

class _MensajeModal extends GetView<ProductosImportadosSvController> {
  const _MensajeModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Modal.mensajeSincronizacion(
            mensaje: controller.mensajeGuardado.value, fontSize: 12);
      },
    );
  }
}

class _IconoModal extends GetView<ProductosImportadosSvController> {
  const _IconoModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.validandoGuardado.value) return Modal.cargando();
      if (controller.estadoSincronizacion == 'error') {
        return Modal.iconoError();
      } else if (controller.mensajeGuardado.value == 'advertencia') {
        return Modal.iconoAdvertencia();
      } else {
        return Modal.iconoValido();
      }
    });
  }
}
