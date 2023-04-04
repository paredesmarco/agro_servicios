import 'package:agro_servicios/app/modules/trips/controllers/trips_form_sv_controller.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_paso1_controller.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_paso3_controller.dart';
import 'package:agro_servicios/app/modules/trips/pages/trips_paso1_sv_page.dart';
import 'package:agro_servicios/app/modules/trips/pages/trips_paso2_sv_page.dart';
import 'package:agro_servicios/app/modules/trips/pages/trips_paso3_sv_page.dart';
import 'package:agro_servicios/app/modules/trips/widgets/boton_icon.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sin_registros.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripsFormSv extends GetView<TripsPaso1Controller> {
  const TripsFormSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.listaProductor.isEmpty) {
          return const CuerpoFormularioSinRegistros(
              titulo: 'Muestreo de Frutos');
        } else {
          return _TripsFormSv();
        }
      },
    );
  }
}

class _TripsFormSv extends StatelessWidget {
  _TripsFormSv({Key? key}) : super(key: key);
  final _controlador = Get.find<TripsFormSvController>();

  @override
  Widget build(BuildContext context) {
    /*return CuerpoFormularioTabPage();*/
    return CuerpoFormularioTab(
      titulo: 'Inspección de Trips',
      tabController: _controlador.tabController!,
      tabs: const [
        //mapMarker
        Tab(icon: FaIcon(FontAwesomeIcons.streetView)),
        Tab(icon: FaIcon(FontAwesomeIcons.listCheck)),
        Tab(icon: FaIcon(FontAwesomeIcons.file)),
      ],
      tabsPages: const [
        TripsPaso1SvPage(),
        TripsPaso2SvPage(),
        TripsPaso3SvPage(),
      ],
      menuAppBar: [
        //CJ Desabilitar para paso ha producción
        BotonIcon(
          icono: const Icon(Icons.list_alt),
          onPressedd: () => {Get.toNamed(Rutas.TRIPSVERSV)},
        ),
        const BotonSincronizarDesarrollo(),
        const BotonDeleteDesarrollo(),
      ],
      fab: BuildFab(),
    );
  }
}

class BuildFab extends StatelessWidget {
  BuildFab({Key? key}) : super(key: key);
  final _controladorP3 = Get.find<TripsPaso3Controller>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsFormSvController>(
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
                    _controladorP3.guardarTripsDatos(
                        titulo: 'Formulario Trips',
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
  final controlador = Get.find<TripsPaso3Controller>();

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
  final controlador = Get.find<TripsPaso3Controller>();

  TrMensajeModal({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Modal.mensajeSinDatos(mensaje: controlador.mensajeGuardar.value);
    });
  }
}

class BotonSincronizarDesarrollo extends StatelessWidget {
  const BotonSincronizarDesarrollo({super.key});

  @override
  Widget build(BuildContext context) {
    if (AMBIENTE == "DE") {
      return BotonIcon(
        icono: const Icon(Icons.download),
        onPressedd: () => {Get.offNamed(Rutas.TRIPSSINCRONIZARSV)},
      );
    } else {
      return Container();
    }
  }
}

class BotonDeleteDesarrollo extends StatelessWidget {
  const BotonDeleteDesarrollo({super.key});
  @override
  Widget build(BuildContext context) {
    if (AMBIENTE == "DE") {
      return BotonIcon(
        icono: const Icon(Icons.delete),
        onPressedd: () => {Get.find<TripsFormSvController>().borrarModelo()},
      );
    } else {
      return Container();
    }
  }
}
