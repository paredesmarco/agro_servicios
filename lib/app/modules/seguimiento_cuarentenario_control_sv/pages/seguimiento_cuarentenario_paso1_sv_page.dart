import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_paso1_sv_controller.dart';
import 'package:agro_servicios/app/utils/catalogos/catologos_seguimiento_control_sv.dart';

class SeguimientoCuarentenarioPaso1SvPage extends StatefulWidget {
  const SeguimientoCuarentenarioPaso1SvPage({Key? key}) : super(key: key);

  @override
  State<SeguimientoCuarentenarioPaso1SvPage> createState() =>
      _SeguimientoCuarentenarioPaso1SvPageState();
}

class _SeguimientoCuarentenarioPaso1SvPageState
    extends State<SeguimientoCuarentenarioPaso1SvPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Ubicación'),
        _RasonSocial(),
        _PaisOrigen(),
        _Producto(),
        _SubtipoProducto(),
        _Peso(),
        _NumeroPlantasIngreso(),
        _Provincia(),
        _Canton(),
        _Parroquia(),
        _NombreScpe(),
        _TipoOperacion(),
        _TipoCuarentena(),
        _FaseSeguimiento(),
        _CodigoLote(),
        Espaciador(alto: 30),
      ],
    );
  }
}

class _RasonSocial extends GetView<SeguimientoCuarentenarioPaso1SvController> {
  const _RasonSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CampoDescripcionBorde(
      etiqueta: 'Razón social',
      valor: controller.solicitud!.razonSocial!,
    );
  }
}

class _PaisOrigen extends GetView<SeguimientoCuarentenarioPaso1SvController> {
  const _PaisOrigen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CampoDescripcionBorde(
      etiqueta: 'País de origen',
      valor: controller.solicitud!.paisOrigen!,
    );
  }
}

class _SubtipoProducto
    extends GetView<SeguimientoCuarentenarioPaso1SvController> {
  const _SubtipoProducto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CampoDescripcionBorde(
      etiqueta: 'Producto',
      valor: controller.solicitud!.solicitudProductos![0].producto!,
    );
  }
}

class _Producto extends GetView<SeguimientoCuarentenarioPaso1SvController> {
  const _Producto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CampoDescripcionBorde(
      etiqueta: 'Subtipo de producto',
      valor: controller.solicitud!.solicitudProductos![0].subtipo!,
    );
  }
}

class _Peso extends GetView<SeguimientoCuarentenarioPaso1SvController> {
  const _Peso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CampoDescripcionBorde(
      etiqueta: 'Peso (Kg)',
      valor: controller.solicitud!.solicitudProductos![0].peso.toString(),
    );
  }
}

class _NumeroPlantasIngreso
    extends GetView<SeguimientoCuarentenarioPaso1SvController> {
  const _NumeroPlantasIngreso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CampoDescripcionBorde(
      etiqueta: 'Número plantas ingreso',
      valor: controller.solicitud!.numeroPlantasIngreso.toString(),
    );
  }
}

class _Provincia extends StatelessWidget {
  const _Provincia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<SeguimientoCuarentenarioPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorProvincia,
          items: _.listaProvincias
              .map((e) => DropdownMenuItem(
                    value: e.idGuia,
                    child: Text(e.nombre!),
                  ))
              .toList(),
          label: 'Provincia',
          onChanged: (valor) async {
            _.setProvincia(valor);
            await _.obtenerListaCantones(valor);
          },
        );
      },
    );
  }
}

class _Canton extends StatelessWidget {
  const _Canton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<SeguimientoCuarentenarioPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorCanton,
          key: UniqueKey(),
          value: _.canton,
          items: _.listaCantones
              .map((e) => DropdownMenuItem(
                    value: e.idGuia,
                    child: Text(e.nombre!),
                  ))
              .toList(),
          label: 'Cantón',
          onChanged: (valor) {
            _.obtenerListaParroquias(valor);
            _.setCanton(valor);
          },
        );
      },
    );
  }
}

class _Parroquia extends StatelessWidget {
  const _Parroquia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<SeguimientoCuarentenarioPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorParroquia,
          key: UniqueKey(),
          value: _.parroquia,
          items: _.listaParroquias
              .map((e) => DropdownMenuItem(
                    value: e.idGuia,
                    child: Text(e.nombre!),
                  ))
              .toList(),
          label: 'Parroquia',
          onChanged: (valor) {
            _.setParroquia(valor);
          },
        );
      },
    );
  }
}

class _NombreScpe extends StatelessWidget {
  const _NombreScpe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<SeguimientoCuarentenarioPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorNombreScpe,
          items: _.listaAreas
              .map((e) => DropdownMenuItem(
                    value: e.idGuia,
                    child: Text(e.nombreLugar!),
                  ))
              .toList(),
          label: 'Nombre del SCPE',
          onChanged: (valor) async {
            _.obtenerAreaCuarentena(valor);
          },
        );
      },
    );
  }
}

class _TipoOperacion extends StatelessWidget {
  const _TipoOperacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorTipoOperacion,
          items: CatalogosSeguimientoControlSv().getTipoOperacionDropDown(),
          label: 'Tipo de operación',
          onChanged: (valor) {
            _.tipoOperacion = valor;
          },
        );
      },
    );
  }
}

class _TipoCuarentena extends StatelessWidget {
  const _TipoCuarentena({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorTipoCuarentena,
          items: CatalogosSeguimientoControlSv().getTipoCuarentenaDropDown(),
          label: 'Tipo cuarentena/condición de producción',
          onChanged: (valor) {
            _.tipoCuarentena = valor;
          },
        );
      },
    );
  }
}

class _FaseSeguimiento extends StatelessWidget {
  const _FaseSeguimiento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeguimientoCuarentenarioPaso1SvController>(
      id: 'idValidacion',
      builder: (_) {
        return Combo(
          errorText: _.errorFaseSeguimiento,
          items: CatalogosSeguimientoControlSv().getFaseSeguimientoDropDown(),
          label: 'Fase del seguimiento',
          onChanged: (valor) {
            _.faseSeguimiento = valor;
          },
        );
      },
    );
  }
}

class _CodigoLote extends GetView<SeguimientoCuarentenarioPaso1SvController> {
  const _CodigoLote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CampoTexto(
      initialValue: controller.solicitud!.idVue,
      maxLength: 250,
      errorText: controller.errorCodigoLote,
      onChanged: (valor) {},
      label: 'Código Lote',
      enable: false,
    );
  }
}
