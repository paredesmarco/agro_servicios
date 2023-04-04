import 'package:agro_servicios/app/modules/trips/controllers/trips_paso1_controller.dart';
import 'package:agro_servicios/app/modules/trips/widgets/tabla.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/combo_multiseleccion.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripsPaso1SvPage extends StatefulWidget {
  // @override
  // KeepAlive = true;
  const TripsPaso1SvPage({Key? key}) : super(key: key);

  @override
  State<TripsPaso1SvPage> createState() => _TripsPaso1SvPageState();
}

class _TripsPaso1SvPageState extends State<TripsPaso1SvPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final controladorTu = Get.find<TripsPaso1Controller>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Definir los datos de la Inspección'),
        BuildNumeroReporte(),
        BuildRazonSocial(),
        BuildSitio(),
        BuildTipoArea(),
        BuildArea(),
        BuildInformativosTabla(),
      ],
    );
  }
}

class BuildNumeroReporte extends GetView<TripsPaso1Controller> {
  const BuildNumeroReporte({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CampoDescripcionBorde(
          etiqueta: 'Numero de Reporte',
          valor: controller.numeroReporteR.value);
    });
  }
}

class BuildRazonSocial extends StatelessWidget {
  const BuildRazonSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsPaso1Controller>(
      id: 'ruc',
      builder: (_) {
        return ComboBusqueda(
          //key: UniqueKey(),
          label: 'Razon Social',
          lista: _.listaProductor,
          errorText: _.errorRazonSocial,
          selectedItem: _.getRazon,
          onChange: (valor) {
            _.getListaSitio(valor);
          },
        );
      },
    );
  }
}

class BuildSitio extends StatelessWidget {
  const BuildSitio({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsPaso1Controller>(
        id: 'sitio',
        builder: (_) {
          return Combo(
            key: UniqueKey(),
            label: 'Sitio',
            items: _.listaSitios
                .map((e) => DropdownMenuItem(
                      value: e.idSitio,
                      child: Text('${e.idSitio} - ${e.sitio}'),
                    ))
                .toList(),
            errorText: _.errorSitio,
            value: _.getSitio,
            onChanged: (valor) {
              _.getListaTipoArea(valor);
              //controller.onSelectedSitio(valor);
            },
          );
        });
  }
}

class BuildTipoArea extends StatelessWidget {
  const BuildTipoArea({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsPaso1Controller>(
        id: 'tipo',
        builder: (_) {
          return Combo(
            key: UniqueKey(),
            label: 'Tipo de Area',
            items: _.listaTipoAreas
                .map((e) => DropdownMenuItem(
                      value: e.tipoArea,
                      child: Text(e.tipoArea!),
                    ))
                .toList(),
            errorText: _.errorTipoArea,
            value: _.getTipoArea,
            onChanged: (valor) {
              _.getListaArea(valor);
            },
          );
        });
  }
}

class BuildArea extends StatelessWidget {
  const BuildArea({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsPaso1Controller>(
      id: 'areas',
      builder: (_) {
        debugPrint('entro a rebuidl area');
        return ComboMultiSeleccion(
          errorText: _.errorArea,
          label: 'Area',
          showAll: true,
          value: _.listaAreasValores,
          items: _.listaAreas
              .map((e) => ComboMultiSeleccionItem(
                    label: e.area.toString(),
                    value: e.idArea.toString(),
                  ))
              .toList(),
          onSaved: (valor) {
            _.getBuscarUbicacionAreas(valor['values']);
          },
        );
      },
    );
  }
}

class BuildUbicacion extends GetView<TripsPaso1Controller> {
  const BuildUbicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.listaAreasSelecionadas.length > 1) {
      return const BuildInformativosTabla();
    } else {
      return const BuildInformativos();
    }
  }
}

class BuildInformativosTabla extends StatelessWidget {
  const BuildInformativosTabla({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsPaso1Controller>(
        id: 'tabla',
        builder: (_) {
          return Tabla(listData: _.listaAreasSelecionadas);
        });
  }
}

class BuildInformativos extends GetView<TripsPaso1Controller> {
  const BuildInformativos({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          CampoDescripcionBorde(
              etiqueta: 'Provincia', valor: controller.provincia.value),
          CampoDescripcionBorde(
              etiqueta: 'Canton', valor: controller.canton.value),
          CampoDescripcionBorde(
              etiqueta: 'Parroquia', valor: controller.parroquia.value),
        ],
      );
    });
  }
}
