import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class FormularioSincronizacionTrampasVigilancia extends StatefulWidget {
  const FormularioSincronizacionTrampasVigilancia({super.key});
  @override
  State<StatefulWidget> createState() =>
      _FormularioSincronizacionTrampasVigilanciaState();
}

class _FormularioSincronizacionTrampasVigilanciaState
    extends State<FormularioSincronizacionTrampasVigilancia> {
  @override
  void initState() {
    final p = context.read<TrampeoBloc>();
    p.getCantidadTrampasDetalle();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioSincronizacion(
      titulo: 'Registro de Trampeo',
      widgetsBajarDatos: ContenidoTabSincronizacion(
        widgets: [
          _buildComboProvincia1(context),
          const Espaciador(alto: 20),
          _buildComboProvincia2(context),
          _buildInformacionBajarDatos(),
          const Espaciador(alto: 40),
          _buildBotonBajarDatos(),
        ],
      ),
      widgetsSubirDatos: ContenidoTabSincronizacion(
        widgets: [
          _buildInformacionSubirDatos(),
          const Espaciador(alto: 40),
          _buildBotonSubirDatos(),
        ],
      ),
    );
  }

  Widget _buildInformacionBajarDatos() {
    return CuerpoFormularioSincronizacion.informacionBajarDatos();
  }

  Widget _buildComboProvincia1(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);

    return Selector<TrampeoBloc, int>(
      selector: (_, provider) => provider.lenghtProvincias,
      builder: (_, data, w) {
        return Combo(
          items: provider.listaProvinciasDropDown.map((e) {
            return DropdownMenuItem(value: e.idGuia, child: Text(e.nombre!));
          }).toList(),
          onChanged: (valor) {
            provider.setProvinciaUno = valor;
            if (valor == 0) {
              provider.limpiarProvincia();
            } else {
              provider.getSegundaProvincia();
            }
          },
          label: 'Provincia',
        );
      },
    );
  }

  Widget _buildComboProvincia2(context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return Selector<TrampeoBloc, bool>(
      selector: (_, provider) => provider.comboActivo,
      builder: (_, data, w) {
        return Combo(
          items: provider.listaProvincias2.map((e) {
            return DropdownMenuItem(value: e.idGuia, child: Text(e.nombre!));
          }).toList(),
          onChanged: (valor) {
            provider.setProvinciaDos = valor;
          },
          label: 'Provincia 2',
        );
      },
    );
  }

  Widget _buildBotonBajarDatos() {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        provider.setValidando = false;
        if (provider.provinciaUno == 0 || provider.provinciaUno == null) {
          mostrarModalBottomSheet(
            context: context,
            titulo: COMPLETAR_DATOS,
            icono: Modal.iconoAdvertencia(),
            mensaje: Modal.mensajeSinDatos(mensaje: SIN_PROVINCIAS),
          );
          await Future.delayed(const Duration(seconds: 4));
          Get.back();
        } else {
          if (provider.cantidadTrampasDetalle != null &&
              provider.cantidadTrampasDetalle! <= 0) {
            mostrarModalBottomSheet(
              context: context,
              titulo: SINCRONIZANDO_DOWN,
              icono: _buildIconoModalSincronizados(),
              mensaje: _buildMensajeModalSincronizados(),
            );
            await Future.delayed(const Duration(seconds: 1));
            await provider.sincronizar();
            await Future.delayed(const Duration(seconds: 2));
            provider.reset();
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
              bajarDatos: () async {
                Get.back();
                mostrarModalBottomSheet(
                  context: context,
                  titulo: SINCRONIZANDO_DOWN,
                  icono: _buildIconoModalSincronizados(),
                  mensaje: _buildMensajeModalSincronizados(),
                );
                await Future.delayed(const Duration(seconds: 1));
                await provider.sincronizar();
                await Future.delayed(const Duration(seconds: 4));
                provider.reset();
                Get.back();
              },
            );
          }
        }
      },
    );
  }

  Widget _buildInformacionSubirDatos() {
    return CuerpoFormularioSincronizacion.informacionSubirDatos(
      Selector<TrampeoBloc, int?>(
        selector: (_, provider) => provider.cantidadTrampasDetalle,
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

  Widget _buildBotonSubirDatos() {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        if (provider.cantidadTrampasDetalle != null &&
            provider.cantidadTrampasDetalle! > 0) {
          provider.reset();
          mostrarModalBottomSheet(
            context: context,
            titulo: SINCRONIZANDO_UP,
            icono: _buildIconoModalSincronizados(),
            mensaje: _buildMensajeModalSincronizados(),
          );
          await Future.delayed(const Duration(seconds: 1));
          await provider.sincronizarRegistrosUp();
        } else {
          mostrarModalBottomSheet(
            context: context,
            titulo: SIN_DATOS,
            icono: Modal.iconoAdvertencia(),
            mensaje: Modal.mensajeSinDatos(mensaje: SIN_REGISTROS),
          );
        }
        await Future.delayed(const Duration(seconds: 4));
        provider.reset();
        if (!mounted) return;
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildIconoModalSincronizados() {
    return Consumer<TrampeoBloc>(
      builder: (_, provider, widget) {
        if (!provider.estaValidando) {
          return Modal.cargando();
        }

        return Container(
          child: provider.icono,
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
          return Modal.mensajeSincronizacion(mensaje: 'Sincronizando...');
        }
      },
    );
  }
}
