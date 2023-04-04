import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_sv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeguimientoSuarentenarioSincronizacionSvPage extends StatelessWidget {
  const SeguimientoSuarentenarioSincronizacionSvPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion(
      titulo: 'Seguimiento cuarentenario vegetal',
      widgetsBajarDatos: const ContenidoTabSincronizacion(
        widgets: [
          _DescripcionBajada(),
          Espaciador(alto: 20),
          _BotonBajarDatos(),
        ],
      ),
      widgetsSubirDatos: const ContenidoTabSincronizacion(
        widgets: [
          _DescripcionSubirDatos(),
          Espaciador(alto: 20),
          _BotonSubirDatos(),
        ],
      ),
    );
  }
}

class _DescripcionBajada extends StatelessWidget {
  const _DescripcionBajada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CuerpoFormularioSincronizacion.textoMensajes(
          'De clic en el botón sincronizar para descargar el catálogo de localizaciones y las solicitudes de seguimiento cuarentenario de Sanidad vegetal'),
    );
  }
}

class _BotonBajarDatos extends GetView<SeguimientoCuarentenarioSvController> {
  const _BotonBajarDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(() async {
      await controller.bajarDatos(
          titulo: SINCRONIZANDO_DOWN,
          mensaje: const _MensajeModal(),
          icono: const _IconoModal());
    });
  }
}

class _DescripcionSubirDatos
    extends GetView<SeguimientoCuarentenarioSvController> {
  const _DescripcionSubirDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.informacionSubirDatos(
      Obx(
        () {
          if (controller.cantidadSeguimientos > 0) {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'Existen ${controller.cantidadSeguimientos} Registros para ser almacenados en el Sistema GUIA');
          } else {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'No existen registros para ser almacenados en el Sistema GUIA');
          }
        },
      ),
    );
  }
}

class _BotonSubirDatos extends GetView<SeguimientoCuarentenarioSvController> {
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
