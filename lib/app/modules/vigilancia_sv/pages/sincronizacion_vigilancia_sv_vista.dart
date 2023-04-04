import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_orden_laboratorio.dart';
import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_ubicacion.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class FormularioSincronizacionVigilancia extends StatefulWidget {
  const FormularioSincronizacionVigilancia({super.key});
  @override
  State<FormularioSincronizacionVigilancia> createState() =>
      _FormularioSincronizacionVigilanciaState();
}

class _FormularioSincronizacionVigilanciaState
    extends State<FormularioSincronizacionVigilancia> {
  @override
  void initState() {
    final p = context.read<UbicacionBloc>();
    final p2 = context.read<OrdenLaboratorioSvBloc>();
    p.getProvinciaSincronizacion();
    p2.obtenerCantidadVigilancia();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion(
      titulo: 'Vigilancia Fitosanitaria',
      widgetsBajarDatos: ContenidoTabSincronizacion(
        widgets: [
          _buildComboProvincia1(context),
          _buildInformacionBajarDatos(),
          const Espaciador(alto: 40),
          _buildBotonBajarDatos(),
        ],
      ),
      widgetsSubirDatos: ContenidoTabSincronizacion(
        widgets: [
          _buildInformacionSubirDatos(),
          const Espaciador(alto: 40),
          _buildBotonSubirDatos(context),
        ],
      ),
    );
  }

  Widget _buildInformacionBajarDatos() {
    return CuerpoFormularioSincronizacion.informacionBajarDatos();
  }

  Widget _buildComboProvincia1(context) {
    final provider = Provider.of<UbicacionBloc>(context, listen: true);
    return Combo(
      items: provider.listaProvinciasDropDown.map((e) {
        return DropdownMenuItem(value: e.idGuia, child: Text(e.nombre!));
      }).toList(),
      onChanged: (valor) {
        provider.setProvinciaSincronizacion = valor;
      },
      label: 'Provincia',
    );
  }

  Widget _buildBotonBajarDatos() {
    final provider = Provider.of<UbicacionBloc>(context, listen: false);
    final providerLaboratorio =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);

    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        provider.setObteniendoProvincia = true;
        if (provider.provinciaSincronizacion == 0) {
          mostrarModalBottomSheet(
            context: context,
            titulo: COMPLETAR_DATOS,
            icono: Modal.iconoAdvertencia(),
            mensaje: Modal.mensajeSinDatos(mensaje: SIN_PROVINCIAS),
          );
          await Future.delayed(const Duration(seconds: 3));
          Get.back();
        } else {
          if (providerLaboratorio.cantidadVigilancia != null &&
              providerLaboratorio.cantidadVigilancia! <= 0) {
            mostrarModalBottomSheet(
              context: context,
              titulo: SINCRONIZANDO_DOWN,
              icono: _buildIconoModalSincronizados(),
              mensaje: _buildMensajeModalSincronizados(),
            );
            await Future.delayed(const Duration(seconds: 1));
            await provider
                .getCatalogoLocalizacion(provider.provinciaSincronizacion);
            await Future.delayed(const Duration(seconds: 3));
            Get.back();
          } else {
            mostrarModalBottomSheet(
              context: context,
              titulo: SINCRONIZANDO_DOWN,
              icono: Modal.iconoAdvertencia(),
              mensaje: Modal.mensajeSincronizacion(
                  mensaje: REGISTROS_PENDIENTES, fontSize: 12),
              alto: 280,
              mostrarBotones: true,
              // bajarDatos: () async {
              //   print('le dio clic aqui');
              //   Get.back();
              //   mostrarModalBottomSheet(
              //     context: context,
              //     titulo: SINCRONIZANDO_DOWN,
              //     icono: _buildIconoModalSincronizados(),
              //     mensaje: _buildMensajeModalSincronizados(),
              //   );
              //   await Future.delayed(const Duration(seconds: 1));
              //   await provider
              //       .getCatalogoLocalizacion(provider.provinciaSincronizacion);
              //   await Future.delayed(const Duration(seconds: 3));
              //   Get.back();
              // },
            );
          }
        }

        provider.encerarMensajeSincronizacion();
        providerLaboratorio.obtenerCantidadVigilancia();
      },
    );
  }

  Widget _buildInformacionSubirDatos() {
    return CuerpoFormularioSincronizacion.informacionSubirDatos(
      Selector<OrdenLaboratorioSvBloc, int?>(
        selector: (_, provider) => provider.cantidadVigilancia,
        builder: (_, data, w) {
          if (data != null && data > 0) {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'Existen $data Registros para ser almacenados en el Sistema GUIA');
          }
          return CuerpoFormularioSincronizacion.textoMensajes(
              'No existen registros para ser almacenados en el Sistema GUIA');
        },
      ),
    );
  }

  Widget _buildBotonSubirDatos(BuildContext context) {
    final provider = context.read<OrdenLaboratorioSvBloc>();
    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        provider.setEstaSincronizandoUp = true;
        provider.setMensajeSincronizacion = '';
        await provider.obtenerCantidadVigilancia();
        if (provider.cantidadVigilancia != null &&
            provider.cantidadVigilancia! > 0) {
          mostrarModalBottomSheet(
            context: context,
            titulo: SINCRONIZANDO_UP,
            icono: _buildIconoModalSincronizadosUp(),
            mensaje: _buildMensajeModalSincronizadosUp(),
          );
          await Future.delayed(const Duration(seconds: 1));
          await provider.sincronizarRegistrosUp();
          provider.setEstaSincronizandoUp = false;
        } else {
          mostrarModalBottomSheet(
            context: context,
            titulo: SIN_DATOS,
            icono: Modal.iconoAdvertencia(),
            mensaje: Modal.mensajeSinDatos(mensaje: SIN_REGISTROS),
          );
        }
        await Future.delayed(const Duration(seconds: 3));
        Get.back();
      },
    );
  }

  Widget _buildIconoModalSincronizados() {
    return Consumer<UbicacionBloc>(
      builder: (_, provider, widget) {
        if (provider.estaObteniendoProvincia) {
          return Modal.cargando();
        }

        return Container(
          child: provider.icono,
        );
      },
    );
  }

  Widget _buildMensajeModalSincronizados() {
    return Consumer<UbicacionBloc>(
      builder: (_, provider, widget) {
        if (provider.mensajeSincronizacion != '') {
          return Modal.mensajeSincronizacion(
              mensaje: provider.mensajeSincronizacion);
        } else {
          return Modal.mensajeSincronizacion(mensaje: 'Sincronizando...');
        }
      },
    );
  }

  Widget _buildIconoModalSincronizadosUp() {
    final provider =
        Provider.of<OrdenLaboratorioSvBloc>(context, listen: false);
    return Selector<OrdenLaboratorioSvBloc, bool?>(
      selector: (_, provider) => provider.estaSincronizandoUp,
      builder: (_, data, w) {
        if (data!) {
          return Modal.cargando();
        }

        return Container(
          child: provider.icono,
        );
      },
    );
  }

  Widget _buildMensajeModalSincronizadosUp() {
    return Consumer<OrdenLaboratorioSvBloc>(
      builder: (_, provider, widget) {
        if (provider.mensajeSincronizacion != '') {
          return Modal.mensajeSincronizacion(
              mensaje: provider.mensajeSincronizacion);
        } else {
          return Modal.mensajeSincronizacion(mensaje: 'Sincronizando...');
        }
      },
    );
  }
}
