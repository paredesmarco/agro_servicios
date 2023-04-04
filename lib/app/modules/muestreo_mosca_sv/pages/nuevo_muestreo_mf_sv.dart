import 'package:agro_servicios/app/core/widgets/boton_fab_coordenadas.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sin_registros.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_controller.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_ubicacion_controller.dart';
import 'package:agro_servicios/app/utils/dialog.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/pages/paso1.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/pages/paso2.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab.dart';

class MuestreoMfSvNuevo extends StatelessWidget {
  MuestreoMfSvNuevo({Key? key}) : super(key: key);

  final controlador = Get.find<MuestreoMfSvController>();
  final ctrUbicacion = Get.find<MuestreoMfSvUbicacionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ctrUbicacion.provincia.value == '') {
        return const CuerpoFormularioSinRegistros(titulo: 'Muestreo de Frutos');
      } else {
        return CuerpoFormularioTab(
          titulo: 'Muestreo de Frutos',
          tabController: controlador.tabController!,
          tabs: const [
            Tab(icon: FaIcon(FontAwesomeIcons.locationDot)),
            Tab(icon: FaIcon(FontAwesomeIcons.flask)),
          ],
          tabsPages: const [
            MuestreoMfSvPaso1(),
            MuestreoMfSvPaso2(),
          ],
          fab: _buildFab(),
        );
      }
    });
  }

  Widget _buildFab() {
    return GetBuilder<MuestreoMfSvController>(
      id: 'fab',
      builder: (_) {
        if (controlador.index == 1) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 47,
                width: 47,
                margin: const EdgeInsets.only(bottom: 10),
                child: FloatingActionButton(
                  heroTag: null,
                  tooltip: 'Añadir muestra de laboratorio',
                  backgroundColor: Colors.blueGrey,
                  child: const Icon(Icons.add, color: Colors.white),
                  onPressed: () async {
                    Get.toNamed(Rutas.MUESTREOMFSVLABORATORIO);
                  },
                ),
              ),
              FloatingActionButton(
                tooltip: 'Guardar',
                child: const Icon(Icons.save, color: Colors.white),
                onPressed: () async {
                  bool validoOrden = controlador.validarOrden();
                  bool validoUbicacion = await ctrUbicacion.validarFormulario();

                  if (validoUbicacion) {
                    if (validoOrden) {
                      await controlador.guardarFormulario(
                        titulo: 'Guardando datos',
                        mensaje: _buildMensajeModalSincronizados(),
                        icono: _buildIconoModalSincronizados(),
                        muestreo: ctrUbicacion.muestreoModelo,
                      );
                    } else {
                      snackBarExterno(
                          mensaje: 'Ingrese al menos una orden de laboratorio',
                          context: Get.context!);
                    }
                  } else {
                    snackBarExterno(
                        mensaje: SNACK_OBLIGATORIOS, context: Get.context!);
                  }
                },
              ),
            ],
          );
        }

        return BotonFabCoordenadas(
          validacion: ctrUbicacion.obteniendoUbicacion,
          funcion: () async {
            await ctrUbicacion.getPosicion();
            if (ctrUbicacion.mensajeUbicacionError.value != '') {
              dialogExterno(
                  mensaje: ctrUbicacion.mensajeUbicacionError.value,
                  context: Get.context!);
            }
          },
        );
      },
    );
  }

  Widget _buildIconoModalSincronizados() {
    return GetX<MuestreoMfSvController>(
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
