import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sin_registros.dart';
import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/trampas_modelo.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/core/widgets/boton.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';

class FormularioLugarTrampaVista extends StatefulWidget {
  const FormularioLugarTrampaVista({super.key});
  @override
  State<StatefulWidget> createState() => _FormularioLugarTrampaVistaState();
}

class _FormularioLugarTrampaVistaState
    extends State<FormularioLugarTrampaVista> {
  @override
  void initState() {
    super.initState();

    final p = context.read<TrampeoBloc>();
    p.getProvinciasSincronizadas();
    p.resetLugarTrampeoFormulario();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<TrampeoBloc, List<LocalizacionModelo>>(
      selector: (_, provider) => provider.listaProvinciasSincronizadas,
      builder: (_, data, w) {
        if (data.length <= 1) {
          return const CuerpoFormularioSinRegistros(
              titulo: 'Registro de Trampeo');
        } else {
          return CuerpoFormularioIngreso(
            titulo: 'Registro de Trampeo',
            appBarExtendido: true,
            widgets: [
              const Espaciador(alto: 20),
              _buildMensajeInicial(),
              const Espaciador(alto: 20),
              _buildProvinciaCombo(context),
              _buildCantonCombo(context),
              _buildSitioCombo(context),
              Selector<TrampeoBloc, bool>(
                selector: (_, provider) => provider.esParroquia,
                builder: (_, data, w) {
                  if (data) return _buildParroquiaCombo(context);
                  return _buildNumeroLugarInstalacion(context);
                },
              ),
              _buildSemanaActual(),
            ],
            botonFormulario: _buildBotonNuevoRegistro(context),
          );
        }
      },
    );
  }
}

Widget _buildMensajeInicial() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: anchoPantalla * 0.04),
    child: Text(
      'Para realizar un nuevo registro de trampeo debe Ingresar los datos del lugar donde se realizará esta actividad',
      style: TextStyle(color: Colors.grey.shade700),
    ),
  );
}

_buildProvinciaCombo(context) {
  final provider = Provider.of<TrampeoBloc>(context, listen: false);
  return Selector<TrampeoBloc, List<LocalizacionModelo>>(
    selector: (_, provider) => provider.listaProvinciasSincronizadas,
    builder: (_, data, w) {
      return Combo(
        key: UniqueKey(),
        value: provider.listaProvinciasSincronizadas[0].idGuia,
        items: provider.listaProvinciasSincronizadas
            .map(
              (e) => DropdownMenuItem(
                value: e.idGuia,
                child: Text(e.nombre!),
              ),
            )
            .toList(),
        onChanged: (valor) {
          provider.getCantonesSincronizados(valor);
        },
        label: 'Provincia',
      );
    },
  );
}

_buildCantonCombo(context) {
  final provider = Provider.of<TrampeoBloc>(context, listen: false);
  return Selector<TrampeoBloc, List<LocalizacionModelo>>(
    selector: (_, provider) => provider.listaCantonesLugarInstalacion,
    builder: (_, data, w) {
      return Combo(
        key: UniqueKey(),
        value: provider.listaCantonesLugarInstalacion.isNotEmpty
            ? provider.listaCantonesLugarInstalacion[0].idGuia
            : null,
        items: provider.listaCantonesLugarInstalacion.map((e) {
          return DropdownMenuItem(
            value: e.idGuia,
            child: Text(e.nombre!),
          );
        }).toList(),
        onChanged: (dynamic valor) async {
          provider.setCantonLugarTrampa = valor;
          await provider.getLugarInstalacion(valor);
        },
        label: 'Cantón',
      );
    },
  );
}

_buildSitioCombo(context) {
  final provider = Provider.of<TrampeoBloc>(context, listen: false);

  return Selector<TrampeoBloc, List<Trampas>>(
      selector: (_, provider) => provider.listaLugarInstalacion,
      builder: (_, data, w) {
        return Combo(
          key: UniqueKey(),
          items: provider.listaLugarInstalacion.map((e) {
            return DropdownMenuItem(
              value: e.idlugarinstalacion,
              child: Text(e.lugarinstalacion!),
            );
          }).toList(),
          onChanged: (dynamic valor) async =>
              provider.verificarLugarInstalacion(valor),
          label: 'Lugar de instalación',
        );
      });
}

_buildParroquiaCombo(context) {
  final provider = Provider.of<TrampeoBloc>(context, listen: false);
  return Selector<TrampeoBloc, List<LocalizacionModelo>>(
      selector: (_, provider) => provider.listaParroquia,
      builder: (_, data, w) {
        return Combo(
          key: UniqueKey(),
          value: provider.listaParroquia.isNotEmpty
              ? provider.listaParroquia[0].idGuia
              : null,
          items: provider.listaParroquia.map((e) {
            return DropdownMenuItem(
              value: e.idGuia,
              child: Text(e.nombre!),
            );
          }).toList(),
          onChanged: (dynamic valor) async {
            provider.setParroquiaLugarInstalacion = valor;
            provider.setNumeroLugarInstalacion = 0;
          },
          label: 'Parroquia',
        );
      });
}

_buildNumeroLugarInstalacion(context) {
  final provider = Provider.of<TrampeoBloc>(context, listen: false);
  return Selector<TrampeoBloc, List<Trampas>>(
      selector: (_, provider) => provider.listaNumeroLugarInstalacion,
      builder: (_, data, w) {
        return Combo(
          key: UniqueKey(),
          value: provider.listaNumeroLugarInstalacion.isNotEmpty
              ? provider.listaNumeroLugarInstalacion[0].numerolugarinstalacion
              : null,
          items: provider.listaNumeroLugarInstalacion.map((e) {
            return DropdownMenuItem(
              value: e.numerolugarinstalacion,
              child: Text(e.numerolugarinstalacion!),
            );
          }).toList(),
          onChanged: (dynamic valor) async {
            debugPrint(valor);
            provider.setNumeroLugarInstalacion =
                valor != '--' ? int.parse(valor) : 0;
            provider.setParroquiaLugarInstalacion = 0;
          },
          label: 'Número lugar de instalación',
        );
      });
}

_buildSemanaActual() {
  return CampoDescripcionBorde(
    etiqueta: 'Semana',
    valor: semana(),
  );
}

String semana() {
  return '${Jiffy().week}';
}

Widget _buildBotonNuevoRegistro(context) {
  final provider = Provider.of<TrampeoBloc>(context, listen: false);
  return Column(
    children: [
      Boton(
          texto: 'Nuevo Registro de Trampeo',
          color: const Color(0xff09c273),
          funcion: () async {
            bool valido = provider.verificarFormulario();

            if (!valido) {
              mostrarModalBottomSheet(
                context: context,
                titulo: 'Faltan datos',
                icono: _buildIconoModalSinProvincia(),
                mensaje: _buildMensajeModalSinProvincia(),
              );
              await Future.delayed(const Duration(seconds: 3));
              Get.back();
            } else {
              Get.toNamed(Rutas.TRAMPEOVFNUEVO);
            }
          }),
      const Espaciador(alto: 15)
    ],
  );
}

Widget _buildIconoModalSinProvincia() {
  return Container(
    margin: const EdgeInsets.only(top: 0.0),
    child: const Icon(
      Icons.error_outline,
      size: 75.0,
      color: Colors.redAccent,
    ),
  );
}

Widget _buildMensajeModalSinProvincia() {
  return const Expanded(
    flex: 2,
    child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'Debe completar el formulario',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
