import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_sa_controller.dart';

class SincronizacionProductosImportadosSa extends StatelessWidget {
  const SincronizacionProductosImportadosSa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion(
      titulo: 'Inspección de Productos Importados SA',
      widgetsBajarDatos: const ContenidoTabSincronizacion(
        widgets: [
          _DescripcionDescarga(),
          Espaciador(alto: 40),
          _BotonBajarDatos(),
        ],
      ),
      widgetsSubirDatos: const ContenidoTabSincronizacion(widgets: [
        _DescripcionSubirDatos(),
        Espaciador(alto: 20),
        _BotonSubirDatos(),
      ]),
    );
  }
}

class _DescripcionDescarga extends StatelessWidget {
  const _DescripcionDescarga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.textoMensajes(
        'De clic en el botón sincronizar para descargar los registros de documentos de destinación aduanera');
  }
}

class _BotonBajarDatos extends GetView<ProductosImportadosSaController> {
  const _BotonBajarDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(() async {
      controller.bajarDatos(
        titulo: SINCRONIZANDO_DOWN,
        mensaje: const _MensajeModal(),
        icono: const _IconoModal(),
      );
    });
  }
}

class _DescripcionSubirDatos extends GetView<ProductosImportadosSaController> {
  const _DescripcionSubirDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.informacionSubirDatos(
      Obx(
        () {
          if (controller.cantidadInspecciones > 0) {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'Existen ${controller.cantidadInspecciones} Registros para ser almacenados en el Sistema GUIA');
          } else {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'No existen registros para ser almacenados en el Sistema GUIA');
          }
        },
      ),
    );
  }
}

class _BotonSubirDatos extends GetView<ProductosImportadosSaController> {
  const _BotonSubirDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(() {
      controller.subirDatos(
        icono: const _IconoModal(),
        mensaje: const _MensajeModal(),
        titulo: SINCRONIZANDO_UP,
      );
    });
  }
}

class _MensajeModal extends GetView<ProductosImportadosSaController> {
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

class _IconoModal extends GetView<ProductosImportadosSaController> {
  const _IconoModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.validandoGuardado.value) return Modal.cargando();
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
