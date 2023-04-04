import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/search/buscar_trampas.dart';
import 'package:agro_servicios/app/modules/trampeo_sv/pages/paso1_vista.dart';
import 'package:agro_servicios/app/modules/trampeo_sv/pages/paso2_vista.dart';
import 'package:agro_servicios/app/modules/trampeo_sv/pages/paso3_vista.dart';

class FormularioNuevoTrampeoVista extends StatefulWidget {
  const FormularioNuevoTrampeoVista({super.key});
  @override
  State<StatefulWidget> createState() => _FormularioNuevoTrampeoVistaState();
}

class _FormularioNuevoTrampeoVistaState
    extends State<FormularioNuevoTrampeoVista>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool verFab = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.animation!.addListener(cambioVistaTab);
    final p = context.read<TrampeoBloc>();
    p.reset();

    p.resetListaProvinciaSincronizadas();
    p.limpiarListaOrdenesLaboratorio();
    p.limpiarImagen();
    p.encerarTrampasParaLaboratorio();
    super.initState();
  }

  int index = 0;
  void cambioVistaTab() {
    final aniValue = _tabController!.animation!.value;
    if (aniValue > 1.5 && index <= 3) {
      if (index != 2) {
        setState(() {
          index = 2;
          verFab = true;
        });
      }
    } else if (aniValue >= 0.5 && index <= 2) {
      if (index != 1) {
        setState(() {
          index = 1;
          verFab = true;
        });
      }
    } else if (aniValue <= 0.5 && index > 0) {
      if (index != 0) {
        setState(() {
          index = 0;
          verFab = false;
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
    final TrampeoBloc provider =
        Provider.of<TrampeoBloc>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        provider.resetLugarTrampeoFormularioNotificar();
        provider.getProvinciasSincronizadas();
        Get.back();
        return true;
      },
      child: CuerpoFormularioTab(
        titulo: 'Nuevo registro de trampa',
        tabController: _tabController!,
        tabs: const [
          Tab(icon: FaIcon(FontAwesomeIcons.clipboardList)),
          Tab(icon: FaIcon(FontAwesomeIcons.flask)),
          Tab(icon: FaIcon(FontAwesomeIcons.camera)),
        ],
        tabsPages: [
          const DatosTrampa(),
          const OrdenLaboratorio(),
          FotoTrampa(
            scaffoldKey: scaffoldKey,
          ),
        ],
        fab: _buildFab(),
        menuAppBar: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: BuscarTrampas());
              })
        ],
      ),
    );
  }

  _buildFab() {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    if (index == 0) {
      return FloatingActionButton(
        child: const Icon(Icons.search, color: Colors.white),
        onPressed: () {
          showSearch(context: context, delegate: BuscarTrampas());
        },
      );
    } else if (index == 1) {
      return FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Get.toNamed(Rutas.TRAMPEOVFLABORATORIO);
        },
      );
    } else if (index == 2) {
      return FloatingActionButton(
        child: const Icon(Icons.save, color: Colors.white),
        onPressed: () async {
          bool trampasLlenas = provider.verificarTrampasLlenadas();
          if (!trampasLlenas) {
            ScaffoldMessenger.of(context).showSnackBar(snack(SIN_ALMACENAR));
          } else {
            provider.setEstaCargnado = true;
            mostrarModalBottomSheet(
              context: context,
              titulo: ALMACENANDO,
              icono: _buildIconoModalSincronizados(),
              mensaje: _buildMensajeModalSincronizados(),
            );
            await Future.delayed(const Duration(seconds: 1));
            await provider.finalizarProcesoGuardado();
            provider.resetLugarTrampeoFormularioNotificar();
            provider.getProvinciasSincronizadas();
            provider.reset();
          }
        },
      );
    } else if (index == 0) {
      return null;
    }
  }

  Widget _buildIconoModalSincronizados() {
    return Selector<TrampeoBloc, bool>(
      selector: (_, provider) => provider.estaCargando,
      builder: (_, data, w) {
        return Consumer<TrampeoBloc>(
          builder: (_, provider, widget) {
            if (provider.estaCargando) return Modal.cargando();
            return Container(child: provider.icono);
          },
        );
      },
    );
  }

  Widget _buildMensajeModalSincronizados() {
    return Consumer<TrampeoBloc>(
      builder: (_, provider, widget) {
        if (provider.mensajeValidacion != '') {
          return Modal.mensajeSincronizacion(
              mensaje: provider.mensajeValidacion);
        } else {
          return Modal.mensajeSincronizacion(mensaje: DEFECTO_A);
        }
      },
    );
  }

  SnackBar snack(String mensaje) {
    return SnackBar(
      elevation: 6.0,
      content: Text(mensaje),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );
  }
}
