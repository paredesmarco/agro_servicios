import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_lugar_inspeccion_control_sv_controller.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_embalaje_control_sv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EmbalajeControlPaso1 extends StatefulWidget {
  const EmbalajeControlPaso1({Key? key}) : super(key: key);

  @override
  State<EmbalajeControlPaso1> createState() => _EmbalajeControlPaso1State();
}

class _EmbalajeControlPaso1State extends State<EmbalajeControlPaso1>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Lugar de inspección'),
        _PuntoControl(),
        _AreaInspeccion(),
        _IdentidadEmbalaje(),
        _PaisOrigen(),
        NombreSeccion(etiqueta: 'Datos del muestreo'),
        _NumeroEmbalajes(),
        _NumeroUnidades(),
        Espaciador(alto: 20),
      ],
    );
  }
}

class _PuntoControl extends StatelessWidget {
  const _PuntoControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<EmbalajeLugarInspeccionControlSvController>(
      id: 'idPuntoControl',
      builder: (_) {
        return Combo(
          errorText: _.errorPuntoControl,
          items: _.puertos.map((e) {
            return DropdownMenuItem(value: e.idPuerto, child: Text(e.nombre!));
          }).toList(),
          label: 'Punto de control',
          onChanged: (valor) {
            _.getCatalogLugaresInspeccion(valor);
            _.puntoControl = valor;
          },
        );
      },
    );
  }
}

class _AreaInspeccion extends StatelessWidget {
  const _AreaInspeccion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<EmbalajeLugarInspeccionControlSvController>(
      id: 'idAreaInspeccion',
      builder: (_) {
        return Combo(
          key: UniqueKey(),
          value: _.valueAreaInspeccion,
          errorText: _.errorAreaInspeccion,
          items: _.lugaresInspeccion.map((e) {
            return DropdownMenuItem(value: e.nombre, child: Text(e.nombre!));
          }).toList(),
          label: 'Área de inspección/bodega',
          onChanged: (valor) {
            _.areaInspeccion = valor;
            _.valueAreaInspeccion = valor;
          },
        );
      },
    );
  }
}

class _IdentidadEmbalaje extends StatelessWidget {
  const _IdentidadEmbalaje({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLugarInspeccionControlSvController>(
      id: 'idIdentidad',
      builder: (_) {
        return Combo(
          errorText: _.errorIndetidadEmbalaje,
          items: CatalogosEmbalajeControlSv().getIdentidadEmbalaje(),
          label: 'Identidad del embalaje',
          onChanged: (valor) {
            _.identidadEmbalaje = valor;
          },
        );
      },
    );
  }
}

class _PaisOrigen extends StatelessWidget {
  const _PaisOrigen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<EmbalajeLugarInspeccionControlSvController>(
      id: 'idPaisOrigen',
      builder: (_) {
        return ComboBusqueda(
          errorText: _.errorPaisOrigen,
          label: 'País de origen',
          lista: _.paises.map((e) => '${e.nombre}').toList(),
          onChange: (valor) {
            _.paisOrigen = valor;
          },
        );
      },
    );
  }
}

class _NumeroEmbalajes extends StatelessWidget {
  const _NumeroEmbalajes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLugarInspeccionControlSvController>(
      id: 'idNumeroEmbalaje',
      builder: (_) {
        return CampoTexto(
            maxLength: 8,
            errorText: _.errorNumeroEmbalaje,
            keyboardType: TextInputType.number,
            textInputFormatter: [
              FilteringTextInputFormatter.allow(RegExp(r'([0-9])'))
            ],
            onChanged: (valor) {
              _.numeroEmbalajes = int.tryParse(valor);
            },
            label: 'Número de embalajes que componen el envío');
      },
    );
  }
}

class _NumeroUnidades extends StatelessWidget {
  const _NumeroUnidades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmbalajeLugarInspeccionControlSvController>(
      id: 'idNumeroInspeccion',
      builder: (_) {
        return CampoTexto(
            maxLength: 8,
            errorText: _.errorNumeroUnidades,
            keyboardType: TextInputType.number,
            textInputFormatter: [
              FilteringTextInputFormatter.allow(RegExp(r'([0-9])'))
            ],
            onChanged: (valor) {
              _.numeroUnidades = int.tryParse(valor);
            },
            label: 'Número de unidades inspeccionadas');
      },
    );
  }
}
