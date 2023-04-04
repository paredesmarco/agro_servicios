import 'package:flutter/material.dart';

import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/common/comunes.dart';

class TarjetaPopup extends StatelessWidget {
  final Object? idHero;
  final List<Widget> children;
  final String? titulo;
  const TarjetaPopup(
      {required this.idHero, required this.children, this.titulo, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: '$idHero',
        child: Container(
          width: anchoPantalla * 0.9,
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 16.0, right: 16.0, bottom: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            titulo ?? ORDEN_LABORATORIO,
                            style: EstilosTextos.tituloTarjetas,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    Column(
                      children: children,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Aceptar',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextosTarjetaPopup extends StatelessWidget {
  final String? contenido;
  final String etiqueta;
  const TextosTarjetaPopup({Key? key, this.contenido, required this.etiqueta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child:
                Text(etiqueta, style: const TextStyle(color: Colores.divider)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.42,
            child: Text(
              contenido == null ? '' : contenido!,
              style: TextStyle(color: Colors.grey.shade500),
            ),
          )
        ],
      ),
    );
  }
}
