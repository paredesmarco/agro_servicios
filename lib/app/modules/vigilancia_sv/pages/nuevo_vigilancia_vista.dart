import 'package:agro_servicios/app/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_orden_laboratorio.dart';
import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_ubicacion.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_caracteristicas.dart';
import 'package:agro_servicios/app/modules/vigilancia_sv/pages/paso1_vista.dart';
import 'package:agro_servicios/app/modules/vigilancia_sv/pages/paso2_vista.dart';
import 'package:agro_servicios/app/modules/vigilancia_sv/pages/paso3_vista.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sin_registros.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab.dart';

class FormularioNuevaVigilanciaVista extends StatefulWidget {
  const FormularioNuevaVigilanciaVista({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FormularioNuevaVigilanciaVistaState();
  }
}

class _FormularioNuevaVigilanciaVistaState
    extends State<FormularioNuevaVigilanciaVista>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool verFab = true;
  bool verFabAgregar = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.animation!.addListener(cambioVistaTab);
    final p = context.read<OrdenLaboratorioSvBloc>();
    final c = context.read<UbicacionBloc>();
    p.limpiarCodigoFecha();
    c.getProvinciaUbicacion();

    super.initState();
  }

  int index = 0;
  void cambioVistaTab() {
    final aniValue = _tabController!.animation!.value;
    FocusScope.of(context).unfocus();

    if (aniValue > 1.5 && index <= 3) {
      if (index != 2) {
        setState(() {
          index = 2;
          verFab = true;
          verFabAgregar = true;
        });
      }
    } else if (aniValue >= 0.5 && index <= 2) {
      if (index != 1) {
        setState(() {
          index = 1;
          verFab = false;
          verFabAgregar = false;
        });
      }
    } else if (aniValue <= 0.5 && index > 0) {
      if (index != 0) {
        setState(() {
          index = 0;
          verFab = true;
          verFabAgregar = false;
        });
      }
    }
  }

  void _actualizarIndex() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController!.removeListener(_actualizarIndex);
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);

    return Selector<UbicacionBloc, String>(
      selector: (_, provider) => provider.nombreProvinciaSincronizada,
      builder: (_, data, w) {
        if (data == '') {
          return const CuerpoFormularioSinRegistros(
              titulo: 'Monitoreo Vigiliancia');
        } else {
          return CuerpoFormularioTab(
            titulo: 'Monitoreo Vigiliancia',
            tabController: _tabController!,
            tabs: const [
              Tab(icon: FaIcon(FontAwesomeIcons.locationDot)),
              Tab(icon: FaIcon(FontAwesomeIcons.clipboardList)),
              Tab(icon: FaIcon(FontAwesomeIcons.flask)),
            ],
            tabsPages: const [
              Ubicacion(),
              Caracteristicas(),
              OrdenLaboratorio(),
            ],
            fab: _buildFab(context),
          );
        }
      },
    );
  }

  _buildFab(context) {
    final providerUbicacion =
        Provider.of<UbicacionBloc>(context, listen: false);
    final providerCaracteristicas =
        Provider.of<CaracteristicasBloc>(context, listen: false);
    final providerLaboratorio =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (verFabAgregar)
          Selector<OrdenLaboratorioSvBloc, String?>(
            selector: (_, p) => p.envioMuestra,
            builder: (_, data, w) {
              if (data == "Si") {
                return Container(
                  height: 47,
                  width: 47,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FloatingActionButton(
                    tooltip: 'Añadir muestra de laboratorio',
                    backgroundColor: Colors.blueGrey,
                    child: const Icon(Icons.add, color: Colors.white),
                    onPressed: () async {
                      Get.toNamed(Rutas.VIGILANCIAVFLABORATORIO);
                    },
                  ),
                );
              }
              return const SizedBox(
                height: 1,
                width: 1,
              );
            },
          ),
        if (index == 2)
          FloatingActionButton(
            heroTag: 'fabGuardar',
            tooltip: 'Guardar',
            onPressed: () async {
              bool validoCaracteristicas =
                  await providerCaracteristicas.validarFormulario();
              bool validoUbicacion = providerUbicacion.validarFormulario();
              if (validoUbicacion && validoCaracteristicas) {
                int ordenesCantidad = providerLaboratorio.listaOrdenes.length;
                String? envioOrden = providerLaboratorio.envioMuestra;

                if (envioOrden == 'Si') {
                  if (ordenesCantidad > 0) {
                    providerLaboratorio.setGuardandoFormulario = true;
                    mostrarModalBottomSheet(
                      context: context,
                      titulo: 'Guardando Datos',
                      icono: _buildIconoModalSincronizados(),
                      mensaje: _buildMensajeModalSincronizados(),
                    );
                    await Future.delayed(const Duration(seconds: 1));
                    await providerLaboratorio.guardarformulario();
                    providerLaboratorio.setGuardandoFormulario = false;
                    providerLaboratorio.setMensajeGuardado =
                        'Los registros fueron almacenados';
                    await Future.delayed(const Duration(seconds: 2));
                    Get.back();
                    Get.back();
                  } else {
                    _snackBarExterno('No hay órdenes de laboratorio');
                  }
                } else {
                  providerLaboratorio.setGuardandoFormulario = true;
                  mostrarModalBottomSheet(
                    context: context,
                    titulo: 'Guardando Datos',
                    icono: _buildIconoModalSincronizados(),
                    mensaje: _buildMensajeModalSincronizados(),
                  );
                  await Future.delayed(const Duration(seconds: 1));
                  await providerLaboratorio.guardarformulario();
                  providerLaboratorio.setGuardandoFormulario = false;
                  providerLaboratorio.setMensajeGuardado =
                      'Los registros fueron almacenados';
                  await Future.delayed(const Duration(seconds: 2));
                  Get.back();
                  Get.back();
                }
              } else {
                _snackBarExterno(SNACK_OBLIGATORIOS);
              }
            },
            child: const Icon(Icons.save, color: Colors.white),
          ),
        if (index == 0) const BotonCoordenadas()
      ],
    );
  }

  Widget _buildIconoModalSincronizados() {
    return Consumer<OrdenLaboratorioSvBloc>(
      builder: (_, provider, widget) {
        if (provider.estaGuardandoFormulario) return Modal.cargando();
        return Container(child: provider.icono);
      },
    );
  }

  Widget _buildMensajeModalSincronizados() {
    return Consumer<OrdenLaboratorioSvBloc>(
      builder: (_, provider, widget) {
        if (provider.mensajeGuardado != '') {
          return Modal.mensajeSincronizacion(mensaje: provider.mensajeGuardado);
        } else {
          return Modal.mensajeSincronizacion(mensaje: DEFECTO_A);
        }
      },
    );
  }

  SnackBar snack(String mensaje) {
    return SnackBar(
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Text(mensaje),
      margin:
          EdgeInsets.only(bottom: altoPantalla * 0.025, left: 10, right: 80),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );
  }

  void _snackBarExterno(mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensaje),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    ));
  }
}

class BotonCoordenadas extends StatefulWidget {
  const BotonCoordenadas({Key? key}) : super(key: key);

  @override
  State<BotonCoordenadas> createState() => _BotonCoordenadasState();
}

class _BotonCoordenadasState extends State<BotonCoordenadas> {
  @override
  Widget build(BuildContext context) {
    final providerUbicacion =
        Provider.of<UbicacionBloc>(context, listen: false);
    return FloatingActionButton(
      heroTag: 'fabGps',
      tooltip: 'Obtener coordenadas',
      onPressed: () async {
        await providerUbicacion.getPosicion();
        if (providerUbicacion.mensajeUbicacionError != '') {
          dialogExterno(
              mensaje: providerUbicacion.mensajeUbicacionError,
              context: context);
        }
      },
      child: Selector<UbicacionBloc, bool>(
        selector: (_, __) => __.obteniendoCoordenadas,
        builder: (_, data, __) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget childs, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: childs);
            },
            child: !data
                ? const FaIcon(
                    FontAwesomeIcons.locationDot,
                    color: Colors.white,
                    key: ValueKey(1),
                  )
                : const CircularProgressIndicator(
                    color: Colors.white,
                    key: ValueKey(2),
                  ),
          );
        },
      ),
    );
  }
}
