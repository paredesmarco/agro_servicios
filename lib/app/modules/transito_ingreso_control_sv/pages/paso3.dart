import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_internacional_sv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IngresoControlSvPaso3 extends StatefulWidget {
  const IngresoControlSvPaso3({Key? key}) : super(key: key);

  @override
  State<IngresoControlSvPaso3> createState() => _IngresoControlSvPaso1State();
}

class _IngresoControlSvPaso1State extends State<IngresoControlSvPaso3>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Tránsito Internacional'),
        _PaisOrigen(),
        _PaisProcedencia(),
        _PaisDestino(),
        _PuntoIngreso(),
        _PuntoSalida(),
        _Placa(),
        _DDA(),
        _Precinto(),
        Espaciador(alto: 60),
      ],
    );
  }
}

class _PaisOrigen extends StatelessWidget {
  const _PaisOrigen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<TransitoIngresoInternacionalControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          errorText: _.errorPaisOrigen,
          label: 'País de origen',
          lista: _.listaPaisOrigen.map((e) => '${e.nombre}').toList(),
          onChange: (valor) {
            _.paisOrigen = valor;
          },
        );
      },
    );
  }
}

class _PaisProcedencia extends StatelessWidget {
  const _PaisProcedencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<TransitoIngresoInternacionalControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          errorText: _.errorPaisOrigen,
          label: 'País de procedencia',
          lista: _.listaPaisOrigen.map((e) => '${e.nombre}').toList(),
          onChange: (valor) {
            _.paisProcedencia = valor;
          },
        );
      },
    );
  }
}

class _PaisDestino extends StatelessWidget {
  const _PaisDestino({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<TransitoIngresoInternacionalControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          errorText: _.errorPaisDestino,
          label: 'País de destino',
          lista: _.listaPaisesCatalogo.map((e) => '${e.nombre}').toList(),
          onChange: (valor) {
            _.paisDestino = valor;
          },
        );
      },
    );
  }
}

class _PuntoIngreso extends StatelessWidget {
  const _PuntoIngreso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<TransitoIngresoInternacionalControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          errorText: _.errorPuntoIngreso,
          label: 'Punto de ingreso',
          lista: _.listaPuertosIngreso.map((e) => '${e.nombre}').toList(),
          onChange: (valor) {
            _.puntoIngreso = valor;
          },
        );
      },
    );
  }
}

class _PuntoSalida extends StatelessWidget {
  const _PuntoSalida({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<TransitoIngresoInternacionalControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          errorText: _.errorPuntoSalida,
          label: 'Punto de salida',
          lista: _.listaPuertosSalida.map((e) => '${e.nombre}').toList(),
          onChange: (valor) {
            _.puntoSalida = valor;
          },
        );
      },
    );
  }
}

class _Placa extends StatelessWidget {
  const _Placa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransitoIngresoInternacionalControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
            textCapitalization: TextCapitalization.characters,
            errorText: _.errorPlacaVehiculo,
            maxLength: 100,
            onChanged: (valor) {
              _.placaVehiculo = valor;
            },
            label: 'Placa del vehículo');
      },
    );
  }
}

class _DDA extends StatelessWidget {
  const _DDA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransitoIngresoInternacionalControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
            errorText: _.errorDDA,
            maxLength: 25,
            onChanged: (valor) {
              _.dda = valor;
            },
            label: '# DDA');
      },
    );
  }
}

class _Precinto extends StatelessWidget {
  const _Precinto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransitoIngresoInternacionalControlSvController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
            maxLength: 100,
            errorText: _.errorPrecinto,
            onChanged: (valor) {
              _.precinto = valor;
            },
            label: '# Precinto/Sticker');
      },
    );
  }
}
