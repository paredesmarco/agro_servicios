import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_sincronizar_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/widgets/campo_informativo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MinadorSincronizarSv extends StatelessWidget {
  MinadorSincronizarSv({Key? key}) : super(key: key);
  final controlador = Get.find<MinadorSincronizarController>();

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion(
      titulo: 'Verificación Protocolo de Minador',
      widgetsBajarDatos: ContenidoTabSincronizacion(widgets: [
        const BuildProvinciaWidget(),
        const Espaciador(alto: 40),
        BuildBotonBajadaDatos(),
      ]),
      widgetsSubirDatos: ContenidoTabSincronizacion(widgets: [
        const NumeroInspeccion(),
        const Espaciador(alto: 40),
        BuildBotonSubirDatos(),
      ]),
    );
  }
}

class BuildProvinciaWidget extends StatelessWidget {
  const BuildProvinciaWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MinadorSincronizarController>(
      id: 'localizacion',
      builder: (_) {
        return CampoInformativo(
            etiqueta: 'Provincia',
            valor: _.provinciaUsuario,
            errorText: _.errorProvincia);
      },
    );
  }
}

class NumeroInspeccion extends StatelessWidget {
  const NumeroInspeccion({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MinadorSincronizarController>(
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
  final controlador = Get.find<MinadorSincronizarController>();

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        controlador.bajarDatos(
          titulo: SINCRONIZANDO_DOWN,
          icono: IconoModal(),
          mensaje: MensajeModal(),
        );
      },
    );
  }
}

class BuildBotonSubirDatos extends StatelessWidget {
  final controlador = Get.find<MinadorSincronizarController>();

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        controlador.subirDatos(
          titulo: SINCRONIZANDO_UP,
          icono: IconoModal(),
          mensaje: MensajeModal(),
        );
      },
    );
  }
}

class IconoModal extends StatelessWidget {
  final controlador = Get.find<MinadorSincronizarController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controlador.validandoSincronizacion.value) return Modal.cargando();
      if (controlador.estadoSincronizacion.value == 'exito') {
        return Modal.iconoValido();
      } else {
        return Modal.iconoError();
      }
    });
  }
}

class MensajeModal extends StatelessWidget {
  final controlador = Get.find<MinadorSincronizarController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Modal.mensajeSincronizacion(
          mensaje: controlador.mensajeSincronizacion.value);
    });
  }
}
