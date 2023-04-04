import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_control_sv_controller.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';

class SincronizacionIngresoControlSv extends StatelessWidget {
  const SincronizacionIngresoControlSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion(
      titulo: 'Verificación de Tránsito (Ingreso)',
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
          'De clic en el botón sincronizar para descargar el catálogo de envases, países, puertos de ingreso y salida, paises de origen de tránsito y productos de tránsito'),
    );
  }
}

class _BotonBajarDatos extends GetView<TransitoIngresoControlSvController> {
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

class _InformacionSubirDatos
    extends GetView<TransitoIngresoControlSvController> {
  const _InformacionSubirDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.informacionSubirDatos(
      Obx(
        () {
          if (controller.cantidadIngreso.value > 0) {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'Existen ${controller.cantidadIngreso.value} Registros para ser almacenados en el Sistema GUIA');
          } else {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'No existen registros para ser almacenados en el Sistema GUIA');
          }
        },
      ),
    );
  }
}

class _BotonSubirDatos extends GetView<TransitoIngresoControlSvController> {
  const _BotonSubirDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(() async {
      await controller.subirDatos(
          titulo: SINCRONIZANDO_DOWN,
          mensaje: const _MensajeModal(),
          icono: const _IconoModal());
    });
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
