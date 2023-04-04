import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/search/buscar_trampas_mf_sv.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_controller.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/pages/paso1.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/pages/paso2.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';

class NuevoTrampeoMfSv extends StatelessWidget {
  NuevoTrampeoMfSv({Key? key}) : super(key: key);

  final controlador = Get.find<TrampeoMfSvController>();

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: _buildFab(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: BuscarTrampasMfSv(),
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Nuevo registro de trampa'),
        bottom: TabBar(
          controller: controlador.tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: const EdgeInsets.only(bottom: 5),
          labelPadding: const EdgeInsets.only(bottom: 5),
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: FaIcon(FontAwesomeIcons.clipboardList)),
            Tab(icon: FaIcon(FontAwesomeIcons.flask)),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff09c273), Color(0xff05b386)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Espaciador(
                alto: MediaQuery.of(context).padding.top,
              ),
              Container(height: 107),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: TabBarView(
                    controller: controlador.tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const TrampeoMfPaso1(),
                      TrampeoMfPaso2(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFab() {
    return GetBuilder<TrampeoMfSvController>(
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
                    Get.toNamed(Rutas.TRAMPEOMFSVLABORATORIO);
                  },
                ),
              ),
              FloatingActionButton(
                child: const Icon(Icons.save, color: Colors.white),
                onPressed: () async {
                  bool valido = controlador.validarFormulario();
                  if (valido) {
                    await controlador.guardarFormulario(
                      titulo: 'Almacenando datos',
                      mensaje: _buildMensajeModalSincronizados(),
                      icono: _buildIconoModalSincronizados(),
                    );
                  } else {
                    snackBarExterno(
                        mensaje: 'No existen registros por almacenar',
                        context: Get.context!);
                  }
                },
              ),
            ],
          );
        }
        // else if (controlador.index == 1)
        return FloatingActionButton(
          child: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            showSearch(context: Get.context!, delegate: BuscarTrampasMfSv());
          },
        );
      },
    );
  }

  Widget _buildIconoModalSincronizados() {
    return GetX<TrampeoMfSvController>(
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
