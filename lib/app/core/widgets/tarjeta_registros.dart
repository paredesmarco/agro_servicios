import 'package:flutter/material.dart';

import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/common/colores.dart';

class TarjetaRegistros extends StatelessWidget {
  final String? titulo;
  final List<Widget> children;
  final VoidCallback? onTap;
  const TarjetaRegistros(
      {Key? key, this.titulo, required this.children, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 6.0, bottom: 6.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color(0xFFefefef),
                    offset: Offset(0.0, 0.0),
                    blurRadius: 20.0),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              titulo ?? '',
                              style: EstilosTextos.tituloTarjetas,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: Column(
                      children: children,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextosTarjetas extends StatelessWidget {
  final String? contenido;
  final String etiqueta;
  const TextosTarjetas({Key? key, this.contenido, required this.etiqueta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.40,
          child: Text(etiqueta, style: const TextStyle(color: Colores.divider)),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.46,
          child: Text(
            contenido == null ? '' : contenido!,
            style: TextStyle(color: Colors.grey.shade500),
          ),
        )
      ],
    );
  }
}
