import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_form_sv_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_paso1_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_paso3_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/pages/minador_paso1_sv_page.dart';
import 'package:agro_servicios/app/modules/minador_sv/pages/minador_paso2_sv_page.dart';
import 'package:agro_servicios/app/modules/minador_sv/pages/minador_paso3_sv_page.dart';
import 'package:agro_servicios/app/modules/minador_sv/widgets/boton_icon.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sin_registros.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MinadorFormSv extends GetView<MinadorPaso1Controller> {
  const MinadorFormSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.listaProductor.isEmpty) {
          return const CuerpoFormularioSinRegistros(
              titulo: 'Muestreo de Frutos');
        } else {
          return _MinadorFormSv();
        }
      },
    );
  }
}

class _MinadorFormSv extends StatelessWidget {
  _MinadorFormSv({Key? key}) : super(key: key);
  final _controlador = Get.find<MinadorFormSvController>();

  @override
  Widget build(BuildContext context) {
    /*return CuerpoFormularioTabPage();*/
    return CuerpoFormularioTab(
      titulo: 'Inspección de Minador',
      tabController: _controlador.tabController!,
      tabs: const [
        //mapMarker
        Tab(icon: FaIcon(FontAwesomeIcons.streetView)),
        Tab(icon: FaIcon(FontAwesomeIcons.listCheck)),
        Tab(icon: FaIcon(FontAwesomeIcons.file)),
      ],
      tabsPages: [
        MinadorPaso1SvPage(),
        MinadorPaso2SvPage(),
        const MinadorPaso3SvPage(),
      ],
      menuAppBar: [
        //CJ Desabilitar para paso ha producción
        BotonIcon(
          icono: const Icon(Icons.list_alt),
          onPressedd: () => {Get.toNamed(Rutas.MINADORVERSV)},
        ),
        BotonSincronizarDesarrollo(),
        BotonDeleteDesarrollo(),
      ],
      fab: BuildFab(),
    );
  }
}

class BuildFab extends StatelessWidget {
  BuildFab({Key? key}) : super(key: key);
  final _controladorP3 = Get.find<MinadorPaso3Controller>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MinadorFormSvController>(
      id: 'fab',
      builder: (_) {
        if (_.index == 2) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 47,
                width: 47,
                margin: const EdgeInsets.only(bottom: 10),
                child: FloatingActionButton(
                  heroTag: null,
                  tooltip: 'Añadir muestra de laboratorios',
                  child: const Icon(Icons.save, color: Colors.white),
                  onPressed: () async {
                    _controladorP3.guardarMinadorDatos(
                        titulo: 'Formulario Minador',
                        icono: TrIconoModal(),
                        mensaje: TrMensajeModal());
                  },
                ),
              ),
            ],
          );
        }

        return const Text('');
      },
    );
  }
}

class TrIconoModal extends StatelessWidget {
  final controlador = Get.find<MinadorPaso3Controller>();
  TrIconoModal({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controlador.validandoGuardar.value) return Modal.cargando();
      if (controlador.estadoSincronizacion.value == 'exito') {
        return Modal.iconoValido();
      } else {
        return Modal.iconoError();
      }
    });
  }
}

class TrMensajeModal extends StatelessWidget {
  final controlador = Get.find<MinadorPaso3Controller>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Modal.mensajeSinDatos(mensaje: controlador.mensajeGuardar.value);
    });
  }
}

class BotonSincronizarDesarrollo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (AMBIENTE == "DE") {
      return BotonIcon(
        icono: const Icon(Icons.download),
        onPressedd: () => {Get.offNamed(Rutas.MINADORSINCRONIZARSV)},
      );
    } else {
      return Container();
    }
  }
}

class BotonDeleteDesarrollo extends StatelessWidget {
  final controlador = Get.find<MinadorFormSvController>();
  @override
  Widget build(BuildContext context) {
    if (AMBIENTE == "DE") {
      return BotonIcon(
        icono: const Icon(Icons.delete),
        onPressedd: () => {controlador.borrarModelo()},
      );
    } else {
      return Container();
    }
  }
}
