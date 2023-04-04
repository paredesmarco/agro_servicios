import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_control_sv_controller.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';

class SincronizacionEmbalajeControlSv
    extends GetView<EmbalajeControlSvController> {
  const SincronizacionEmbalajeControlSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return CuerpoFormularioSincronizacion(
      titulo: 'Inspección de embalajes de madera',
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
          'De clic en el botón sincronizar para descargar el catálogo de los puertos de ingreso y salida y el catálogo de países'),
    );
  }
}

class _BotonBajarDatos extends GetView<EmbalajeControlSvController> {
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

class _InformacionSubirDatos extends GetView<EmbalajeControlSvController> {
  const _InformacionSubirDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.informacionSubirDatos(
      Obx(
        () {
          if (controller.cantidadEmbalaje > 0) {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'Existen ${controller.cantidadEmbalaje} Registros para ser almacenados en el Sistema GUIA');
          } else {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'No existen registros para ser almacenados en el Sistema GUIA');
          }
        },
      ),
    );
  }
}

class _BotonSubirDatos extends GetView<EmbalajeControlSvController> {
  const _BotonSubirDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        await controller.subirDatos(
          titulo: SINCRONIZANDO_UP,
          mensaje: const _MensajeModal(),
          icono: const _IconoModal(),
        );
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
