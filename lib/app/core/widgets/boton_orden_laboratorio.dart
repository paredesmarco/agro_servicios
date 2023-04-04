import 'package:flutter/material.dart';

import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

typedef OnPressCalback = void Function();

class BotonMuestraLaboratorio extends StatelessWidget {
  final String codigoMuestra;
  final String tipo;

  final bool? actualizado;
  final OnPressCalback? onPress;

  const BotonMuestraLaboratorio(
      {Key? key,
      required this.codigoMuestra,
      required this.tipo,
      this.actualizado,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: anchoPantalla * 0.04, right: anchoPantalla * 0.04, bottom: 10),
      child: Container(
        // height: 55,
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
                  const Espaciador(ancho: 8),
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color(0xFF6e7579),
                        ),
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
              const Espaciador(ancho: 25),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      codigoMuestra,
                      style: const TextStyle(
                          color: Color(0xFF6e7579), fontSize: 14),
                    ),
                    const Espaciador(
                      alto: 5,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              tipo,
                              style: const TextStyle(
                                color: Color(0xFFa2abae),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
