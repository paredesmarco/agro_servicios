import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_cultivo_controller.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_productor_controller.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_ubicacion_controller.dart';
import 'package:agro_servicios/app/utils/dialog.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_controller.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/pages/paso1.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/pages/paso2.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/pages/paso3.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sin_registros.dart';
import 'package:agro_servicios/app/core/widgets/boton_fab_coordenadas.dart';

class CaracterizacionFrMfSvNuevo extends StatelessWidget {
  CaracterizacionFrMfSvNuevo({Key? key}) : super(key: key);

  final controlador = Get.find<CaracterizacionFrMfSvController>();
  final ctrProductor = Get.find<CaracterizacionFrMfSvProductorController>();
  final ctrUbicacion = Get.find<CaracterizacionFrMfSvUbicacionController>();
  final ctrCultivo = Get.find<CaracterizacionFrMfSvCultivoController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ctrUbicacion.provincia.value == '') {
        return const CuerpoFormularioSinRegistros(
            titulo: 'Caracterización Frutícula');
      } else {
        return CuerpoFormularioTab(
          titulo: 'Caracterización Frutícula',
          tabController: controlador.tabController!,
          tabs: const [
            Tab(icon: FaIcon(FontAwesomeIcons.clipboardList)),
            Tab(icon: FaIcon(FontAwesomeIcons.locationDot)),
            Tab(icon: FaIcon(FontAwesomeIcons.seedling)),
          ],
          tabsPages: const [
            CaracterizacionFrMfSvPaso1(),
            CaracterizacionFrMfSvPaso2(),
            CaracterizacionFrMfSvPaso3(),
          ],
          fab: _buildFab(),
        );
      }
    });
  }

  Widget _buildFab() {
    return GetBuilder<CaracterizacionFrMfSvController>(
      id: 'fab',
      builder: (_) {
        if (controlador.index == 1) {
          return BotonFabCoordenadas(
            validacion: ctrUbicacion.obteniendoCoordenadas,
            funcion: () async {
              await ctrUbicacion.getPosicion();
              if (ctrUbicacion.mensajeUbicacionError.value != '') {
                dialogExterno(
                    mensaje: ctrUbicacion.mensajeUbicacionError.value,
                    context: Get.context!);
              }
            },
          );
        } else if (controlador.index == 2) {
          return FloatingActionButton(
            child: const Icon(Icons.save, color: Colors.white),
            onPressed: () async {
              final bool validoProductor = ctrProductor.validarFormulario();
              final bool validoUbicacion = ctrUbicacion.validarFormulario();
              final bool validoCultivo = ctrCultivo.validarFormulario();
              if (validoProductor && validoUbicacion && validoCultivo) {
                controlador.guardarFormulario(
                    titulo: 'Guardando datos',
                    mensaje: _buildMensajeModalSincronizados(),
                    icono: _buildIconoModalSincronizados(),
                    propietario: ctrProductor.caracteizacionModelo,
                    ubicacion: ctrUbicacion.caracteizacionModelo,
                    cultivo: ctrCultivo.caracteizacionModelo);
              } else {
                snackBarExterno(
                    mensaje: SNACK_OBLIGATORIOS, context: Get.context!);
              }
            },
          );
        }

        return Container();
      },
    );
  }

  Widget _buildIconoModalSincronizados() {
    return GetX<CaracterizacionFrMfSvController>(
      builder: (_) {
        if (_.validandoBajada.value) return Modal.cargando();
        if (_.estadoBajada != 'error') {
          return Modal.iconoValido();
        } else {
          return Modal.iconoError();
        }
      },
    );
  }

  Widget _buildMensajeModalSincronizados() {
    return Obx(() {
      return Modal.mensajeSincronizacion(
          mensaje: controlador.mensajeBajarDatos.value);
    });
  }
}
