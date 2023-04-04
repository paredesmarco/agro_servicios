import 'package:agro_servicios/app/modules/trips/controllers/trips_ver_controller.dart';
import 'package:agro_servicios/app/modules/trips/widgets/texto_informacion.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/common/colores.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripsVerSv extends StatelessWidget {
  TripsVerSv({Key? key}) : super(key: key);
  final controlador = Get.find<TripsVerController>();

  @override
  Widget build(BuildContext context) {
    return const CuerpoFormularioIngreso(
      titulo: 'Datos Registrados',
      widgets: [
        // BuildTextoExplicativo(),
        BuildFormulariosLista(),
      ],
    );
  }
}

class BuildFormulariosLista extends StatelessWidget {
  const BuildFormulariosLista({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsVerController>(
        id: 'ver',
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,

            // children:_.listTripsView.map((e) =>ListTile(title: Text(e.ruc.toString())))

            children: _.listTripsView
                .map((e) => Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            trailing: BuildIconoPq(tipo: '${e.estadoF09}'),
                            title: Text(
                              '${e.id} - ${e.razonSocial}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                            subtitle: Text(
                              '${e.ruc}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colores.gradient2),
                            ),
                          ),
                          TextoInformacion(
                              etiqueta: 'Ubicación',
                              contenido:
                                  '${e.provincia}, ${e.canton}, ${e.parroquia}'),
                          TextoInformacion(
                              etiqueta: 'Número Reporte',
                              contenido: e.numeroReporte.toString()),
                          TextoInformacion(
                              etiqueta: 'Sitio',
                              contenido: e.sitioProduccion.toString()),
                          TextoInformacion(
                              etiqueta: 'Area Seleccionadas',
                              contenido: '${e.totalAreas}'),
                          TextoInformacion(
                              etiqueta: 'Tipo Area',
                              contenido: e.tipoArea.toString()),
                          TextoInformacion(
                              etiqueta: 'Resultado',
                              contenido: e.resultado.toString()),
                          TextoInformacion(
                              etiqueta: 'Estado',
                              contenido: e.estadoF09.toString()),
                        ],
                      ),
                    ))
                .toList(),
          );
        });
  }
}

class BuildIconoPq extends StatelessWidget {
  final String tipo;
  const BuildIconoPq({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(context) {
    if (tipo == 'activo') {
      return Icon(Icons.check, color: Colors.grey[600]);
    } else {
      return const Icon(Icons.edit_sharp, color: Colores.gradient2);
    }
  }
}

class BuildTextoExplicativo extends StatelessWidget {
  const BuildTextoExplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsVerController>(
        id: 'ruc',
        builder: (_) {
          int codiguito = 0;
          _.listTripsView.map((e) => codiguito++);

          return NombreSeccion(etiqueta: 'Inspecciones Realizadas:$codiguito');
        });
  }
}
