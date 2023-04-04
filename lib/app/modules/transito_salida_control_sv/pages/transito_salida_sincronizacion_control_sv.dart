import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/controllers/salida_control_sv_controller.dart';

class TransitoSalidaSincronizacionControlSv extends StatelessWidget {
  const TransitoSalidaSincronizacionControlSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion(
      titulo: 'Verificación de Tránsito (Salida)',
      widgetsBajarDatos: const ContenidoTabSincronizacion(
        widgets: [
          _DescripcionDescarga(),
          Espaciador(alto: 40),
          _BotonBajarDatos(),
        ],
      ),
      widgetsSubirDatos: const ContenidoTabSincronizacion(
        widgets: [
          _InformacionSubirDatos(),
          Espaciador(alto: 40),
          _BotonSubirDatos(),
        ],
      ),
    );
  }
}

class _DescripcionDescarga extends StatelessWidget {
  const _DescripcionDescarga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CuerpoFormularioSincronizacion.textoMensajes(
          'De clic en el botón sincronizar para descargar los registros de verificación de tránsito de ingreso'),
    );
  }
}

class _BotonBajarDatos extends GetView<SalidaControlSvController> {
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

class _InformacionSubirDatos extends GetView<SalidaControlSvController> {
  const _InformacionSubirDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.informacionSubirDatos(
      Obx(
        () {
          if (controller.cantidadSalida.value > 0) {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'Existen ${controller.cantidadSalida.value} Registros para ser almacenados en el Sistema GUIA');
          } else {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'No existen registros para ser almacenados en el Sistema GUIA');
          }
        },
      ),
    );
  }
}

class _BotonSubirDatos extends GetView<SalidaControlSvController> {
  const _BotonSubirDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(() async {
      controller.subirDatos(
        titulo: SINCRONIZANDO_DOWN,
        mensaje: const _MensajeModal(),
        icono: const _IconoModal(),
      );
    });
  }
}

class _MensajeModal extends GetView<SalidaControlSvController> {
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

class _IconoModal extends GetView<SalidaControlSvController> {
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
