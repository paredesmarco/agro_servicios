import 'package:flutter/material.dart';

import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

typedef OnPressCalback = void Function();

class BotonTarjeta extends StatelessWidget {
  final OnPressCalback? onPress;
  final Icon? icono;
  final List<TextosBotontarjeta> children;

  const BotonTarjeta({
    Key? key,
    this.onPress,
    required this.children,
    this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: const Color(0xffdfdfdf).withOpacity(0.5), width: 0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
                color: const Color(0xffdfdfdf).withOpacity(0.5),
                offset: const Offset(5.0, 5.0),
                spreadRadius: 0.1,
                blurRadius: 5.0)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Row(
                children: [
                  // Espaciador(ancho: 8),
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: icono ??
                            const Icon(Icons.delete,
                                color: Colores.radio_chechbox),
                        onPressed: onPress,
                      ),
                    ),
                  ),
                ],
              ),
              const Espaciador(ancho: 8),
              Container(
                color: Colors.blueGrey,
                height: 30,
                width: 0.3,
              ),
              const Espaciador(ancho: 23),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextosBotontarjeta extends StatelessWidget {
  final String etiqueta;
  final String? contenido;
  const TextosBotontarjeta({Key? key, required this.etiqueta, this.contenido})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text.rich(
            TextSpan(
              text: '$etiqueta ',
              style: EstilosTextos.textoEtiquetasCards,
              children: <InlineSpan>[
                TextSpan(
                  text: '$contenido',
                  style: EstilosTextos.textoDescripcionCard,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
