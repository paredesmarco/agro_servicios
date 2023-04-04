import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_sincronizar_controller.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripsSincronizarSv extends StatelessWidget {
  TripsSincronizarSv({Key? key}) : super(key: key);
  final controlador = Get.find<TripsSincronizarController>();

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion(
      titulo: 'Verificación Protocolo de Trips',
      widgetsBajarDatos: const ContenidoTabSincronizacion(widgets: [
        BuildProvinciaWidget(),
        _InformacionBajarDatos(),
        Espaciador(alto: 20),
        BuildBotonBajadaDatos(),
      ]),
      widgetsSubirDatos: const ContenidoTabSincronizacion(widgets: [
        _InformacionSubirDatos(),
        Espaciador(alto: 40),
        BuildBotonSubirDatos(),
      ]),
    );
  }
}

class BuildProvinciaWidget extends StatelessWidget {
  const BuildProvinciaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsSincronizarController>(
      id: 'localizacion',
      builder: (_) {
        return CampoDescripcionBorde(
          etiqueta: 'Provincia',
          valor: _.provinciaUsuario.trim() != ''
              ? _.provinciaUsuario
              : _.errorProvincia,
        );
      },
    );
  }
}

class _InformacionBajarDatos extends StatelessWidget {
  const _InformacionBajarDatos();

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.informacionBajarDatos(
      texto:
          'Se sincronizará la información de acuerdo a la provincia en donde el usuario tiene registrado su contrato',
    );
  }
}

class _InformacionSubirDatos extends StatelessWidget {
  const _InformacionSubirDatos();

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.informacionSubirDatos(
        GetBuilder<TripsSincronizarController>(
      id: 'registros',
      builder: (_) {
        if (_.nFormularios > 0) {
          return CuerpoFormularioSincronizacion.textoMensajes(
              'Existen ${_.nFormularios} Registros para ser almacenados en el Sistema GUIA');
        } else {
          return CuerpoFormularioSincronizacion.textoMensajes(SIN_REGISTROS);
        }
      },
    ));
  }
}

class NumeroInspeccion extends StatelessWidget {
  const NumeroInspeccion({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsSincronizarController>(
      id: 'registros',
      builder: (_) {
        return Column(
          children: [
            Text('Formularios para subir al Sistema GUIA:',
                style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const Espaciador(alto: 10),
            Text(_.nFormularios.toString(),
                style: TextStyle(fontSize: 24, color: Colors.grey[600])),
          ],
        );
      },
    );
  }
}

class BuildBotonBajadaDatos extends StatelessWidget {
  const BuildBotonBajadaDatos({super.key});

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        Get.find<TripsSincronizarController>().bajarDatos(
          titulo: SINCRONIZANDO_DOWN,
          icono: const IconoModal(),
          mensaje: const MensajeModal(),
        );
      },
    );
  }
}

class BuildBotonSubirDatos extends StatelessWidget {
  const BuildBotonSubirDatos({super.key});

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        Get.find<TripsSincronizarController>().subirDatos(
          titulo: SINCRONIZANDO_UP,
          icono: const IconoModal(),
          mensaje: const MensajeModal(),
        );
      },
    );
  }
}

class IconoModal extends StatelessWidget {
  const IconoModal({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<TripsSincronizarController>()
          .validandoSincronizacion
          .value) {
        return Modal.cargando();
      }
      if (Get.find<TripsSincronizarController>().estadoSincronizacion.value ==
          'exito') {
        return Modal.iconoValido();
      } else {
        return Modal.iconoError();
      }
    });
  }
}

class MensajeModal extends GetView<TripsSincronizarController> {
  const MensajeModal({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Modal.mensajeSincronizacion(
          mensaje: controller.mensajeSincronizacion.value);
    });
  }
}
