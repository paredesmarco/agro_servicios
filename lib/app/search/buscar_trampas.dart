import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:agro_servicios/app/data/models/trampeo_sv/trampas_modelo.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';

class BuscarTrampas extends SearchDelegate {
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
    final provider = Provider.of<TrampeoBloc>(context, listen: false);

    final listaSugerida = (query.isEmpty)
        ? provider.listaTrampas
        : provider.listaTrampas
            .where((e) =>
                e.codigotrampa!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Selector<TrampeoBloc, Tuple3<List<Trampas>, int, int>>(
        selector: (_, provider) => Tuple3(
            provider.listaTrampas,
            provider.cantidadTrampasLlenadas,
            provider.cantidadTrampasInactivadas),
        builder: (_, data, w) {
          return ListView.builder(
              itemCount: listaSugerida.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      // dense: true,
                      // contentPadding:
                      //     EdgeInsets.symmetric(vertical: 2, horizontal: -10),
                      leading: _leading(listaSugerida[index].llenado),

                      title: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                listaSugerida[index].codigotrampa!,
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
                                  ? _botonInactivar(context,
                                      listaSugerida[index].codigotrampa)
                                  : _botonActivar(context,
                                      listaSugerida[index].codigotrampa),
                            ],
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.north_west),
                      onTap: () {
                        close(context, null);
                        provider.setTrampaSeleccionada = obtenerIndex(
                            context, listaSugerida[index].codigotrampa);
                        Get.toNamed(Rutas.TRAMPEOVFINGRESO);
                      },
                    ),
                    const Divider(
                      height: 1,
                    )
                  ],
                );
              });
        });
  }

  obtenerIndex(context, codigoTrampa) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);

    int indexTrampaGuardado = 0;

    provider.listaTrampas.asMap().forEach((i, value) {
      debugPrint('$i ${value.codigotrampa} == $codigoTrampa');
      if (value.codigotrampa == codigoTrampa) {
        indexTrampaGuardado = i;
      }
    });
    return indexTrampaGuardado;
  }

  _leading(bool actualizado) {
    debugPrint('$actualizado');
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
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: const BoxDecoration(
              // border: Border.all(
              //     width: 0.5, color: Color(0xFFa2abae)),
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
          provider.setTrampaSeleccionada =
              provider.obtenerIndexTrampa(codigoTrampa);
          provider.inactivarTrampa(provider.obtenerIndexTrampa(codigoTrampa));
        },
      ),
    );
  }

  Widget _botonActivar(context, var codigoTrampa) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: const BoxDecoration(
              // border: Border.all(
              //     width: 0.5, color: Color(0xFFa2abae)),
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
          provider.setTrampaSeleccionada =
              provider.obtenerIndexTrampa(codigoTrampa);
          provider.activarTrampa(provider.obtenerIndexTrampa(codigoTrampa));
        },
      ),
    );
  }
}
