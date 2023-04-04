import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_controller.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_pasos_controller.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class BuscarTrampasMfSv extends SearchDelegate {
  final controlador = Get.find<TrampeoMfSvController>();
  final ctr = Get.find<TrampeoMfSvTrampasController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del Appbar
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando el usuario escribe

    final listaSugerida = (query.isEmpty)
        ? ctr.trampas
        : ctr.trampas
            .where((e) =>
                e.codigoTrampa!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return GetBuilder<TrampeoMfSvTrampasController>(
      id: 'listaTrampa',
      builder: (_) {
        return ListView.builder(
          itemCount: listaSugerida.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: _leading(listaSugerida[index].llenado),
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            listaSugerida[index].codigoTrampa!,
                            style: const TextStyle(
                                color: Colors.blueGrey, fontSize: 14),
                          ),
                          const Espaciador(
                            ancho: 10,
                          ),
                          if (!listaSugerida[index].activo!)
                            Text(
                              'Trampa Inactiva',
                              style: TextStyle(
                                  color: Colors.red[400], fontSize: 13),
                            ),
                        ],
                      ),
                      const Espaciador(
                        alto: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Acciones',
                            style: TextStyle(
                              color: Color(0xFFa2abae),
                              fontSize: 12,
                            ),
                          ),
                          const Espaciador(
                            ancho: 10,
                          ),
                          Container(
                            color: Colors.blueGrey,
                            height: 15,
                            width: 0.3,
                          ),
                          const Espaciador(
                            ancho: 10,
                          ),
                          listaSugerida[index].activo!
                              ? _botonInactivar(
                                  context, listaSugerida[index].codigoTrampa)
                              : _botonActivar(
                                  context, listaSugerida[index].codigoTrampa),
                        ],
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.north_west),
                  onTap: () {
                    close(context, null);
                    // ctr.setIndexTrampaSeleccionada = obtenerIndex(
                    //     context, listaSugerida[index].codigoTrampa);
                    Get.toNamed(Rutas.TRAMPEOMFSVDATOSTRAMPA, arguments: {
                      'parametro': ctr.trampas[obtenerIndex(
                          context, listaSugerida[index].codigoTrampa)]
                    });
                  },
                ),
                const Divider(
                  height: 1,
                )
              ],
            );
          },
        );
      },
    );
  }

  int obtenerIndex(context, codigoTrampa) {
    int indexTrampaGuardado = 0;
    ctr.trampas.asMap().forEach((i, value) {
      if (value.codigoTrampa == codigoTrampa) {
        indexTrampaGuardado = i;
      }
    });
    return indexTrampaGuardado;
  }

  Widget _leading(bool actualizado) {
    if (actualizado == false) {
      return _trampaVacia();
    } else {
      return _icono();
    }
  }

  Widget _icono() {
    return const Icon(
      Icons.check_circle,
      size: 27,
      color: Color(0xff09c273),
    );
  }

  Widget _trampaVacia() {
    return Container(
      height: 23,
      width: 23,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: const Color(0xFFDCDCDC),
        ),
      ),
    );
  }

  Widget _botonInactivar(context, var codigoTrampa) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              'Inactivar',
              style: TextStyle(color: Color(0xFFa2abae), fontSize: 11),
            ),
          ),
        ),
        onTap: () {
          ctr.inactivarTrampa(ctr.obtenerIndexTrampa(codigoTrampa));
        },
      ),
    );
  }

  Widget _botonActivar(context, var codigoTrampa) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              'Activar',
              style: TextStyle(color: Color(0xFFa2abae), fontSize: 11),
            ),
          ),
        ),
        onTap: () {
          ctr.activarTrampa(ctr.obtenerIndexTrampa(codigoTrampa));
        },
      ),
    );
  }
}
